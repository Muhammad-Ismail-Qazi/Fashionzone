import 'dart:io';
import 'package:fashionzone/Components/AppBarComponent.dart';
import 'package:fashionzone/Components/BottomNavigationBarComponent.dart';
import 'package:fashionzone/Components/DrawerComponent.dart';
import 'package:fashionzone/Components/GalleryComponent.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Components/AdminServicesComponent.dart';
import 'Check_Appointment.dart';
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
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Upload Your Logo',
                      style: TextStyle(
                        fontSize: 18,
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
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const MyCustomAppBarComponent(),
        drawer: const MyCustomDrawerComponent(),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: SingleChildScrollView(
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
                            : FileImage(File(_imageFile!.path))
                                as ImageProvider,
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
                        // Reset isHover after the button is clicked
                        setState(() {
                          isHover = false;
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
                                  color:
                                      isHover ? Colors.black45 : Colors.white,
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
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                // star button
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.25,
                                    decoration: const BoxDecoration(),
                                    child: GestureDetector(
                                      onTap: () {
                                        // Navigate to another screen or perform an action
                                        // Reset isHover after the button is clicked
                                        setState(() {
                                          isHover = false;
                                        });
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
                                              ? const Color.fromARGB(247, 255, 255, 255) // White background when hovering
                                              : const Color.fromARGB(247, 84, 74, 158), // Purple
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
                                                    fontSize: 18,
                                                    color: isHover ? Colors.black45 : Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // register on google map
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      decoration: const BoxDecoration(),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Navigate to another screen or perform an action
                                          // Reset isHover after the button is clicked
                                          setState(() {
                                            isHover = false;
                                          });
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
                                                ? const Color.fromARGB(247, 255, 255, 255) // White background when hovering
                                                : const Color.fromARGB(247, 84, 74, 158), // Purple
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                              child: Center(
                                                child: Text(
                                                  "Register ",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: isHover ? Colors.black45 : Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),


                            // Title
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Gents Salon',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black45,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    // Add your onPressed logic here
                                    openDialogToOpen(context);
                                  },
                                ),
                              ],
                            ),

                            // space
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.001,
                            ),
                            // Subtitle
                            // space
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Rating
                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to another screen or perform an action
                                      // Reset isHover after the button is clicked
                                      setState(() {
                                        isHover = false;
                                      });
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
                                                "Manage employees",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: isHover
                                                      ? Colors.black45
                                                      : Colors.white,
                                                ),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // check Appointments
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckAppointment(),));
                                      // Reset isHover after the button is clicked
                                      setState(() {
                                        isHover = false;
                                      });
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
                                        color: isHover
                                            ? const Color.fromARGB(247, 255, 255,
                                                255) // White background when hovering
                                            : const Color.fromARGB(
                                                247, 84, 74, 158),
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 6),
                                          child: Text(
                                            "Check Appointments",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: isHover
                                                    ? Colors.black45
                                                    : Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // space
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.29,
                                        child: Center(
                                          child: Text(
                                            'Upload video',
                                            style: TextStyle(
                                              color: isHover
                                                  ? Colors.black45
                                                  : Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // space
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ), // Add spacing between buttons
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: Center(
                                          child: Text(
                                            'Upload services',
                                            style: TextStyle(
                                              color: isHover
                                                  ? Colors.black45
                                                  : Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //space
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            // Text of Gallery and See all
                            Row(
                              children: [
                                const Text(
                                  "Gallery",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Poppins'
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
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),

                            // Gallery
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
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
                            // space
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),

                            // Text of Services
                            Row(
                              children: [
                                const Text(
                                  "Services",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
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
                                    style: TextStyle(fontSize: 18),
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
                    top: MediaQuery.of(context).size.height * 0.3 - kToolbarHeight, // Adjusted for the app bar,
                    left: (MediaQuery.of(context).size.width * 0.5) - (MediaQuery.of(context).size.width * 0.25 / 2),
                    right: (MediaQuery.of(context).size.width * 0.5) - (MediaQuery.of(context).size.width * 0.25 / 2),
                    child: Stack(
                      children: [
                        Material(
                          elevation: 5,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                            ),
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
        ),
        // bottomNavigationBar: const MyCustomBottomNavigationBar(),
      ),
    );
  }

  Future<void> openDialogToOpen(BuildContext context) async {
    String salonName = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          title: const Text("Salon Name"),
          content: TextField(
            onChanged: (value) {
              salonName = value;
            },
          ),
          actions: [
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                // Use the salonName variable as needed
                print('Salon Name: $salonName');
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }


}
