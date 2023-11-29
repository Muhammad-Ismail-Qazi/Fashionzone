import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart%20';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../Components/AppBarComponent.dart';
import '../Components/DrawerComponent.dart';

class UploadVideos extends StatefulWidget {
  const UploadVideos({Key? key}) : super(key: key);

  @override
  _UploadVideosState createState() => _UploadVideosState();
}

class _UploadVideosState extends State<UploadVideos> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? _videoFile;
  final ImagePicker _picker = ImagePicker();
  VideoPlayerController? _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool _isSelectingVideo = false;
  bool _isUploadingVideo = false;
  int totalVideos = 0;
  int uploadedVideos = 0;
  double uploadProgress = 0;
  String uploadStatus = '';

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

// take video from gallery
  Future<void> getVideoFromGallery() async {
    setState(() {
      _isSelectingVideo = true;
    });

    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

    setState(() {
      _isSelectingVideo = false;
    });

    if (video != null) {
      setState(() {
        _videoFile = File(video.path);
        _videoPlayerController = VideoPlayerController.file(_videoFile!);
        _initializeVideoPlayerFuture = _videoPlayerController!.initialize();
      });
    }
  }

  void playPauseVideo() {
    if (_videoPlayerController!.value.isPlaying) {
      _videoPlayerController!.pause();
    } else {
      _videoPlayerController?.play();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(247, 84, 74, 168),
        backgroundColor: const Color.fromARGB(247, 84, 74, 168),
        iconTheme: const IconThemeData(color: Color.fromARGB(247, 84, 74, 168)),
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CupertinoColors.white,
        appBar: const MyCustomAppBarComponent(appBarTitle: 'Upload Video'),
        drawer: const MyCustomDrawerComponent(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(

              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Go back functionality
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              12.0), // Adjust the value for roundness
                        ),
                        primary: const Color.fromARGB(247, 84, 74, 168),
                      ),
                      child: const SizedBox(
                        height: 20,
                        width: 10,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    const Text("Demonstrate Your Skills",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            color: Colors.black54)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.92,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(247, 84, 74, 168)),
                  ),
                  child: GestureDetector(
                    onTap: playPauseVideo,
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          _videoFile == null
                              ? Center(
                                  child: Icon(
                                    Icons.video_collection_outlined,
                                    size: MediaQuery.of(context).size.width *
                                        0.20,
                                  ),
                                )
                              : Stack(
                                  // this is the bottom red line
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.4,
                                      width: MediaQuery.of(context).size.width * 0.92,
                                      child:
                                          VideoPlayer(_videoPlayerController!),
                                    ),
                                    VideoProgressIndicator(
                                      _videoPlayerController!,
                                      allowScrubbing: true,
                                      padding: const EdgeInsets.all(10),
                                      colors: const VideoProgressColors(
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                          Positioned(
                            child: Center(
                              child: GestureDetector(
                                onTap: playPauseVideo,
                                child: Icon(
                                  _videoFile == null
                                      ? null
                                      : _videoPlayerController
                                                  ?.value.isPlaying ??
                                              false
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                  size:
                                      MediaQuery.of(context).size.width * 0.16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.92,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: const Color.fromARGB(247, 84, 74, 168),
                    ),
                    onPressed: () {
                      if (!_isSelectingVideo) {
                        getVideoFromGallery();
                      }
                    },
                    child: _isSelectingVideo
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.video_library,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Choose the video",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // Title of the video
                      Material(
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
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color.fromARGB(247, 84, 74, 168),
                            ),
                            prefixIcon: Icon(
                              Icons.title,
                              color: Color.fromARGB(247, 84, 74, 168),
                            ),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the title of the video.';
                            } else if (value.length > 100) {
                              return 'Maximum character limit is 100';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Description of the video
                      Material(
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
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color.fromARGB(247, 84, 74, 168),
                            ),
                            prefixIcon: Icon(
                              Icons.description,
                              color: Color.fromARGB(247, 84, 74, 168),
                            ),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the description of the video.';
                            } else if (value.length > 200) {
                              return 'Maximum description limit is 200';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.92,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: const Color.fromARGB(247, 84, 74, 168),
                    ),
                    onPressed: () {
                      if (!_isUploadingVideo &&
                          formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        uploadVideos(_videoFile!, titleController.text,
                            descriptionController.text);
                      }
                    },
                    child: _isUploadingVideo
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Upload Video",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                Text(
                  uploadStatus,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadVideos(
      File videoFile, String title, String description) async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      setState(() {
        _isUploadingVideo = true;
        uploadStatus = 'Uploading...';
      });

      final storage = FirebaseStorage.instance;
      final storageRef = storage.ref().child('videos/${DateTime.now()}.mp4');
      final uploadTask = storageRef.putFile(videoFile);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        setState(() {
          uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
          uploadStatus =
              'Uploading ${((uploadProgress * 100).toStringAsFixed(2))}%';
        });
      });

      await uploadTask.whenComplete(() {
        setState(() {
          uploadedVideos++;
          uploadStatus = 'Uploaded $uploadedVideos out of $totalVideos videos';
        });
      });

      final downloadUrl = await storageRef.getDownloadURL();

      final videoData = {
        'title': title,
        'description': description,
        'videoUrl': downloadUrl,
        'userID': user?.uid,
      };

      final DocumentReference documentReference =
          await FirebaseFirestore.instance.collection('videos').add(videoData);

      final String videosId = documentReference.id;
      DocumentReference<Map<String, dynamic>> userRef =
          FirebaseFirestore.instance.collection('salons').doc(user?.uid);

      await userRef.update({
        'videosId': FieldValue.arrayUnion([videosId]),
      });

      // Show success toast
      Fluttertoast.showToast(
        msg: 'Video uploaded successfully.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color.fromARGB(247, 84, 74, 168),
        textColor: Colors.white,
      );

      setState(() {
        titleController.clear();
        descriptionController.clear();
        _videoFile = null;
        _isUploadingVideo = false;
        uploadProgress = 0;
        uploadStatus = '';
      });
    } catch (error) {
      print(error);
      setState(() {
        _isUploadingVideo = false;
        uploadStatus = 'Upload failed';
      });
      // Show error toast
      Fluttertoast.showToast(
        msg: 'Error uploading video: $error',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      throw error;
    }
  }
}
