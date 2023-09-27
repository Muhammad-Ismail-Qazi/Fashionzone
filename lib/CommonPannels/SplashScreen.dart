import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../CustomerPannels/CustomerDashboard.dart';
import 'Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  // Function to check if the user is logged in
  void checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 5)); // Simulate some delay for the splash screen

    User? user = auth.currentUser;
    if (user != null) {
      print("User already logged in");
      // User is already logged in, navigate to the CustomerDashboard
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const CustomerDashboard()));
    } else {
      // User is not logged in, navigate to the Login screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(240, 249, 249, 252),
        body: Center(
          child: Container(
            height: 150,
              width: 150,
              child: Image(image: AssetImage('images/logo.png'))),
        ),
      ),
    );
  }
}
