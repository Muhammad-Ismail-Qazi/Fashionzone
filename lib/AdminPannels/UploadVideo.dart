import 'dart:io';
import 'package:fashionzone/AdminPannels/AdminDashboard.dart';
import 'package:fashionzone/Components/AppBarComponent.dart';
import 'package:fashionzone/Components/BottomNavigationBarComponent.dart';
import 'package:fashionzone/Components/DrawerComponent.dart';
import 'package:flutter/material.dart';


// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';

class UploadVideos extends StatefulWidget {
  const UploadVideos({super.key});

  @override
  _UploadVideosState createState() => _UploadVideosState();
}

class _UploadVideosState extends State<UploadVideos> {
  bool isHover = false;
  final formKey = GlobalKey<FormState>();
  File? _videoFile; // A file to store the selected video
  // final ImagePicker _picker = ImagePicker(); // An instance of ImagePicker

  // A method to get a video from the gallery
  // Future<void> getVideoFromGallery() async {
  //   // Use the pickVideo method to get a video from the gallery
  //   final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
  //
  //   // Check if the video is not null
  //   if (video != null) {
  //     // Set the _videoFile to the selected video
  //     setState(() {
  //       _videoFile = File(video.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    return MaterialApp(
        theme: ThemeData(
          primaryColor: const Color.fromARGB(247, 84, 74, 158),
          backgroundColor: const Color.fromARGB(247, 84, 74, 158),
          iconTheme:
              const IconThemeData(color: Color.fromARGB(247, 84, 74, 158)),
          fontFamily: 'Roboto',
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color.fromARGB(168, 192, 216, 212),
          appBar: const MyCustomAppBarComponent(),
          drawer: const MyCustomDrawerComponent(),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // A button to get a video from the gallery
                SizedBox(
                  height: 60,
                  width: 390,
                  child: MouseRegion(
                    onHover: (event) {
                      setState(() {
                        isHover = true;
                      });
                    },
                    onExit: (event) {
                      setState(() {
                        isHover = false;
                      });
                    },
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: isHover
                            ? const Color.fromARGB(247, 255, 255,
                                255) // White background when hovering
                            : const Color.fromARGB(247, 84, 74,
                                158), // Purple background when not hovering
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Perform an action when the button is pressed and the form is valid
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.video_library,
                            color: isHover ? Colors.black45 : Colors.white,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Choose the video",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              color: isHover ? Colors.black45 : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // A widget to display the selected video
                _videoFile != null
                    ? const SizedBox(
                        height: 300,
                        width: 300,
                        // child: VideoPlayer(_videoFile as VideoPlayerController),
                      )
                    : const Text('No video selected',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                //Title of the video
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Material(
                            elevation: 5,
                            shadowColor: Colors.black,
                            child: TextFormField(
                                controller: titleController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'Title',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(247, 84, 74, 158)),
                                    prefixIcon: Icon(
                                      Icons.title,
                                      color: Color.fromARGB(247, 84, 74, 158),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(247, 84, 74, 158),
                                          width: 3),
                                    ),
                                    border: OutlineInputBorder()),
                                style: const TextStyle(
                                    fontFamily: 'Roboto', fontSize: 15),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the title of the video.';
                                  } else if (value.length > 100) {
                                    return 'Maximum character limit is 100';
                                  }

                                  return null;
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Material(
                            elevation: 5,
                            shadowColor: Colors.black,
                            child: TextFormField(
                                controller: descriptionController,
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'Description',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(247, 84, 74, 158)),
                                    prefixIcon: Icon(
                                      Icons.description,
                                      color: Color.fromARGB(247, 84, 74, 158),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(247, 84, 74, 158),
                                          width: 3),
                                    ),
                                    border: OutlineInputBorder()),
                                style: const TextStyle(
                                    fontFamily: 'Roboto', fontSize: 15),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email address.';
                                  } else if (value.length > 200) {
                                    return 'Maximum description limit is 200';
                                  }

                                  return null;
                                }),
                          ),
                        ),
                      ],
                    )),

                //Description of the video

                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 60,
                  width: 390,
                  child: MouseRegion(
                    onHover: (event) {
                      setState(() {
                        isHover = true;
                      });
                    },
                    onExit: (event) {
                      setState(() {
                        isHover = false;
                      });
                    },
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: isHover
                            ? const Color.fromARGB(247, 255, 255,
                                255) // White background when hovering
                            : const Color.fromARGB(247, 84, 74, 158), // Purple background when not hovering
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Perform an action when the button is pressed and the form is valid
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.upload_outlined,
                            color: isHover ? Colors.black45 : Colors.white,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Upload Video",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              color: isHover ? Colors.black45 : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          bottomNavigationBar: const MyCustomBottomNavigationBar(),
          floatingActionButton: MouseRegion(
            onEnter: (_) {
              setState(() {
                isHover = true;
              });
            },
            onExit: (_) {
              setState(() {
                isHover = false;
              });
            },
            child: FloatingActionButton(
              backgroundColor: isHover ? Colors.white : const Color.fromARGB(247, 84, 74, 158),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboard(),));
              },
              child: const Icon(Icons.arrow_forward),
            ),
          ),

        ));
  }
}
