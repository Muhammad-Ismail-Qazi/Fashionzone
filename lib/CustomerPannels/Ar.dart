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

  void takePicture() async {
    if (cameraController != null && cameraController!.value.isInitialized) {
      final XFile image = await cameraController!.takePicture();
      // Process the captured image as needed
      print("Picture taken: ${image.path}");
    }
  }

  void handleTextIconPress() {
    // Handle the press of the text_fields icon

    // Step 1: Create a TextEditingController to get the user input
    TextEditingController textController = TextEditingController();

    // Step 2: Show an AlertDialog to get the user input
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Text'),
          content: TextField(
            controller: textController,
            decoration: InputDecoration(hintText: 'Type your text here...'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the AlertDialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String text = textController.text;
                // Process the entered text as needed
                print('Entered text: $text');
                Navigator.pop(context); // Close the AlertDialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void handleCropIconPress() {
    // Handle the press of the crop icon
    print('Crop icon pressed');
  }

  void handleSaveIconPress() {
    // Handle the press of the save icon
    print('Save icon pressed');
  }

  void applyFilter(String filterName) {
    // Apply the selected filter
    print('Filter selected: $filterName');
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
            // camera change icon
            Positioned(
              top: 16,
              right: 14,
              child: IconButton(
                icon: const Icon(Icons.switch_camera),
                onPressed: toggleCamera,
                color: Colors.white,
              ),
            ),
            // icons in the center-right  of the screen
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 50,
              right: 14,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.text_fields,
                      size: 33,
                    ),
                    onPressed: handleTextIconPress,
                    color: Colors.white,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.crop,
                      size: 33,
                    ),
                    onPressed: handleCropIconPress,
                    color: Colors.white,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.save,
                      size: 33,
                    ),
                    onPressed: handleSaveIconPress,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            // Circular indicator to take picture
            Positioned(
              bottom: 40,
              left: MediaQuery.of(context).size.width / 2 - 50,
              child: GestureDetector(
                onTap: takePicture,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            // filters
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      _buildFilterItem('Quiff', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem('French crop', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem('High fade', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem('Crew cut', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem('Buzz cut', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem('Spiky', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem('Quiff', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem('French crop', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem('High fade', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem('Crew cut', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem('Buzz cut', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem('Spiky', 'images/logo.png'),
                    ],
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterItem(String filterName, String imagePath) {
    return GestureDetector(
      onTap: () => applyFilter(filterName),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 30,
              backgroundImage: AssetImage(imagePath),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            filterName,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }
}
