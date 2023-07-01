import 'package:fashionzone/Components/AppBarComponent.dart';
import 'package:fashionzone/Components/BottomNavigationBarComponent.dart';
import 'package:fashionzone/Components/DrawerComponent.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


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
  bool isHover = false;
  final ImagePicker _imagePicker = ImagePicker();
  PickedFile? _imageFile;
  bool isTextFieldEnabled=false;
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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const MyCustomAppBarComponent(),
        drawer: const MyCustomDrawerComponent(),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: SingleChildScrollView(
            child: Column(
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
                              radius: 70,
                              backgroundImage: _imageFile == null
                                  ? const AssetImage('images/ismail.jpg')
                                  : FileImage(File(_imageFile!.path))
                                      as ImageProvider,
                            ),
                          ),
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
                  ),
                ),
                //name
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Muhammad Ismail",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const Text(
                  "muhammad.ismail15604@gmail.com",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                //form
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          // full name
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.86,
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
                                          color:
                                              Color.fromARGB(247, 84, 74, 158)),
                                      prefixIcon: Icon(
                                        Icons.person,
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
                                            width: 1),
                                      ),
                                      border: OutlineInputBorder()),
                                  style: const TextStyle(
                                      fontFamily: 'Poppins', fontSize: 15),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your full name.';
                                    } else if (!RegExp(r'^[A-Za-z\s]+$')
                                        .hasMatch(value)) {
                                      return 'Invalid name format. Please enter a valid name.';
                                    }
                                    else {
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
                            width: MediaQuery.of(context).size.width * 0.86,
                            child: Material(
                              elevation: 5,
                              shadowColor: Colors.black,
                              child: TextFormField(
                                enabled: isTextFieldEnabled,
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      labelText: 'Email',
                                      labelStyle: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(247, 84, 74, 158)),
                                      prefixIcon: Icon(
                                        Icons.email,
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
                                            width: 1),
                                      ),
                                      border: OutlineInputBorder()),
                                  style: const TextStyle(
                                      fontFamily: 'Poppins', fontSize: 15),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your email address.';
                                    } else if (!RegExp(
                                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                        .hasMatch(value)) {
                                      return 'Invalid email address format. Please enter a valid email address.';
                                    }
                                    else {
                                      return null;
                                    }


                                  }
                                  ),
                            ),
                          ),
                          // space
                          const SizedBox(height: 20),
                          //phone
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.86,
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
                                          color:
                                              Color.fromARGB(247, 84, 74, 158)),
                                      prefixIcon: Icon(
                                        Icons.phone,
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
                                            width: 1),
                                      ),
                                      border: OutlineInputBorder()),
                                  style: const TextStyle(
                                      fontFamily: 'Poppins', fontSize: 15),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your phone number.';
                                    } else if (!RegExp(r'^\+92\d{10}$')
                                        .hasMatch(value)) {
                                      return 'Invalid format. Please enter a valid  format +92xxxxxxxxxx.';
                                    }
                                    else {
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
                            width: MediaQuery.of(context).size.width * 0.86,
                            child: Material(
                              elevation: 5,
                              shadowColor: Colors.black,
                              child: TextFormField(
                                  enabled: isTextFieldEnabled,
                                  keyboardType: TextInputType.streetAddress,
                                  decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      labelText: 'Address',
                                      labelStyle: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(247, 84, 74, 158)),
                                      prefixIcon: Icon(
                                        Icons.location_city,
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
                                            width: 1),
                                      ),
                                      border: OutlineInputBorder()),
                                  style: const TextStyle(
                                      fontFamily: 'Poppins', fontSize: 15),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your street address.';
                                    }
                                    else {
                                      return null;
                                    }

                                  }),
                            ),
                          ),
                          // space
                          const SizedBox(height: 20),
                          //password
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.86,
                            child: Material(
                              elevation: 5,
                              shadowColor: Colors.black,
                              child: TextFormField(
                                  enabled: isTextFieldEnabled,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(247, 84, 74, 158)),
                                      prefixIcon: Icon(
                                        Icons.password,
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
                                            width: 1),
                                      ),
                                      border: OutlineInputBorder()),
                                  style: const TextStyle(
                                      fontFamily: 'Poppins', fontSize: 15),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your password.';
                                    } else if (value.length < 8) {
                                      return 'Password should be at least 8 characters long.';
                                    }
                                    else{
                                      return null;
                                    }

                                  }),
                            ),
                          ),
                          // space
                          const SizedBox(height: 20),
                          //radio button
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.07),
                          ),
                          //space
                          const SizedBox(height: 20),
                          //Sign up Button
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.86,
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
                                    Fluttertoast.showToast(
                                      msg: "Successfully Edit your profile !",
                                      backgroundColor:
                                          const Color.fromARGB(247, 84, 74, 158),
                                      textColor: Colors.white,
                                    );
                                  }
                                  setState(() {
                                    isHover = false;
                                  });
                                },
                                child: Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: isHover
                                        ? Colors.black45
                                        : Colors
                                            .white, // black45 text when not hovering, white text when hovering
                                  ),
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
            ),
          ),
        ),
        bottomNavigationBar: const MyCustomBottomNavigationBar(),
      ),
    );
  }
}
