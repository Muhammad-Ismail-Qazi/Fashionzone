import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../CommonPannels/Profile.dart';
import '../CustomerPannels/Ar.dart';
import '../CustomerPannels/CustomerDashboard.dart';
import '../CustomerPannels/Reels.dart';

class MyCustomBottomNavigationBar extends StatefulWidget {
  const MyCustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyCustomBottomNavigationBar> createState() =>
      _MyCustomBottomNavigationBarState();
}

class _MyCustomBottomNavigationBarState
    extends State<MyCustomBottomNavigationBar> {
  final screens =  [
    const CustomerDashboard(),
    const Reels(),
    AR(),
    const Profile(),
  ];
  final navbarItems = const [
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(
      Icons.play_circle,
      size: 30,
    ),
    Icon(
      Icons.camera,
      size: 30,
    ),
    Icon(
      Icons.person,
      size: 30,
    ),
  ];
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Theme(
        data: ThemeData(
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        child: CurvedNavigationBar(
          color: const Color.fromARGB(247, 84, 74, 158),
          height: 60,
          items: navbarItems,
          index: currentIndex,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: const Color.fromARGB(247, 84, 74, 158),
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
      body: screens[currentIndex],
    );
  }
}