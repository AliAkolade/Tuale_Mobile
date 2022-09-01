import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:mobile/screens/imports.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:video_compress/video_compress.dart';

class PostTimeline extends StatefulWidget {
  File fileContent;
  String filePath;
  String mediaType;

  PostTimeline(
      {Key? key,
      required this.fileContent,
      required this.filePath,
      required this.mediaType})
      : super(key: key);

  @override
  _PostTimelineState createState() => _PostTimelineState();
}

class _PostTimelineState extends State<PostTimeline> {
  late VideoPlayerController videoController;
  late TextEditingController description;
  MediaInfo? mediainfo;
  bool playVideo = false;
  final cloudinary = CloudinaryPublic(cloudName, uploadPreset, cache: false);
  double uploadingPercentage = 0;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.mediaType == "video") {
      videoController = VideoPlayerController.file(widget.fileContent,
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
        ..setLooping(true)
        ..setVolume(1)
        ..initialize().then((_) => videoController.pause());
    }
    description = TextEditingController();
    super.initState();
  }

  makePost() async {
    debugPrint("description :${description.text}");
    debugPrint("asset :${widget.filePath}");

    ProgressDialog pd = ProgressDialog(context: context);

    try {
      pd.show(
        max: 100,
        msg: 'Loading ...',
      );
      pd.update(value: 0);
      if (widget.mediaType != 'image') {
        mediainfo = await VideoCompress.compressVideo(widget.filePath,
            quality: VideoQuality.MediumQuality, deleteOrigin: false);
      }

      CloudinaryResponse response = await cloudinary.uploadFile(
          widget.mediaType == "image"
              ? CloudinaryFile.fromFile(widget.filePath,
                  folder: "Tuale posts",
                  resourceType: CloudinaryResourceType.Image)
              : CloudinaryFile.fromFile(mediainfo!.path!,
                  folder: "Tuale posts",
                  resourceType: CloudinaryResourceType.Video),
          onProgress: (count, total) {
        setState(() {
          uploadingPercentage = (count / total) * 100;
          pd.update(value: uploadingPercentage.toInt());
          debugPrint("uploadingPercentage : $uploadingPercentage");
        });
        // TODO : try  to display loader percentage
      });

      debugPrint("Cloudres : " + response.toString());

      if (response.secureUrl != "") {
        String publicId = response.publicId;
        String url = response.secureUrl;
        String desc = description.text.isNotEmpty ? description.text : "";
        String mediaType = widget.mediaType;

        //debugPrint("secureUrl : ${response.secureUrl}");
        debugPrint("public : $publicId || url : $url || desc $desc");
        var result = await Api().makeNewPost(mediaType, publicId, url, desc);
        if (result[0]) {
          debugPrint(result[1]);
          showSnackBar(result[1], result[0]);
          // TODO : Everything pass so redirect to homepage and refresh comonent
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => NavBar(
                      index: 0,
                      initIndex: 0,
                      deepLinkPath: '',
                      deepLinkId: '',
                      deepLink: false)),
            );
          });
          //Navigator.pop(context);
        } else {
          debugPrint("Err : " + result[1]);
          var deletePic = await Api().deletePostCl(publicId);
          debugPrint("deletePic : $deletePic");
          showSnackBar(result[1], result[0]);
        }
        pd.close();
      } else {
        pd.close();
        debugPrint("Something went wrong, retry");
      }
    } on CloudinaryException catch (e) {
      pd.close();
      debugPrint("Cloudinary Err : ${e.message}");
    }
  }

  showSnackBar(String msg, bool success) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: success ? Colors.green : tualeOrange,
      duration: const Duration(seconds: 5),
      padding: const EdgeInsets.all(20),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            //Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => NavBar(
                      index: 0,
                      initIndex: 1,
                      deepLinkPath: '',
                      deepLinkId: '',
                      deepLink: false)),
            );
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
        actions: const [
          Icon(
            Icons.more_vert_rounded,
            color: Colors.black,
          )
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Post to timeline",
          style: TextStyle(
              color: tualeBlueDark,
              fontFamily: 'Poppins',
              fontSize: 20.sp,
              // fontWeight: FontWeight.bold,
              height: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.grey.withOpacity(0.3)),
                      bottom: BorderSide(color: Colors.grey.withOpacity(0.9)))),
              child: widget.mediaType == "image"
                  ? SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: widget.filePath != ""
                          ? Image.file(widget.fileContent)
                          : const Image(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/demoPost.png")),
                    )
                  : Stack(
                      children: [
                        SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: GestureDetector(
                            child: VideoPlayer(videoController),
                            onTap: () {
                              if (playVideo == false) {
                                videoController.play();
                              } else {
                                videoController.pause();
                              }
                              if (mounted) {
                                setState(() {
                                  playVideo = !playVideo;
                                });
                              }
                            },
                          ),
                        ),
                        if (widget.mediaType != "image")
                          Visibility(
                            visible: !playVideo,
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.play_circle_outline,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              padding: const EdgeInsets.all(5),
              child: TextField(
                maxLines: 6,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Caption',
                ),

                // decoration: InputDecoration(
                //   contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 2),
                //   enabledBorder: OutlineInputBorder(
                //     borderSide: const BorderSide(
                //         style: BorderStyle.solid, color: Colors.grey),
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                //   focusedBorder: OutlineInputBorder(
                //     borderSide: const BorderSide(
                //         style: BorderStyle.solid, color: Colors.grey),
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                // ),
                controller: description,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  Container(
                    height: 32.h,
                    width: 150.w,
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey)),
                    child: Text(
                      '# Recent Hashtags ',
                      style: TextStyle(
                          fontFamily: "Roboto", fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    width: 32.w,
                  ),
                  Container(
                    height: 32.h,
                    width: 110.w,
                    margin: EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey)),
                    child: Text(
                      '@ Tag People',
                      style: TextStyle(
                          fontFamily: "Roboto", fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey),
              )),
              child: Text(
                "Dear User, We can only support portrait photos with an aspect ratio of 2:3 fro now. We are working hard to fix this. We appreciate your understanding.",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),

            /*Container(
              padding: const EdgeInsets.all(5),
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Privacy Settings",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.black.withOpacity(0.8)),
                  ),
                  Icon(Icons.arrow_forward)
                ],
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.all(5),
              child: Center(
                child: ElevatedButton(
                    onPressed: () {
                      makePost();
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(230, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text('Post',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Poppins',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            height: 1))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
