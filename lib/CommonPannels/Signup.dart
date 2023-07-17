import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

enum userRole { customer, admin }

class _SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  userRole role = userRole.customer;
  bool isHover = false;
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
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.1),
                  child: SizedBox(
                    child: Image(
                      image: const AssetImage('images/logo.png'),
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: Material(
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
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(247, 84, 74, 158),
                            width: 1,
                          ),
                        ),
                        border: OutlineInputBorder(),
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
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: Material(
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
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(247, 84, 74, 158),
                            width: 1,
                          ),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an email address.';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Invalid email format. Please enter a valid email address.';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: Material(
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
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(247, 84, 74, 158),
                            width: 1,
                          ),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a phone number.';
                        }
                        else if (!RegExp(r'^\+92[0-9]{10}$').hasMatch(value)) {
                          return 'Invalid phone number format. valid format is +920000000000';
                        } else if (value.length != 13) {
                          return 'Phone number must be 13 digits long,';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: Material(
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
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(247, 84, 74, 158),
                            width: 1,
                          ),
                        ),
                        border: OutlineInputBorder(),
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
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: Material(
                    elevation: 5,
                    shadowColor: Colors.black,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
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
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(247, 84, 74, 158),
                            width: 1,
                          ),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password.';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long.';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.07),
                  child: Row(
                    children: [
                      Radio(
                        activeColor: const Color.fromARGB(247, 84, 74, 158),
                        value: userRole.customer,
                        groupValue: role,
                        onChanged: (_role) {
                          setState(() {
                            role = _role!;
                          });
                        },
                      ),
                      const SizedBox(width: 5),
                      const Expanded(
                        child: Text(
                          "customer",
                          style:
                          TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                        ),
                      ),
                      Radio(
                        activeColor: const Color.fromARGB(247, 84, 74, 158),
                        value: userRole.admin,
                        groupValue: role,
                        onChanged: (_role) {
                          setState(() {
                            role = _role!;
                          });
                        },
                      ),
                      const SizedBox(width: 5),
                      const Expanded(
                        child: Text(
                          "Admin",
                          style:
                          TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                        ),
                      ),
                    ],
                  ),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Login(),));
                        registerUser();
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
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: Color.fromARGB(247, 84, 74, 158),
                          fontFamily: 'Poppins',
                          fontSize: 14,

                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const Login()),
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
    );
  }

  Future<void> registerUser() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),

      );
      User? user = userCredential.user;

      if (user != null) {
        print("if codition");

        // Additional user registration logic here (e.g., storing user data in Firestore)
        Fluttertoast.showToast(msg: "Registration successful!",backgroundColor: const Color.fromARGB(247, 84, 74, 158) ,);
        clearForm();
      } else {
        print("else codition");
        Fluttertoast.showToast(msg: "Registration failed. Please try again.",backgroundColor: Colors.red);
      }
    } catch (e) {
      print("catch codition");
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
    }
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
    passwordController.clear();
  }
}