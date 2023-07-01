import 'package:flutter/material.dart';
class MyCustomAppBarComponent extends StatefulWidget implements PreferredSizeWidget {
  const MyCustomAppBarComponent({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _MyCustomAppBarComponentState createState() => _MyCustomAppBarComponentState();
}

class _MyCustomAppBarComponentState extends State<MyCustomAppBarComponent> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:const Color.fromARGB(247, 84, 74, 158),
      shadowColor: Colors.black,
      elevation: 5,
      title: const Center(
        child: Text(
          "FASHIONZONE",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 24,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: () {
            // Handle notification icon press here
          },
        ),
      ],
    );
  }
}
