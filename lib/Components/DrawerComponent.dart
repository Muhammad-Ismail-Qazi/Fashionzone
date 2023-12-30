import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionzone/CommonPannels/Login.dart';
import 'package:fashionzone/CommonPannels/Profile.dart';
import 'package:fashionzone/CustomerPannels/CustomerDashboard.dart';
import 'package:fashionzone/CustomerPannels/ar/deep_ar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../CustomerPannels/Reels.dart';

class MyCustomDrawerComponent extends StatefulWidget {
  const MyCustomDrawerComponent({Key? key}) : super(key: key);

  @override
  State<MyCustomDrawerComponent> createState() =>
      _MyCustomDrawerComponentState();
}

class _MyCustomDrawerComponentState extends State<MyCustomDrawerComponent> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  String name = '';
  String email = '';
  String? profilePictureURL;

  Future<Map<String, dynamic>?> getUserData() async {
    final currentUserUid = auth.currentUser?.uid;
    if (currentUserUid != null) {
      try {
        final userDoc =
            await firestore.collection('users').doc(currentUserUid).get();
        if (userDoc.exists) {
          final userData = userDoc.data();
          return userData;
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final currentUserUid = auth.currentUser?.uid;
    return Drawer(
      elevation: 5,
      backgroundColor: const Color.fromARGB(242, 248, 249, 252),
      child: FutureBuilder<Map<String, dynamic>?>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(247, 84, 74, 158),
                ),
              ),
            );
          } else if (snapshot.hasData) {
            final userData = snapshot.data!;
            name = userData['name'] ?? '';
            email = userData['email'] ?? '';
            profilePictureURL = userData['profilePicture'] ?? '';
          }
          return Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(247, 84, 74, 158),
                ),
                accountName: Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                accountEmail: Text(
                  email,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 50,
                  backgroundImage: profilePictureURL == null
                      ? null
                      : Image.network(profilePictureURL!).image,
                  backgroundColor: Colors.white,
                ),
              ),
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(247, 84, 74, 158),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                title: const Text(
                  'Home',
                  style: TextStyle(
                    color: Color.fromARGB(247, 84, 74, 158),
                    fontFamily: 'Poppins',
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerDashboard(),
                    ),
                  );
                },
                mouseCursor: MaterialStateMouseCursor.clickable,
              ),
              const Divider(),
              ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(247, 84, 74, 158),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Icon(Icons.play_circle_outlined,
                      color: Colors.white),
                ),
                title: const Text(
                  'Reels',
                  style: TextStyle(
                    color: Color.fromARGB(247, 84, 74, 158),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Reels(),
                    ),
                  );
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
                    color: Color.fromARGB(247, 84, 74, 158),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Icon(Icons.camera_alt, color: Colors.white),
                ),
                title: const Text(
                  'Filter',
                  style: TextStyle(
                    color: Color.fromARGB(247, 84, 74, 158),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeepArExample(),
                      // builder: (context) => AR(),
                    ),
                  );
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
                    color: Color.fromARGB(247, 84, 74, 158),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                title: const Text(
                  'Profile',
                  style: TextStyle(
                    color: Color.fromARGB(247, 84, 74, 158),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Profile(),
                    ),
                  );
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
                        color: Color.fromARGB(247, 84, 74, 158),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: const Icon(Icons.logout, color: Colors.white)),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Color.fromARGB(247, 84, 74, 158),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  auth.signOut().then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ));
                  });
                },
                mouseCursor: MaterialStateMouseCursor.clickable,
              ),
            ],
          );
        },
      ),
    );
  }
}
