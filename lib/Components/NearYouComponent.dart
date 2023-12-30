import 'package:flutter/material.dart';

import '../CustomerPannels/Salon.dart';

class MyCustomListTileComponent extends StatefulWidget {
  final String listTileLogoPath;
  final String listTileSalonName;
  MyCustomListTileComponent({
    Key? key,
    required this.listTileLogoPath,
    required this.listTileSalonName,
  }) : super(key: key);

  @override
  State<MyCustomListTileComponent> createState() =>
      _MyCustomListTileComponentState();
}

class _MyCustomListTileComponentState
    extends State<MyCustomListTileComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context,MaterialPageRoute(builder:(context) => const Salon(),));
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Material(
                elevation: 5,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      stops: const [0.0, 0.999],
                      colors: [
                        const Color.fromARGB(247, 84, 74, 158),
                        Colors.black.withOpacity(0.000001),
                      ],
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(widget.listTileLogoPath),
                      backgroundColor: Colors.white,
                      radius:
                      MediaQuery.of(context).size.width * 0.2 * 0.5,
                    ),
                    title: Text(
                      widget.listTileSalonName,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: const Text(
                      "Hair, Bear, Massage",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}