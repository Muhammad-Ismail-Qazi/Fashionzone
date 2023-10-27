// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isHover = false;
  bool isLoading = false;
  // final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              const SizedBox(
                height: 50,
              ),
              //forgot button
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
                        // sendEmail();
                        setState(() {
                          isHover = true;
                        });
                      }
                    },
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: isHover ? Colors.black45 : Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void sendEmail() {
  //   auth
  //       .sendPasswordResetEmail(email: emailController.text.toString())
  //       .then((value) {
  //     Fluttertoast.showToast(
  //       msg: "Please check your spam folder  to reset your password!",
  //       backgroundColor: const Color.fromARGB(247, 84, 74, 158),
  //       textColor: Colors.white,
  //     );
  //
  //   })
  //       .onError((error, stackTrace) {
  //     Fluttertoast.showToast(
  //       msg:error.toString(),
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //     );
  //   });
  // }
}
