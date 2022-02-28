import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerScreen extends StatefulWidget {
  String videoUrl;

  VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController videoController;
  bool microIcon = false;
  bool displayPlayBtn = true;
  bool displayParams = false;

  //late ChewieController chewieController;
  //late Chewie playerWidget;

  @override
  void initState() {
    videoController = VideoPlayerController.network(
        widget.videoUrl,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) => videoController.play()
      )
    ;


    /*videoController = VideoPlayerController.network(
        widget.videoUrl,videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));

    chewieController = ChewieController(
      videoPlayerController: videoController,
      autoPlay: false,
      looping: true,
      autoInitialize: true,
      showControlsOnInitialize: false,
      errorBuilder: (context, errMsg){
        return const Center(child: Text('Something went wrong'));
      }
    );

    playerWidget = Chewie(
      controller: chewieController,
    );

     */

    super.initState();
  }

  @override
  void dispose() {
    videoController.dispose();
    //chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            GestureDetector(
                child: VideoPlayer(videoController),
              onTap: ()=> {
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
            Visibility(
              visible: displayParams,
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                    onTap: (){
                      setState(() {
                        displayPlayBtn ? videoController.pause() : videoController.play();
                        displayPlayBtn = !displayPlayBtn;
                      });
                    },
                    child: Icon(
                      displayPlayBtn ? Icons.pause_circle_outline_outlined : Icons.play_circle_outline,
                      size: 100, color: Colors.white,)
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                child: Icon(
                  microIcon ? Icons.volume_down_rounded  : Icons.volume_off_rounded,
                  size: 35,
                  color: Colors.white,
                ),
                onTap: (){
                  setState(() {
                    microIcon ? videoController.setVolume(0) : videoController.setVolume(1);
                    microIcon = !microIcon;
                  });
                },
              ),
            )
          ],
        )
    );
    //return Chewie(controller: chewieController);
  }
}
