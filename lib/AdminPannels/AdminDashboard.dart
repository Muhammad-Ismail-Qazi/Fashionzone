

import 'dart:io';

import 'package:fashionzone/Components/AppBarComponent.dart';
import 'package:fashionzone/Components/BottomNavigationBarComponent.dart';
import 'package:fashionzone/Components/DrawerComponent.dart';
import 'package:fashionzone/Components/GalleryComponent.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Components/AdminServicesComponent.dart';
import 'UploadVideo.dart';
import 'UploadServices.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  bool isHover = false;
  final ImagePicker _imagePicker = ImagePicker();
  PickedFile? _imageFile;
  bool isTextFieldEnabled = false;
  bool textID = false;
  // bottom screen show
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(14.0),
          decoration: const BoxDecoration(
            color: Color.fromARGB(247, 84, 74, 158),
          ),
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textID
                  ? const Text(
                      'Upload Cover Photo',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Upload Your Logo',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      takePhoto(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: const Column(
                      children: [
                        Icon(Icons.camera_alt, color: Colors.white),
                        SizedBox(height: 10.0),
                        Text('Camera', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40.0),
                  InkWell(
                    onTap: () {
                      takePhoto(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.photo_library,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10.0),
                        Text('Gallery', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // take photo
  void takePhoto(ImageSource source) async {
    final pickedFile = await _imagePicker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(247, 84, 74, 158),
        backgroundColor: const Color.fromARGB(247, 84, 74, 158),
        iconTheme: const IconThemeData(color: Color.fromARGB(247, 84, 74, 158)),
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBody: true,
        appBar: const MyCustomAppBarComponent(),
        drawer: const MyCustomDrawerComponent(),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                // background image
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _imageFile == null
                          ? const AssetImage('images/background_img.png')
                          : FileImage(File(_imageFile!.path)) as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                //button to upload cover photo
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () {
                      _showModalBottomSheet(context);
                      setState(() {
                        textID = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: isHover
                          ? Colors.white
                          : const Color.fromARGB(247, 84, 74, 158),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final buttonWidth = constraints.maxWidth * 0.5;
                        return SizedBox(
                          height: 32,
                          width: buttonWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload_outlined,
                                color: isHover ? Colors.black45 : Colors.white,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Upload Cover Photo',
                                style: TextStyle(
                                  color:
                                      isHover ? Colors.black45 : Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // the white bottom screen half
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(240, 249, 249, 252),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    // text of gents title
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Save button
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                // Navigate to another screen or perform an action
                              },
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
                                child: Card(
                                  elevation: 5,
                                  color: isHover
                                      ? const Color.fromARGB(247, 255, 255,
                                          255) // White background when hovering
                                      : const Color.fromARGB(
                                          247, 84, 74, 158), // Purple
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 6),
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: isHover
                                            ? Colors.black45
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // space
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * 0.07,
                          // ),
                          // Title
                          const Text(
                            'Gents Salon',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black45,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          // Subtitle
                          const Text(
                            'Hair, Color, Beard',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black45,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Rating
                              GestureDetector(
                                onTap: () {
                                  // Navigate to another screen or perform an action
                                },
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
                                  child: Card(
                                    elevation: 5,
                                    color: isHover
                                        ? const Color.fromARGB(247, 255, 255,
                                            255) // White background when hovering
                                        : const Color.fromARGB(
                                            247, 84, 74, 158), // Purple
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 6),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "4.5",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: isHover
                                                  ? Colors.black45
                                                  : Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Location
                              MouseRegion(
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
                                child: Card(
                                  color: isHover
                                      ? const Color.fromARGB(247, 255, 255,
                                          255) // White background when hovering
                                      : const Color.fromARGB(247, 84, 74, 158),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 6),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.map,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "View on Google Map",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: isHover
                                                  ? Colors.black45
                                                  : Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // upload video button
                                    MouseRegion(
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
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const UploadVideos(),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 5,
                                          backgroundColor: isHover
                                              ? const Color.fromARGB(
                                                  247, 255, 255, 255)
                                              : const Color.fromARGB(
                                                  247, 84, 74, 158),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        icon: Icon(
                                          Icons.upload_outlined,
                                          color: isHover
                                              ? Colors.black45
                                              : Colors.white,
                                        ),
                                        label: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.29,
                                          child: Center(
                                            child: Text(
                                              'Upload video',
                                              style: TextStyle(
                                                color: isHover
                                                    ? Colors.black45
                                                    : Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            10), // Add spacing between buttons
                                    // upload services button
                                    MouseRegion(
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
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const UploadServices(),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 5,
                                          backgroundColor: isHover
                                              ? const Color.fromARGB(
                                                  247, 255, 255, 255)
                                              : const Color.fromARGB(
                                                  247, 84, 74, 158),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        icon: Icon(
                                          Icons.upload_outlined,
                                          color: isHover
                                              ? Colors.black45
                                              : Colors.white,
                                        ),
                                        label: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          child: Center(
                                            child: Text(
                                              'Upload services',
                                              style: TextStyle(
                                                color: isHover
                                                    ? Colors.black45
                                                    : Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          // Text of Gallery and See all
                          Row(
                            children: [
                              const Text(
                                "Gallery",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  // Handle 'see all' tap
                                },
                                child: const Text(
                                  "see all",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          // Gallery
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: const Row(
                                children: [
                                  MyCustomGalleryComponent(
                                    galleryImagePath: 'images/gallery1.jpg',
                                  ),
                                  MyCustomGalleryComponent(
                                    galleryImagePath: 'images/gallery2.jpg',
                                  ),
                                  MyCustomGalleryComponent(
                                    galleryImagePath: 'images/gallery3.jpg',
                                  ),
                                  MyCustomGalleryComponent(
                                    galleryImagePath: 'images/gallery4.jpg',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Text of Services
                          Row(
                            children: [
                              const Text(
                                "Services",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  // Handle 'see all' tap
                                },
                                child: const Text(
                                  "see all",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          // Services
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                MyCustomAdminServicesComponent(
                                  servicesImagePath: 'images/services1.jpg',
                                  price: '300',
                                ),
                                MyCustomAdminServicesComponent(
                                  servicesImagePath: 'images/services2.jpg',
                                  price: "250",
                                ),
                                MyCustomAdminServicesComponent(
                                  servicesImagePath: 'images/services3.jpg',
                                  price: '150',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // the Logo
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.23,
                  left: MediaQuery.of(context).size.width * 0.4,
                  child: Stack(
                    children: [
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.125,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                           child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: _imageFile == null
                                  ? Image.asset(
                                'images/logo0.jpeg',
                                fit: BoxFit.fill,
                              )
                                  : Image.file(
                                File(_imageFile!.path),
                                fit: BoxFit.fill,
                              ),
                            )

                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        right: -12,
                        child: GestureDetector(
                          onTap: () {
                            // Add your logic for profile picture change functionality here
                            _showModalBottomSheet(context);
                            textID = false;
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20, // Set the radius for the camera icon
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                              size: 25, // Set the size of the camera icon
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const MyCustomBottomNavigationBar(),
      ),
    );
  }
}
