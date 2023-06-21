import 'package:fashionzone/AdminPannels/Check_Appointment.dart';
import 'package:fashionzone/AdminPannels/UploadVideo.dart';
import 'package:fashionzone/AdminPannels/UploadServices.dart';
import 'package:fashionzone/CommonPannels/Login.dart';
import 'package:fashionzone/CommonPannels/SplashScreen.dart';
import 'package:fashionzone/CustomerPannels/Booking.dart';
import 'package:fashionzone/CustomerPannels/CustomerDashboard.dart';
import 'package:fashionzone/CommonPannels/Profile.dart';
import 'package:fashionzone/CustomerPannels/Salon.dart';
import 'package:flutter/material.dart';

import '../AdminPannels/AdminDashboard.dart';

void main() {
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
          fontFamily: 'Roboto',
        ),
        home:  const Booking(),
    );
  }
}