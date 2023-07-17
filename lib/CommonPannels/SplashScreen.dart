import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'Login.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SizedBox(
        height: MediaQuery.of(context).size.height*0.15,
        width: MediaQuery.of(context).size.width*0.15,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(224, 281, 249, 232),
          body: AnimatedSplashScreen(
            splash: const Image(image: AssetImage('images/logo.png')),
            nextScreen: const Login(),
            splashTransition: SplashTransition.scaleTransition,
            animationDuration: const Duration(seconds: 2),

            splashIconSize: 150,

          ),
        ),
      ),
    );
  }
}
