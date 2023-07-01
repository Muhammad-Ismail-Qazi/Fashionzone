import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Login.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  bool isHover=false;
  @override
  void dispose(){
    //TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(247, 84, 74, 158),

        iconTheme: const IconThemeData(color: Color.fromARGB(247, 84, 74, 158)),
        fontFamily: 'Poppins',
      ),
      home: Scaffold(

          body: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    // image
                     Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.1,
                      ),
                      child:  SizedBox(
                        child: Image(
                            image: const AssetImage('images/logo.png'),
                          height: MediaQuery.of(context).size.height*0.25,
                          width: MediaQuery.of(context).size.width*0.25,
                        ),
                      ),
                    ),
                    // full name
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
                                labelStyle:
                                TextStyle(fontFamily: 'Poppins', fontSize: 16,color: Color.fromARGB(247, 84, 74, 158)),
                                prefixIcon: Icon(
                                  Icons.person,
                                 color: Color.fromARGB(247, 84, 74, 158),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color.fromARGB(247, 84, 74, 158), width:1),
                                ),
                                border: OutlineInputBorder()),
                            style:
                            const TextStyle(fontFamily: 'Poppins', fontSize: 15),
                            validator: (value) {
                              if (value!.isEmpty && value.length<3) {
                                return 'Please enter your full name.';
                              } else if (!RegExp(r'^[A-Za-z\s]+$')
                                  .hasMatch(value)) {
                                return 'Invalid name format. Please enter a valid name.';
                              }
                              else{
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
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Email',
                                labelStyle:
                                TextStyle(fontFamily: 'Poppins', fontSize: 16,color: Color.fromARGB(247, 84, 74, 158)),
                                prefixIcon: Icon(
                                  Icons.email,
                                 color: Color.fromARGB(247, 84, 74, 158),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color.fromARGB(247, 84, 74, 158), width:1),
                                ),
                                border: OutlineInputBorder()),
                            style:
                            const TextStyle(fontFamily: 'Poppins', fontSize: 15),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email address.';
                              } else if (!RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                  .hasMatch(value)) {
                                return 'Invalid email address format. Please enter a valid email address.';
                              }
                              else{
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
                                labelText: 'Phone',
                                labelStyle:
                                TextStyle(fontFamily: 'Poppins', fontSize: 16,color: Color.fromARGB(247, 84, 74, 158)),
                                prefixIcon: Icon(
                                  Icons.phone,
                                 color: Color.fromARGB(247, 84, 74, 158),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color.fromARGB(247, 84, 74, 158), width:1),
                                ),
                                border: OutlineInputBorder()),
                            style:
                            const TextStyle(fontFamily: 'Poppins', fontSize: 15),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone number.';
                              } else if (!RegExp(r'^\+92\d{10}$').hasMatch(value)) {
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
                          controller: addressController,
                            keyboardType: TextInputType.streetAddress,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Address',
                                labelStyle:
                                TextStyle(fontFamily: 'Poppins', fontSize: 16,color: Color.fromARGB(247, 84, 74, 158)),
                                prefixIcon: Icon(
                                  Icons.location_city,
                                 color: Color.fromARGB(247, 84, 74, 158),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color.fromARGB(247, 84, 74, 158), width:1),
                                ),
                                border: OutlineInputBorder()),
                            style:
                            const TextStyle(fontFamily: 'Poppins', fontSize: 15),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your street address.';
                              }
                              else{
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
                          controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Password',
                                labelStyle:
                                TextStyle(fontFamily: 'Poppins', fontSize: 16,color: Color.fromARGB(247, 84, 74, 158)),
                                prefixIcon: Icon(
                                  Icons.password,
                                 color: Color.fromARGB(247, 84, 74, 158),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color.fromARGB(247, 84, 74, 158), width:1),
                                ),
                                border: OutlineInputBorder()),
                            style:
                            const TextStyle(fontFamily: 'Poppins', fontSize: 15),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password.';
                              } else if (value.length < 8) {
                                return 'Password should be at least 8 characters long.';
                              }
                              else {
                                return null;
                              }


                            }),
                      ),
                    ),
                    // space
                    const SizedBox(height: 20),
                    //radio button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.07),
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
                              style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
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
                              style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                            ),
                          ),
                        ],
                      ),
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
                                ? const Color.fromARGB(247, 255, 255, 255) // White background when hovering
                                : const Color.fromARGB(247, 84, 74, 158), // Purple background when not hovering
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // Perform your desired actions when the button is pressed

                              // Access form field values
                              // Perform account creation or other operations here

                              // Example code to create user account using FirebaseAuth
                              auth.createUserWithEmailAndPassword(
                                 email: emailController.text,
                                password: passwordController.text,
                              ).then((value) {
                                // Account created successfully
                                // Do something
                                Fluttertoast.showToast(
                                  msg: "Account Successfully created!",
                                  backgroundColor:const  Color.fromARGB(247, 84, 74, 158),
                                  textColor: Colors.white,
                                );
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const Login(),));
                              }).onError((error, stackTrace) {
                                // Error occurred during account creation
                                Fluttertoast.showToast(
                                  msg: error.toString(),
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                              });

                              setState(() {
                                isHover = false;
                              });
                            }
                          },
                          child: Text(
                            "Create new account",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              color: isHover ? Colors.black45 : Colors.white, // black45 text when not hovering, white text when hovering
                            ),
                          ),
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Colors.black54,
                          ),
                          children: [
                            TextSpan(
                              text: "Login",
                              style: const TextStyle(

                                color: Color.fromARGB(247, 84, 74, 158),
                              ),
                              // Handle the login action here
                              // Add the `onTap` callback to handle the tap on "Login"
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Login(),
                                      ));
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
          )
      ),
    );
  }
}
