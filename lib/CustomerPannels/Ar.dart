import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashionzone/Components/AppBarComponent.dart';
import 'package:flutter/material.dart';

import '../Components/DrawerComponent.dart';

class AR extends StatefulWidget {
  @override
  _ARState createState() => _ARState();
}

class _ARState extends State<AR> {
  List<CameraDescription>? cameras;
  CameraController? cameraController;
  int selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras![selectedCameraIndex],
      ResolutionPreset.high,
    );
    await cameraController!.initialize();
    setState(() {});
  }

  void toggleCamera() {
    selectedCameraIndex = selectedCameraIndex == 0 ? 1 : 0;
    cameraController = CameraController(
      cameras![selectedCameraIndex],
      ResolutionPreset.high,
    );
    cameraController!.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const MyCustomAppBarComponent(),
        drawer: const MyCustomDrawerComponent(),
        body: Stack(
          children: [
            cameraController != null && cameraController!.value.isInitialized
                ? SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CameraPreview(cameraController!),
            )
                : const Center(child: CircularProgressIndicator()),
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.switch_camera),
                onPressed: toggleCamera,
                color: Colors.white,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 50, // Adjust the position as needed
              right: 16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.text_fields, size: 35,),
                    onPressed: () {
                      // Handle type icon press
                    },
                    color: Colors.white,
                  ),
                  IconButton(
                    icon: const Icon(Icons.crop,size: 35,),
                    onPressed: () {
                      // Handle crop icon press
                    },
                    color: Colors.white,
                  ),
                  IconButton(
                    icon: const Icon(Icons.save,size: 35,),
                    onPressed: () {
                      // Handle save icon press
                    },
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 80,
              child: Container(
               height: 150,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  items: [
                    GestureDetector(
                      onTap: () {},
                      child: const Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage("images/logo.png"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Quiff',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage("images/logo.png"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'French crop',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage("images/logo.png"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Crew cut',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage("images/logo.png"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'High fade',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage("images/logo.png"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Crew cut',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage("images/logo.png"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Crew cut',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage("images/logo.png"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Crew cut',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage("images/logo.png"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Crew cut',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                  options: CarouselOptions(
                    animateToClosest: true,
                    viewportFraction: 0.20,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    autoPlay: false,
                    enlargeCenterPage: true, // Set this property to true
                    // autoPlayInterval: const Duration(seconds: 2),
                    // autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    // pauseAutoPlayOnTouch: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }
}
