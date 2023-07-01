import 'package:chewie/chewie.dart';
import 'package:fashionzone/Components/AppBarComponent.dart';
import 'package:fashionzone/Components/BottomNavigationBarComponent.dart';
import 'package:fashionzone/Components/DrawerComponent.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Reels extends StatefulWidget {
  const Reels({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReelsState createState() => _ReelsState();
}

class _ReelsState extends State<Reels> {
  List<String> videoUrls = [
    // Add your video URLs here
    'videos/promo.mp4',
    'videos/promo.mp4',
    'videos/promo.mp4',
  ];

  int currentIndex = 0;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  void initializeVideoPlayer() {
    videoPlayerController =
        VideoPlayerController.asset(videoUrls[currentIndex]);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      allowMuting: false,
      allowPlaybackSpeedChanging: false,
      allowedScreenSleep: false,
    );
    videoPlayerController.initialize().then((_) {
      setState(() {});
    });
  }

  void playNextVideo() {
    if (currentIndex < videoUrls.length - 1) {
      currentIndex++;
      videoPlayerController.pause();
      videoPlayerController =
          VideoPlayerController.asset(videoUrls[currentIndex]);
      chewieController.dispose();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
        allowMuting: false,
        allowPlaybackSpeedChanging: false,
        allowedScreenSleep: false,
      );
      videoPlayerController.initialize().then((_) {
        setState(() {});
      });
    }
  }

  void playPreviousVideo() {
    if (currentIndex > 0) {
      currentIndex--;
      videoPlayerController.pause();
      videoPlayerController =
          VideoPlayerController.asset(videoUrls[currentIndex]);
      chewieController.dispose();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
        allowMuting: false,
        allowPlaybackSpeedChanging: false,
        allowedScreenSleep: false,
      );
      videoPlayerController.initialize().then((_) {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBarComponent(),
      drawer: const MyCustomDrawerComponent(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                // Play the video when tapped
                if (videoPlayerController.value.isPlaying) {
                  videoPlayerController.pause();
                } else {
                  videoPlayerController.play();
                }
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: AspectRatio(
                  aspectRatio: videoPlayerController.value.aspectRatio,
                  child: Chewie(
                    controller: chewieController,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              left: 20,
              child: IconButton(
                onPressed: playPreviousVideo,
                icon: const Icon(Icons.navigate_before),
                color: Colors.blue,
              ),
            ),
            Positioned(
              top: 470,
              left: 350,
              child: Column(
                children: [
                  IconButton(
                    iconSize: 30,
                    onPressed: () {
                      // Handle love button press
                    },
                    icon: const Icon(Icons.favorite),
                    color: Colors.red,
                  ),
                  IconButton(
                    iconSize: 30,
                    onPressed: () {
                      // Handle comment button press
                    },
                    icon: const Icon(Icons.comment),
                    color: Colors.blue,
                  ),
                  IconButton(
                    iconSize: 30,
                    onPressed: () {
                      // Handle share button press
                    },
                    icon: const Icon(Icons.share),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyCustomBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: playNextVideo,
        child: const Icon(
          Icons.navigate_next,
        ),
      ),
    );
  }
}