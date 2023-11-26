import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionzone/Components/AppBarComponent.dart';
import 'package:fashionzone/Components/BottomNavigationBarComponent.dart';
import 'package:fashionzone/Components/DrawerComponent.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Reels extends StatefulWidget {
  const Reels({Key? key}) : super(key: key);

  @override
  _ReelsState createState() => _ReelsState();
}

class _ReelsState extends State<Reels> {
  List<Map<String, dynamic>> videosData = []; // Store fetched video data here

  int currentIndex = 0;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  void initializeVideoPlayer() {
    // Use video URL from videosData at the currentIndex
    videoPlayerController =
        VideoPlayerController.network(videosData[currentIndex]['videoUrl']);
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
    if (currentIndex < videosData.length - 1) {
      currentIndex++;
      videoPlayerController.pause();
      initializeVideoPlayer();
    }
  }

  void playPreviousVideo() {
    if (currentIndex > 0) {
      currentIndex--;
      videoPlayerController.pause();
      initializeVideoPlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBarComponent(appBarTitle: 'Reels'),
      drawer: const MyCustomDrawerComponent(),
      body: Stack(
        children: [
          videosData.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GestureDetector(
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
                aspectRatio:
                videoPlayerController.value.aspectRatio,
                child: Chewie(
                  controller: chewieController,
                ),
              ),
            ),
          ),
          Positioned(
            left: 16.0,
            bottom: 16.0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videosData[currentIndex]['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    videosData[currentIndex]['description'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                backgroundColor: const Color.fromARGB(247, 84, 74, 158),
                onPressed: playPreviousVideo,
                child: const Icon(
                  Icons.navigate_before,
                ),
              ),
              FloatingActionButton(
                backgroundColor: const Color.fromARGB(247, 84, 74, 158),
                onPressed: playNextVideo,
                child: const Icon(
                  Icons.navigate_next,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fetchVideos() {
    FirebaseFirestore.instance.collection('videos').get().then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          String description = doc['description'];
          String title = doc['title'];
          String userID = doc['userID'];
          String videoUrl = doc['videoUrl'];

          print("title $title");

          // Add the video data to the list
          videosData.add({
            'title': title,
            'description': description,
            'userID': userID,
            'videoUrl': videoUrl,
          });


          // If this is the first video in the list, initialize the player
          if (videosData.length == 1) {
            initializeVideoPlayer();
          }
        }
        setState(() {});
      }
    });
  }
}
