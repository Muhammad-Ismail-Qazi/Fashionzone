import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../CustomerPannels/Booking.dart';
import 'Login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

enum UserRole { customer, admin }

class _SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  UserRole role = UserRole.customer;
  bool isHover = false;
  bool loading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                right: 14.0, left: 14.0, top: screenHeight * 0.2),
            child: Center(
              child: Column(
                children: [
                  const Text("Welcome To Fashionzone",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          color: Colors.black54)),
                  SizedBox(height: screenHeight * 0.02),
                  Material(
                    elevation: 5,
                    shadowColor: Colors.black,
                    child: TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Color.fromARGB(247, 84, 74, 158),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color.fromARGB(247, 84, 74, 158),
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      ),
                      validator: (value) {
                        if (value!.isEmpty && value.length < 3) {
                          return 'Please enter your full name.';
                        } else if (!RegExp(r'^[A-Za-z\s]+$').hasMatch(value)) {
                          return 'Invalid name format. Please enter a valid name.';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Material(
                    elevation: 5,
                    shadowColor: Colors.black,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Color.fromARGB(247, 84, 74, 158),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color.fromARGB(247, 84, 74, 158),
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an email address.';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Invalid email format. Please enter a valid email address.';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Material(
                    elevation: 5,
                    shadowColor: Colors.black,
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Color.fromARGB(247, 84, 74, 158),
                        ),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Color.fromARGB(247, 84, 74, 158),
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a phone number.';
                        } else if (!RegExp(r'^\+92[0-9]{10}$')
                            .hasMatch(value)) {
                          return 'Invalid phone number format. valid format is +920000000000';
                        } else if (value.length != 13) {
                          return 'Phone number must be 13 digits long,';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Material(
                    elevation: 5,
                    shadowColor: Colors.black,
                    child: TextFormField(
                      controller: addressController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Address',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Color.fromARGB(247, 84, 74, 158),
                        ),
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Color.fromARGB(247, 84, 74, 158),
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your address.';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Material(
                    elevation: 5,
                    shadowColor: Colors.black,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Color.fromARGB(247, 84, 74, 158),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color.fromARGB(247, 84, 74, 158),
                        ),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password.';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters long.';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    children: [
                      Radio(
                        activeColor: const Color.fromARGB(247, 84, 74, 158),
                        value: UserRole.customer,
                        groupValue: role,
                        onChanged: (_role) {
                          setState(() {
                            role = _role!;
                          });
                        },
                      ),
                      SizedBox(width: screenHeight * 0.02),
                      const Expanded(
                        child: Text(
                          "Customer",
                          style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                        ),
                      ),
                      Radio(
                        activeColor: const Color.fromARGB(247, 84, 74, 158),
                        value: UserRole.admin,
                        groupValue: role,
                        onChanged: (_role) {
                          setState(() {
                            role = _role!;
                          });
                        },
                      ),
                      SizedBox(width: screenHeight * 0.02),
                      const Expanded(
                        child: Text(
                          "Admin",
                          style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.86,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(247, 84, 74, 158),
                        onPrimary: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          registerUser(context);
                        }
                      },
                      child: const Text(
                        'Create new account',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: const TextStyle(
                            color: Color.fromARGB(247, 84, 74, 158),
                            fontFamily: 'Poppins',
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      );
      User? user = userCredential.user;

      if (user != null) {
        // Get the user's device ID
        String deviceId = await getDeviceId();

        // Store user's data in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': nameController.text.toString(),
          'email': emailController.text.toString(),
          'phone': phoneController.text.toString(),
          'address': addressController.text.toString(),
          'role': role == UserRole.admin ? 'admin' : 'customer',
        });

        // Store device ID and user ID in a separate collection
        await FirebaseFirestore.instance.collection('userDevices').add({
          'userId': user.uid,
          'deviceId': deviceId,
        });

        Fluttertoast.showToast(
          msg: "Registration successful!",
          backgroundColor: const Color.fromARGB(247, 84, 74, 158),
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
        clearForm();
      } else {
        Fluttertoast.showToast(
          msg: "Registration failed. Please try again.",
          backgroundColor: Colors.red,
        );
      }
    } catch (exception) {
      if (kDebugMode) {
        print(exception.toString());
      }
      Fluttertoast.showToast(
        msg: exception.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  Future<String> getDeviceId() async {
    String deviceId = "";
    FirebaseMessaging message = FirebaseMessaging.instance;
    try {
      String? token = await message.getToken();
      if (token != null) {
        deviceId = token;
        if (kDebugMode) {
          print("The device id or token is $deviceId");
        }
      }
    } catch (exception) {
      if (kDebugMode) {
        print("Error getting device ID: $exception");
      }
    }

    return deviceId;
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
    passwordController.clear();
  }
}
