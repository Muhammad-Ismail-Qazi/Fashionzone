import 'package:camera/camera.dart';

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
  int selectedFilterIndex = -1; // Default: No filter selected



  @override
  void initState() {
    super.initState();
    initCamera();
  }
  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
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
          title: const Text('Enter Text'),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(hintText: 'Type your text here...'),
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

  void applyFilter(int index, String filterName) {
    // Apply the selected filter
    print('Filter selected: $filterName');

    setState(() {
      selectedFilterIndex = index; // Set the selected filter index
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const MyCustomAppBarComponent(appBarTitle: 'Filters'),
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
            // Positioned(
            //   bottom: 40,
            //   left: MediaQuery.of(context).size.width / 2 - 50,
            //   child: GestureDetector(
            //     onTap: takePicture,
            //     child: Container(
            //       width: 80,
            //       height: 80,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         border: Border.all(color: Colors.white, width: 2),
            //         color: Colors.transparent,
            //       ),
            //     ),
            //   ),
            // ),
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
                      _buildFilterItem(0,'Quiff', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem(1,'French crop', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem(2,'High fade', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem(3,'Crew cut', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem(4,'Buzz cut', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem(5,'Spiky', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem(6,'Quiff', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem(7,'French crop', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem(8,'High fade', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem(9,'Crew cut', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem(10,'Buzz cut', 'images/logo.png'),
                      const SizedBox(width: 16),
                      _buildFilterItem(11,'Spiky', 'images/logo.png'),
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

  Widget _buildFilterItem(int index, String filterName, String imagePath) {
    final isSelected = index == selectedFilterIndex;

    return GestureDetector(
      onTap: () => applyFilter(index, filterName),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1),
              color: isSelected ? Colors.blue : Colors.transparent, // Apply background color if selected
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
            style: TextStyle(
              fontFamily: 'Poppins',
              color: isSelected ? Colors.blue : Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }



}
