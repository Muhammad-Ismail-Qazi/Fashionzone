import 'package:flutter/material.dart';

class MyCustomListTileComponent extends StatefulWidget {
  String servicesName;
  int price;

  MyCustomListTileComponent({
    Key? key,
    required this.servicesName,
    required this.price,
  }) : super(key: key);

  @override
  State<MyCustomListTileComponent> createState() =>
      _MyCustomListTileComponentState();
}

class _MyCustomListTileComponentState extends State<MyCustomListTileComponent> {
  bool selection = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: ListTile(
        minVerticalPadding: 20,
        contentPadding: const EdgeInsets.all(0),
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
            'Price: ${widget.price}',
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                // Add functionality for editing the service here
              },
              icon: const Icon(Icons.edit),
              color: const Color.fromARGB(247, 84, 74, 158),
            ),
            IconButton(
              onPressed: () {
                // Add functionality for deleting the service here
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
