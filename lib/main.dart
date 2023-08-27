import 'package:fashionzone/AdminPannels/UploadVideo.dart';
import 'package:fashionzone/CommonPannels/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  // debugPaintSizeEnabled = true;
  runApp(const Fashionzone());
}

class Fashionzone extends StatelessWidget {
  const Fashionzone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(247, 84, 74, 158),
          backgroundColor:const Color.fromARGB(247, 84, 74, 158) ,
          iconTheme: const IconThemeData(color: Color.fromARGB(247, 84, 74, 158)),
          fontFamily: 'Poppins',
        ),
        home: const SplashScreen(),
    );
  }
}