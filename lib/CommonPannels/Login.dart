import 'package:fashionzone/AdminPannels/AdminDashboard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../CustomerPannels/CustomerDashboard.dart';
import 'Signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}
enum userRole { customer, admin }
class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  userRole role = userRole.customer;
  bool isHover=false;
  bool isEyeOpen=true;


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor:  const Color.fromARGB(252, 241, 239, 248),
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
                        height: MediaQuery.of(context).size.height*0.25,
                        width: MediaQuery.of(context).size.width*0.25,
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
                              labelStyle:
                              TextStyle(fontFamily: 'Roboto', fontSize: 16,color: Color.fromARGB(247, 84, 74, 158)),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color.fromARGB(247, 84, 74, 158),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color.fromARGB(247, 84, 74, 158), width: 1),
                              ),
                              border: OutlineInputBorder()),
                          style: const TextStyle(
                              fontFamily: 'Roboto', fontSize: 16),
                          validator: (email)=>email != null && !EmailValidator.validate(email) ?
                          'Enter a valid email' : null,
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
                          decoration:  InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Password',
                              labelStyle:
                              const TextStyle(fontFamily: 'Roboto', fontSize: 16, color: Color.fromARGB(247, 84, 74, 158)),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Color.fromARGB(247, 84, 74, 158),
                              ),
                              suffixIcon:  GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isEyeOpen=! isEyeOpen;
                                  });

                                },
                                child: Icon(isEyeOpen ? Icons.visibility :Icons.visibility_off, color: const Color.fromARGB(247, 84, 74, 158)
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color.fromARGB(247, 84, 74, 158), width: 1),
                              ),
                              border: const OutlineInputBorder()),
                          style: const TextStyle(
                              fontFamily: 'Roboto', fontSize: 16),
                          validator: (value) {
                          if (value!=null && value.length<8){
                            return 'Enter min 7 character ';
                          }
                          else {
                            return null;
                          }

                            return null;
                          }),
                    ),
                  ),
                  // forgot password
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.07),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // Implement the logic for handling the "Forgot Password" action
                          // This could include showing a password reset dialog, navigating to a password reset screen, etc.
                          // You can add your own code here.
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            decoration: TextDecoration.underline,
                            color: Color.fromARGB(247, 84, 74, 158),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Radio Button
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
                            style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
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
                            style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                          ),
                        ),
                      ],
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
                          final isValidationform=formKey.currentState!.validate();
                          if (formKey.currentState!.validate()) {
                            if (role == userRole.customer) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Customer_Dashboard(),
                                ),
                              );
                            } else if (role == userRole.admin) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AdminDashboard(),
                                ),
                              );
                            } else {
                              setState(() {
                                role = userRole.customer; // Update the role here
                              });
                            }

                            // Reset isHover after the button is clicked
                            setState(() {
                              isHover = false;
                            });
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            color: isHover ? Colors.black45 : Colors.white, // black45 text when not hovering, white text when hovering
                          ),
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
                          fontFamily: 'Roboto',
                          color: Colors.black45,
                        ),
                        children: [
                          TextSpan(
                            text: "Signup",
                            style: const TextStyle(
                              color: Color.fromARGB(247, 84, 74, 158),
                            ),
                            // Handle the login action here
                            // Add the `onTap` callback to handle the tap on "Login"
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const Signup(),));
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

      ),
    );
  }
}
