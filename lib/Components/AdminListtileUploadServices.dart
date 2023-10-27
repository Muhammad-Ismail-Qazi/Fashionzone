import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyCustomListTileAdminComponent extends StatefulWidget {
  String servicesName;
  String price;
  String imageFile;
  // Define a callback function for deleting a service
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  MyCustomListTileAdminComponent({
    Key? key,
    required this.servicesName,
    required this.price,
    required this.imageFile,
    required this.onDelete, // Pass the callback function
    required this.onEdit, required id,
  }) : super(key: key);

  @override
  State<MyCustomListTileAdminComponent> createState() =>
      _MyCustomListTileAdminComponentState();
}

class _MyCustomListTileAdminComponentState extends State<MyCustomListTileAdminComponent> {
  bool selection = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: ListTile(
        minVerticalPadding: 20,
        contentPadding: const EdgeInsets.all(0),
        leading:   CircleAvatar(
          backgroundImage: NetworkImage(widget.imageFile),
          radius: 40,
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: Text(
            widget.servicesName,
            style: const TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Poppins'),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: Text(
            widget.price,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                // Add functionality for editing the service here
                widget.onEdit();
              },
              icon: const Icon(Icons.edit),
              color: const Color.fromARGB(247, 84, 74, 158),
            ),
            IconButton(
              onPressed: () {
                // Add functionality for deleting the service here
                widget.onDelete();

              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
