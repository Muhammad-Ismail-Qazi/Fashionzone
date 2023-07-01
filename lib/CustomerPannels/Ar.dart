import 'package:camera/camera.dart';
import 'package:fashionzone/Components/AppBarComponent.dart';
import 'package:fashionzone/Components/DrawerComponent.dart';
import 'package:flutter/material.dart';

import '../Components/BottomNavigationBarComponent.dart';
import 'package:camera/camera.dart';

class AR extends StatefulWidget {
  const AR({Key? key}) : super(key: key);

  @override
  State<AR> createState() => _ARState();
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
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: CameraPreview(cameraController!),
              )
                  : const Center(child: CircularProgressIndicator()),
              Positioned(
                  top: 300,
                  left: 250,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: 70,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: const Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                      AssetImage("images/logo.png"),
                                      backgroundColor: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Quiff'),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                      AssetImage("images/logo0.jpeg"),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('French crop')
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                      AssetImage("images/logo1.jpeg"),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Crew cut')
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                      AssetImage("assets/logo.jpg"),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('High fade')
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                      AssetImage("assets/logo.jpg"),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Crew cut')
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                      AssetImage("assets/logo.jpg"),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Crew cut')
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                      AssetImage("assets/logo.jpg"),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Crew cut')
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                      AssetImage("assets/logo.jpg"),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Crew cut')
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                  ))
            ],
          ),
          bottomNavigationBar: const MyCustomBottomNavigationBar(),
      ),
    );
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }
}



