import 'package:fashionzone/AdminPannels/AdminDashboard.dart';
import 'package:fashionzone/CommonPannels/ForgotPassword.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../CustomerPannels/CustomerDashboard.dart';
import 'Signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

enum UserRole { customer, admin }

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  UserRole role = UserRole.customer;

  bool isEyeOpen = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(252, 241, 239, 248),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                //Top logo
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

                //email
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: Material(
                    elevation: 5,
                    shadowColor: Colors.black45,
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
                        fontSize: 16,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email address.';
                        } else if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                            .hasMatch(value)) {
                          return 'Invalid email address format.';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                // space
                const SizedBox(
                  height: 20,
                ),
                // password
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: Material(
                    elevation: 5,
                    shadowColor: Colors.black45,
                    child: TextFormField(
                      obscureText: isEyeOpen,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Color.fromARGB(247, 84, 74, 158),
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Color.fromARGB(247, 84, 74, 158),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isEyeOpen = !isEyeOpen;
                            });
                          },
                          child: Icon(
                            isEyeOpen ? Icons.visibility : Icons.visibility_off,
                            color: const Color.fromARGB(247, 84, 74, 158),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(247, 84, 74, 158),
                            width: 1,
                          ),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                      validator: (value) {
                        if (value != null && value.length < 8) {
                          return 'Enter min 8 characters.';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                // forgot password
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.07),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // Implement the logic for handling the "Forgot Password" action
                        // This could include showing a password reset dialog, navigating to a password reset screen, etc.
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ));
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          decoration: TextDecoration.underline,
                          color: Color.fromARGB(247, 84, 74, 158),
                        ),
                      ),
                    ),
                  ),
                ),
                //space
                const SizedBox(
                  height: 30,
                ),
                //Login button
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor:  const Color.fromARGB(247, 84, 74,
                              158), // Purple background when not hovering
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        login();

                      }
                    },
                    child: isLoading
                        ? const CircularProgressIndicator( color: Colors.white,)
                        : const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                // don't have an account
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Colors.black45,
                      ),
                      children: [
                        TextSpan(
                          text: "Signup",
                          style: const TextStyle(
                            color: Color.fromARGB(247, 84, 74, 158),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Signup(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> fetchUserRoleFromFirestore(String userId) async {
    String role = "customer"; // Default role, assuming the user is a customer

    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();

      if (snapshot.exists) {
        role = snapshot.get("role");
      }
    } catch (e) {
      print("Error fetching user role: $e");
    }

    return role;
  }

  Future<void> login() async {
    try {
      setState(() {
        isLoading = true;
      });

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      );
      User? user = userCredential.user;

      if (user != null) {
        String role = await fetchUserRoleFromFirestore(user.uid);

        if (role == 'admin') {
          // If the user role is 'admin', navigate to the AdminDashboard
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AdminDashboard(),
            ),
          );
        } else {
          // If the user role is 'customer', navigate to the CustomerDashboard
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerDashboard(),
            ),
          );
        }

        Fluttertoast.showToast(
          msg: "Logged in successfully!",
          backgroundColor: const Color.fromARGB(247, 84, 74, 158),
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Invalid email or password.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      setState(() {
        isLoading = false;
      });
    }
  }
}
