import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fashionzone/CustomerPannels/CustomerDashboard.dart';
import 'package:flutter/material.dart';

import '../CustomerPannels/Ar.dart';
import '../CommonPannels/Profile.dart';
import '../CustomerPannels/Reels.dart';

class MyCustomBottomNavigationBar extends StatefulWidget {
  const MyCustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyCustomBottomNavigationBar> createState() =>
      _MyCustomBottomNavigationBarState();
}

class _MyCustomBottomNavigationBarState
    extends State<MyCustomBottomNavigationBar> {
  int _currentIndex = 0;
  final screens = [
    const Customer_Dashboard(),
    const Reels(),
    const AR(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(
        Icons.home,
        size: 30,
      ),
      const Icon(
        Icons.play_circle,
        size: 30,
      ),
      const Icon(
        Icons.camera,
        size: 30,
      ),
      const Icon(
        Icons.person,
        size: 30,
      ),
    ];
    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      child: CurvedNavigationBar(
        color: const Color.fromARGB(247, 84, 74, 158),
        backgroundColor: Colors.white,
        height: MediaQuery.of(context).size.height*0.08,
        items: items,
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (_currentIndex == 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Customer_Dashboard(),
                ));

          }
          else if (_currentIndex==1){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Reels(),
                ));
          }
          else if (_currentIndex==2){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AR(),
                ));
          }
          else if (_currentIndex==3){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                ));
          }

        },
      ),
    );
  }
}
