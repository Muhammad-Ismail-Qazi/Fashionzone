import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionzone/CommonPannels/Login.dart';
import 'package:fashionzone/Components/AppBarComponent.dart';
import 'package:fashionzone/Components/BottomNavigationBarComponent.dart';
import 'package:fashionzone/Components/DrawerComponent.dart';
import 'package:fashionzone/Components/GalleryComponent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart ' as firebase_storage;

import '../Components/AdminServicesComponent.dart';
import 'CheckAppointment.dart';
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
  PickedFile? _coverPhotoFile;
  PickedFile? _logoPhotoFile;
  bool coverPhotoID = false;
  bool isTextFieldEnabled = false;
  bool textID = false;
  final salonNameController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String? generatedDocId;
  String? salonName;
  String? coverPictureURL;
  String? logoPictureURL;
  late DocumentReference salonRef;
  String? salonPictureURL; // Declare the variable here
  firebase_storage.FirebaseStorage firebaseStorage =
      firebase_storage.FirebaseStorage.instance;

  void initState() {
    super.initState();
    fetchSalonData();
  }

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
      if (coverPhotoID == true) {
        _coverPhotoFile = pickedFile;
      } else {
        _logoPhotoFile = pickedFile;
      }
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
                        image: _coverPhotoFile == null
                            ? (coverPictureURL != null
                                ? Image.network(coverPictureURL!).image
                                : const AssetImage(
                                    'assets/placeholder_image.png'))
                            : FileImage(File(_coverPhotoFile!.path)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  //button to upload cover photo
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () {
                        uploadPicture();
                        _showModalBottomSheet(context);
                        setState(() {
                          textID = true;
                        });
                        // Reset isHover after the button is clicked
                        setState(() {
                          coverPhotoID = true;
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

                        color: Color.fromARGB(240, 254, 254, 255),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
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
                                              ? const Color.fromARGB(
                                                  247,
                                                  255,
                                                  255,
                                                  255) // White background when hovering
                                              : const Color.fromARGB(
                                                  247, 84, 74, 158), // Purple
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 14, vertical: 6),
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
                                  ),
                                ),
                                // register on google map
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
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
                                                ? const Color.fromARGB(
                                                    247,
                                                    255,
                                                    255,
                                                    255) // White background when hovering
                                                : const Color.fromARGB(
                                                    247, 84, 74, 158), // Purple
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14,
                                                      vertical: 6),
                                              child: Center(
                                                child: Text(
                                                  "Register ",
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
                                salonName == null
                                    ? const Text("Salon Name",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black45,
                                        ))
                                    : Text(
                                        salonName!.toString(),
                                        style: const TextStyle(
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
                                            ? const Color.fromARGB(
                                                247,
                                                255,
                                                255,
                                                255) // White background when hovering
                                            : const Color.fromARGB(
                                                247, 84, 74, 158), // Purple
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const CheckAppointment(),
                                          ));
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
                                            ? const Color.fromARGB(
                                                247,
                                                255,
                                                255,
                                                255) // White background when hovering
                                            : const Color.fromARGB(
                                                247, 84, 74, 158),
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                      fontSize: 18, fontFamily: 'Poppins'),
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
                    top: MediaQuery.of(context).size.height * 0.3 -
                        kToolbarHeight,
                    left: (MediaQuery.of(context).size.width * 0.5) -
                        (MediaQuery.of(context).size.width * 0.25 / 2),
                    right: (MediaQuery.of(context).size.width * 0.5) -
                        (MediaQuery.of(context).size.width * 0.25 / 2),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: _logoPhotoFile == null
                                  ? (logoPictureURL != null
                                  ? Image.network(logoPictureURL!, fit: BoxFit.fill,)
                                  : Image.asset('assets/placeholder_image.png'))
                                  : Image.file(File(_logoPhotoFile!.path)),
                            ),

                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          right: -12,
                          child: GestureDetector(
                            onTap: () {
                              uploadPicture();
                              // Add your logic for log picture change functionality here
                              _showModalBottomSheet(context);
                              textID = false;
                              setState(() {
                                coverPhotoID = false;
                              });
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
            controller: salonNameController,
            style: const TextStyle(fontFamily: 'Poppins'),
            onChanged: (value) {
              salonName = value;
            },
          ),
          actions: [
            ElevatedButton(
              autofocus: true,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(247, 84, 74, 158),
              ),
              child:
                  const Text("Save", style: TextStyle(fontFamily: 'Poppins')),
              onPressed: () async {
                registerSalonName();
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void registerSalonName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('salons').doc(user.uid).set({
        'name': salonNameController.text.toString(),
      });
    }
  }

  Future<void> fetchSalonData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Check if user is not null
      try {
        DocumentSnapshot<Map<String, dynamic>> salonDataSnapshot =
            await FirebaseFirestore.instance
                .collection('salons')
                .doc(user.uid)
                .get();
        if (salonDataSnapshot.exists) {
          Map<String, dynamic> salonData = salonDataSnapshot.data()!;
          setState(() {
            salonName = salonData['name'] ?? '';
            salonNameController.text = salonData['name'] ?? '';
            coverPictureURL = salonData['coverPicture'] ?? '';
            logoPictureURL = salonData['logoPicture'] ?? '';
          });
        }
      } catch (e) {
        print('Error fetching salon data: $e');
        // Handle the error as needed
      }
    }
  }

  // Future<void> updateSalonInfo(String adminUID, String salonName, String logoURL, String coverPhotoURL) async {
  //   try {
  //     await FirebaseFirestore.instance.collection('salons').doc(adminUID).update({
  //       'name': salonName,
  //       'logo': logoURL,
  //       'coverPhoto': coverPhotoURL,
  //       // Update other salon details here
  //     });
  //
  //     // Show success message to admin
  //   } catch (e) {
  //     // Show error message to admin
  //   }
  // }
// Function to upload  picture
  Future<void> uploadPicture() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null && (_coverPhotoFile != null || _logoPhotoFile != null)) {
        // Upload cover photo if available
        if (_coverPhotoFile != null) {
          String coverFileName = 'cover_${user.uid}.jpg';
          firebase_storage.Reference coverStorageReference =
              firebaseStorage.ref().child('salonImages').child(coverFileName);
          await coverStorageReference.putFile(File(_coverPhotoFile!.path));

          String coverDownloadURL =
              await coverStorageReference.getDownloadURL();
          // Handle the cover photo URL as needed
          salonPictureURL = coverDownloadURL;
          DocumentReference<Map<String, dynamic>> salonRef =
              FirebaseFirestore.instance.collection('salons').doc(user.uid);
          await salonRef.update({
            'coverPicture': salonPictureURL,
          });
          Fluttertoast.showToast(
            msg: "Successfully updated your cover picture!",
            backgroundColor: const Color.fromARGB(247, 84, 74, 158),
            textColor: Colors.white,
          );
        }

        // Upload logo photo if available
        if (_logoPhotoFile != null) {
          String logoFileName = 'logo_${user.uid}.jpg';
          firebase_storage.Reference logoStorageReference =
              firebaseStorage.ref().child('salonImages').child(logoFileName);
          await logoStorageReference.putFile(File(_logoPhotoFile!.path));

          String logoDownloadURL = await logoStorageReference.getDownloadURL();
          // Handle the logo photo URL as needed
          salonPictureURL = logoDownloadURL;

          DocumentReference<Map<String, dynamic>> salonRef =
              FirebaseFirestore.instance.collection('salons').doc(user.uid);
          await salonRef.update({
            'logoPicture': salonPictureURL,
          });
          Fluttertoast.showToast(
            msg: "Successfully updated your logo picture!",
            backgroundColor: const Color.fromARGB(247, 84, 74, 158),
            textColor: Colors.white,
          );
        }

      }
    } catch (e) {
      print('Error uploading picture: $e');
      // Handle the error as needed
    }
  }
}
