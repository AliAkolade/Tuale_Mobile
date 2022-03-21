import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerScreen extends StatefulWidget {
  String videoUrl;
  bool enablePlayBtn;
  bool initVideoPlay;
  late final Function(VideoPlayerController) cbController;

  VideoPlayerScreen(
      {Key? key,
      required this.videoUrl,
      this.enablePlayBtn = false,
      this.initVideoPlay = true,
      required this.cbController})
      : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController videoController;
  bool microIcon = true;
  bool displayPlayBtn = true;
  bool displayParams = false;

  @override
  void initState() {
    videoController = VideoPlayerController.network(widget.videoUrl,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..setLooping(true)
      ..setVolume(0.1)
      ..initialize().then((_) => widget.initVideoPlay ? videoController.play() : videoController.pause()); //:videoController.play());

    super.initState();
  }

  @override
  void dispose() {
    debugPrint("dispose : ${widget.enablePlayBtn}");
    //widget.cbController(videoController);
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      widget.cbController(videoController);
    });

    return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            GestureDetector(
              child: VideoPlayer(videoController),
              onTap: () => {
                setState(() {
                  displayParams = !displayParams;
                }),
                // TODO : try to hidden displayParams after 5 seconds
                /*Future.delayed(
                    const Duration(seconds: 5), (){
                    setState(() {
                      displayParams = false;
                    });
                  }
                )*/
              },
            ),
            if (widget.enablePlayBtn) ...[
              Visibility(
                visible: displayParams,
                child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          displayPlayBtn
                              ? videoController.pause()
                              : videoController.play();
                          displayPlayBtn = !displayPlayBtn;
                        });
                      },
                      child: Icon(
                        displayPlayBtn
                            ? Icons.pause_circle_outline_outlined
                            : Icons.play_circle_outline,
                        size: 100,
                        color: Colors.white,
                      )),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: GestureDetector(
                  child: Icon(
                    microIcon
                        ? Icons.volume_down_rounded
                        : Icons.volume_off_rounded,
                    size: 35,
                    color: Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      microIcon
                          ? videoController.setVolume(0)
                          : videoController.setVolume(1);
                      microIcon = !microIcon;
                    });
                  },
                ),
              )
            ]
          ],
        ));
    //return Chewie(controller: chewieController);
  }
}
