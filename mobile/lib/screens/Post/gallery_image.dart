




import 'package:mobile/screens/imports.dart';

// class gallery extends StatefulWidget {
//   @override

//   @override
//   State<gallery> createState() => _galleryState();

// }

// class _galleryState extends State<gallery> {

//   @override
//   void initState() {
//     super.initState();
//        setState(() {

//   // camera.hideNav = true;
//   // print(camera.hideNav);
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Photo Manager Demo',
//       home: Material(
//         child: Center(
//           child: Builder(
//             builder: (context) {
//               return RaisedButton(
//                 onPressed: () async {
//                   final permitted = await PhotoManager.requestPermission();
//                   if (!permitted) return;
//                   Navigator.of(context).push(
//                     MaterialPageRoute(builder: (_) => Gallery()),
//                   );
//                 },
//                 child: Text('Open Gallery'),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

class GalleryImage extends StatefulWidget {
  @override
  _GalleryImageState createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  // This will hold all the assets we fetched
  List<AssetEntity> assets = [];

  @override
  void initState() {
    _fetchAssets();

    super.initState();
  }

  _fetchAssets() async {
    // Set onlyAll to true, to fetch only the 'Recent' album
    // which contains all the photos/videos in the storage
    final albums = await PhotoManager.getAssetPathList(onlyAll: true, type: RequestType.image);
    final recentAlbum = albums.first;

    // Now that we got the album, fetch all the assets it contains
    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0, // start at index 0
      end: 1000000, // end at a very big index (to get all the assets)
    );

    // Update the state and notify UI
    setState(() => assets = recentAssets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          // A grid view with 3 items per row
          crossAxisCount: 3,
        ),
        itemCount: assets.length,
        itemBuilder: (_, index) {
          return AssetThumbnail(asset: assets[index]);
        },
      ),
    );
  }
}

class AssetThumbnail extends StatelessWidget {
  final AssetEntity? asset;

  AssetThumbnail({
    Key? key,
    @required this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We're using a FutureBuilder since thumbData is a future
    return FutureBuilder<Uint8List?>(
      future: asset!.thumbnailData,
      builder: (_, snapshot) {
        final bytes = snapshot.data;
        // If we have no data, display a spinner
        if (bytes == null) return CircularProgressIndicator();
        // If there's data, display it as an image
        return InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) {
            //       if (asset!.type == AssetType.image) {
            //         // If this is an image, navigate to ImageScreen
            //         return ImageScreen(imageFile: asset!.file);
            //       } else {
            //         // if it's not, navigate to VideoScreen
            //         return VideoScreen(videoFile: asset!.file);
            //       }
            //     },
            //   ),
            // );
          },
          child: Stack(
            children: [
              // Wrap the image in a Positioned.fill to fill the space
              Positioned.fill(
                child: Image.memory(bytes, fit: BoxFit.cover),
              ),
              // Display a Play icon if the asset is a video
              if (asset!.type == AssetType.video)
                Center(
                  child: Container(
                    color: Colors.blue,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class ImageScreen extends StatelessWidget {
  const ImageScreen({
    Key? key,
    @required this.imageFile,
  }) : super(key: key);

  final Future<File?>? imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: FutureBuilder<File?>(
        future: imageFile,
        builder: (_, snapshot) {
          final file = snapshot.data;
          if (file == null) return Container();
          return Image.file(file);
        },
      ),
    );
  }
}

// class VideoScreen extends StatefulWidget {
//   const VideoScreen({
//     Key? key,
//     @required this.videoFile,
//   }) : super(key: key);

//   final Future<File?>? videoFile;

//   @override
//   _VideoScreenState createState() => _VideoScreenState();
// }

// class _VideoScreenState extends State<VideoScreen> {
//   VideoPlayerController? _controller;
//   bool initialized = false;

//   @override
//   void initState() {
//     _initVideo();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller!.dispose();
//     super.dispose();
//   }

//   _initVideo() async {
//     final video = await widget.videoFile;
//     _controller = VideoPlayerController.file(video!)
//       // Play the video again when it ends
//       ..setLooping(true)
//       // initialize the controller and notify UI when done
//       ..initialize().then((_) => setState(() => initialized = true));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: initialized
//           // If the video is initialized, display it
//           ? Scaffold(
//               body: Center(
//                 child: AspectRatio(
//                   aspectRatio: _controller!.value.aspectRatio,
//                   // Use the VideoPlayer widget to display the video.
//                   child: VideoPlayer(_controller!),
//                 ),
//               ),
//               floatingActionButton: FloatingActionButton(
//                 onPressed: () {
//                   // Wrap the play or pause in a call to `setState`. This ensures the
//                   // correct icon is shown.
//                   setState(() {
//                     // If the video is playing, pause it.
//                     if (_controller!.value.isPlaying) {
//                       _controller!.pause();
//                     } else {
//                       // If the video is paused, play it.
//                       _controller!.play();
//                     }
//                   });
//                 },
//                 // Display the correct icon depending on the state of the player.
//                 child: Icon(
//                   _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                 ),
//               ),
//             )
//           // If the video is not yet initialized, display a spinner
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }
