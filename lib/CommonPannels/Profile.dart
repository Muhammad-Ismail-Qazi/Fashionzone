import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionzone/Components/AppBarComponent.dart';
import 'package:fashionzone/Components/DrawerComponent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  bool isEditable = false;

  final ImagePicker _imagePicker = ImagePicker();
  PickedFile? _imageFile;
  bool isTextFieldEnabled = false;
  firebase_storage.FirebaseStorage firebaseStorage =
      firebase_storage.FirebaseStorage.instance;
  String? profilePictureURL; // Declare the variable here

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
              const Text(
                'Choose profile photo',
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

  void enableTextField() {
    setState(() {
      isTextFieldEnabled = true;
    });
  }

  // Function to update user profile data
  void editProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get the user document reference in Firestore
        DocumentReference<Map<String, dynamic>> userRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);

        // Update the user data in Firestore
        await userRef.update({
          'name': nameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'address': addressController.text,
        });

        Fluttertoast.showToast(
          msg: "Successfully updated your profile!",
          backgroundColor: const Color.fromARGB(247, 84, 74, 158),
          textColor: Colors.white,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating user data: $e');
      }
    }
  }

// Function to upload profile picture
  Future<void> uploadProfilePicture() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null && _imageFile != null) {
        // Get the reference to the user's profile picture in Firebase Storage
        String fileName = 'profile_${user.uid}.jpg';
        firebase_storage.Reference storageReference =
            firebaseStorage.ref().child('profileImages').child(fileName);

        // Upload the image file to Firebase Storage
        await storageReference.putFile(File(_imageFile!.path));

        // Get the URL of the uploaded image
        String downloadURL = await storageReference.getDownloadURL();
        profilePictureURL = downloadURL;

        // Update the profile picture URL in Firestore
        DocumentReference<Map<String, dynamic>> userRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        await userRef.update({
          'profilePicture': downloadURL,
        });

        Fluttertoast.showToast(
          msg: "Successfully updated your profile picture!",
          backgroundColor: const Color.fromARGB(247, 84, 74, 158),
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print('Error uploading profile picture: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Fetch the user data from Firestore using the user's UID
        DocumentSnapshot<Map<String, dynamic>> userDataSnapshot =
            await FirebaseFirestore.instance
                .collection('users') //  'users' is your collection name
                .doc(user.uid)
                .get();

        if (userDataSnapshot.exists) {
          var textshow = "";
          // Extract the user data from the snapshot
          Map<String, dynamic> userData = userDataSnapshot.data()!;

          // Set the fetched data in the text fields
          setState(() {
            nameController.text = userData['name'] ?? '';
            emailController.text = userData['email'] ?? '';
            phoneController.text = userData['phone'] ?? '';
            addressController.text = userData['address'] ?? '';
            passwordController.text =
                textshow = ("Sorry:) we can't show your password ");
            profilePictureURL = userData['profilePicture'] ?? '';
          });
        }
      }
    } catch (e) {
      // Handle any errors that occur during fetching the data
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(profilePictureURL);
    final screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: const MyCustomAppBarComponent(appBarTitle: 'Profile'),
          drawer: const MyCustomDrawerComponent(),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: SingleChildScrollView(
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  // StreamBuilder to listen for changes in Firestore data
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show a loading indicator while waiting for data
                      return const CircularProgressIndicator();
                    }
                    // If we have data, build the UI using the fetched data
                    if (snapshot.hasData && snapshot.data!.exists) {
                      // Extract the user data from the snapshot
                      Map<String, dynamic> userData = snapshot.data!.data()!;
                      return Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: enableTextField,
                              child: const Text(
                                "Edit",
                                style: TextStyle(
                                  color: Color.fromARGB(247, 84, 74, 158),
                                  fontSize: 20,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),

                          // image
                          Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.01),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black45,
                                    width: 1,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                        child: CircleAvatar(
                                      backgroundColor: const Color.fromARGB(
                                          247, 84, 74, 158),
                                      radius: 70,
                                      backgroundImage: _imageFile == null
                                          ? (profilePictureURL != null
                                              ? Image.network(
                                                      profilePictureURL!)
                                                  .image
                                              : const AssetImage(
                                                  'assets/placeholder_image.png'))
                                          : _imageFile != null
                                              ? FileImage(
                                                  File(_imageFile!.path))
                                              : null,
                                    )),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          _showModalBottomSheet(context);
                                          // Add your logic for profile picture change functionality here
                                        },
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius:
                                              20, // Set the radius for the camera icon
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Color.fromARGB(
                                                247, 84, 74, 158),
                                            size:
                                                25, // Set the size of the camera icon
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //name
                          const SizedBox(
                            height: 10,
                          ),

                          Text(
                            userData['name'] ?? '',
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            userData['email'] ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          //form
                          Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: formKey,
                            child: SingleChildScrollView(
                              child: Center(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // full name
                                    SizedBox(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.86,
                                      child: Material(
                                        elevation: 5,
                                        shadowColor: Colors.black,
                                        child: TextFormField(
                                            controller: nameController,
                                            enabled: isTextFieldEnabled,
                                            keyboardType: TextInputType.name,
                                            decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                labelText: 'Full Name',
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        247, 84, 74, 158)),
                                                prefixIcon: Icon(
                                                  Icons.person,
                                                  color: Color.fromARGB(
                                                      247, 84, 74, 158),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          247, 84, 74, 158),
                                                      width: 1),
                                                ),
                                                border: OutlineInputBorder()),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your full name.';
                                              } else if (!RegExp(
                                                      r'^[A-Za-z\s]+$')
                                                  .hasMatch(value)) {
                                                return 'Invalid name format. Please enter a valid name.';
                                              } else {
                                                return null;
                                              }
                                            }),
                                      ),
                                    ),
                                    // space
                                    const SizedBox(height: 20),
                                    //email
                                    SizedBox(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.86,
                                      child: Material(
                                        elevation: 5,
                                        shadowColor: Colors.black,
                                        child: TextFormField(
                                            enabled: isTextFieldEnabled,
                                            controller: emailController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                labelText: 'Email',
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        247, 84, 74, 158)),
                                                prefixIcon: Icon(
                                                  Icons.email,
                                                  color: Color.fromARGB(
                                                      247, 84, 74, 158),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          247, 84, 74, 158),
                                                      width: 1),
                                                ),
                                                border: OutlineInputBorder()),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your email address.';
                                              } else if (!RegExp(
                                                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                                  .hasMatch(value)) {
                                                return 'Invalid email address format. Please enter a valid email address.';
                                              } else {
                                                return null;
                                              }
                                            }),
                                      ),
                                    ),
                                    // space
                                    const SizedBox(height: 20),
                                    //phone
                                    SizedBox(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.86,
                                      child: Material(
                                        elevation: 5,
                                        shadowColor: Colors.black,
                                        child: TextFormField(
                                            controller: phoneController,
                                            enabled: isTextFieldEnabled,
                                            keyboardType: TextInputType.phone,
                                            decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                labelText: 'Phone',
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        247, 84, 74, 158)),
                                                prefixIcon: Icon(
                                                  Icons.phone,
                                                  color: Color.fromARGB(
                                                      247, 84, 74, 158),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          247, 84, 74, 158),
                                                      width: 1),
                                                ),
                                                border: OutlineInputBorder()),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your phone number.';
                                              } else if (!RegExp(
                                                      r'^\+92\d{10}$')
                                                  .hasMatch(value)) {
                                                return 'Invalid format. Please enter a valid  format +92xxxxxxxxxx.';
                                              } else {
                                                return null;
                                              }
                                            }),
                                      ),
                                    ),
                                    // space
                                    const SizedBox(height: 20),
                                    //address
                                    SizedBox(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.86,
                                      child: Material(
                                        elevation: 5,
                                        shadowColor: Colors.black,
                                        child: TextFormField(
                                            controller: addressController,
                                            enabled: isTextFieldEnabled,
                                            keyboardType:
                                                TextInputType.streetAddress,
                                            decoration: const InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                labelText: 'Address',
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        247, 84, 74, 158)),
                                                prefixIcon: Icon(
                                                  Icons.location_city,
                                                  color: Color.fromARGB(
                                                      247, 84, 74, 158),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          247, 84, 74, 158),
                                                      width: 1),
                                                ),
                                                border: OutlineInputBorder()),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter your street address.';
                                              } else {
                                                return null;
                                              }
                                            }),
                                      ),
                                    ),
                                    // space
                                    const SizedBox(height: 20),
                                    // space
                                    const SizedBox(height: 20),
                                    //radio button
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.07),
                                    ),
                                    //space
                                    const SizedBox(height: 20),
                                    //Sign up Button
                                    SizedBox(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.86,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 5,
                                          backgroundColor: const Color.fromARGB(
                                              247,
                                              84,
                                              74,
                                              158), // Purple background when not hovering
                                        ),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            editProfile(); // Update user profile data
                                            uploadProfilePicture(); // Upload the profile picture if it's changed
                                            Fluttertoast.showToast(
                                              msg:
                                                  "Successfully Edit your profile !",
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      247, 84, 74, 158),
                                              textColor: Colors.white,
                                            );
                                          }
                                        },
                                        child: const Text(
                                          "Edit Profile",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            color: Colors
                                                .white, // black45 text when not hovering, white text when hovering
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      // If no data or connection error, show a message or handle accordingly
                      return const Text('No user data available.');
                    }
                  }),
            ),
            // bottomNavigationBar: const MyCustomBottomNavigationBar(),
          ),
        ));
  }
}
