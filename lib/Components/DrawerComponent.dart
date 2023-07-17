import 'package:fashionzone/CommonPannels/Login.dart';
import 'package:fashionzone/CustomerPannels/CustomerDashboard.dart';
import 'package:fashionzone/CommonPannels/Profile.dart';
import 'package:flutter/material.dart';

import '../CustomerPannels/Ar.dart';
import '../CustomerPannels/Reels.dart';

class MyCustomDrawerComponent extends StatefulWidget {
  const MyCustomDrawerComponent({Key? key}) : super(key: key);

  @override
  State<MyCustomDrawerComponent> createState() => _MyCustomDrawerComponentState();
}

class _MyCustomDrawerComponentState extends State<MyCustomDrawerComponent> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      backgroundColor: const Color.fromARGB(242, 248, 249, 252),
      child: ListView(
        padding: EdgeInsets.zero, // Set padding to zero
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(247, 84, 74, 158),),
            accountName: Text('Muhammad Ismail' ,style: TextStyle(color: Colors.white,fontSize: 20)),
            accountEmail: Text('dummy@email.com',style: TextStyle(color: Colors.white,fontSize: 16)),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('images/logo.png'),
              backgroundColor: Colors.white,
            ),
          ),
          ListTile(
            leading: Container(
              height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color:Color.fromARGB(247, 84, 74, 158) ,
                  borderRadius: BorderRadius.all(Radius.circular(8))

                ),
                child: const Icon(Icons.home, color: Colors.white,size: 30,)),
            title: const Text(
              'Home',
              style: TextStyle(
                color: Color.fromARGB(247, 84, 74, 158),
                fontFamily: 'Poppins',
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerDashboard(),));
            },
            mouseCursor: MaterialStateMouseCursor.clickable,
          ),
          const Divider(),
          ListTile(
            leading: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    color:Color.fromARGB(247, 84, 74, 158) ,
                    borderRadius: BorderRadius.all(Radius.circular(8))

                ),
                child: const Icon(Icons.play_circle_outlined, color: Colors.white)
            ),
            title: const Text(
              'Reels',
              style: TextStyle(
                color: Color.fromARGB(247, 84, 74, 158) ,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Reels(),));
            },
            mouseCursor: MaterialStateMouseCursor.clickable,
          ),
          const Divider(),
          ListTile(
            enabled: true,
            leading: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    color:Color.fromARGB(247, 84, 74, 158) ,
                    borderRadius: BorderRadius.all(Radius.circular(8))

                ),
                child: const Icon(Icons.camera_alt, color: Colors.white)),
            title: const Text(
              'Filter',
              style: TextStyle(
                color: Color.fromARGB(247, 84, 74, 158) ,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AR(),));
            },
            mouseCursor: MaterialStateMouseCursor.clickable,
          ),
          const Divider(),
          ListTile(
            enabled: true,
            leading: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    color:Color.fromARGB(247, 84, 74, 158) ,
                    borderRadius: BorderRadius.all(Radius.circular(8))

                ),
                child: const Icon(Icons.person, color: Colors.white)),
            title: const Text(
              'Profile',
              style: TextStyle(
                color:Color.fromARGB(247, 84, 74, 158) ,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile(),));
            },
            mouseCursor: MaterialStateMouseCursor.clickable,
          ),
          const Divider(),
          ListTile(
            enabled: true,
            leading: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    color:Color.fromARGB(247, 84, 74, 158) ,
                    borderRadius: BorderRadius.all(Radius.circular(8))

                ),
                child: const Icon(Icons.logout, color: Colors.white)),
            title: const Text(
              'Logout',
              style: TextStyle(
                color:Color.fromARGB(247, 84, 74, 158) ,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Login(),));
            },
            mouseCursor: MaterialStateMouseCursor.clickable,
          ),
          
        ],
      ),
    );
  }
}
