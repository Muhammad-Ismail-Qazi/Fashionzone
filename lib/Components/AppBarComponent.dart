import 'package:flutter/material.dart';
class MyCustomAppBarComponent extends StatefulWidget implements PreferredSizeWidget {
  final  String appBarTitle;
  const MyCustomAppBarComponent({Key? key, required this.appBarTitle }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _MyCustomAppBarComponentState createState() => _MyCustomAppBarComponentState();
}

class _MyCustomAppBarComponentState extends State<MyCustomAppBarComponent> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:const Color.fromARGB(247, 84, 74, 158),

      elevation: 5,
      title:  Center(
        child: Text(
          widget.appBarTitle,
          style: const TextStyle(
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
      iconTheme: const IconThemeData(

          color: Colors.white), // Set the drawer icon color here

    );
  }
}
