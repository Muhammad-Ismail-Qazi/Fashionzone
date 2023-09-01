import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyCustomGalleryComponent extends StatefulWidget {
  final String galleryVideoPath;

  const MyCustomGalleryComponent({
    Key? key,
    required this.galleryVideoPath,
  }) : super(key: key);

  @override
  _MyCustomGalleryComponentState createState() =>
      _MyCustomGalleryComponentState();
}

class _MyCustomGalleryComponentState extends State<MyCustomGalleryComponent> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.galleryVideoPath)
      ..initialize().then((_) {
        // Ensure the first frame is shown and set the state.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: GestureDetector(
        onTap: () {
          // Handle video playback
          if (_controller.value.isInitialized) {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          }
        },
        child: Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          child: Container(
            height:   MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  _controller.value.isInitialized
                      ? VideoPlayer(_controller)
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: const [0.0, 0.9],
                        colors: [
                          const Color.fromARGB(247, 84, 74, 158),
                          Colors.black.withOpacity(0.001),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
