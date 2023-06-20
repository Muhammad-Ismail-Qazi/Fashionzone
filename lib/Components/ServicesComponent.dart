import 'package:flutter/material.dart';

class MyCustomServicesComponent extends StatefulWidget {
  final String servicesImagePath;
  final String price;
  bool selection = false;

  MyCustomServicesComponent({
    Key? key,
    required this.servicesImagePath,
    required this.price,
    required this.selection,
  }) : super(key: key);

  @override
  State<MyCustomServicesComponent> createState() =>
      _MyCustomServicesComponentState();
}

class _MyCustomServicesComponentState extends State<MyCustomServicesComponent> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Material(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        widget.servicesImagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      value: widget.selection,
                      activeColor: const Color.fromARGB(247, 84, 74, 158),
                      onChanged: (value) {
                        setState(() {
                        widget.selection=! widget.selection;
                        });
                      },
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: const [0.0, 0.9],
                          colors: [
                            const Color.fromARGB(247, 84, 74, 158),
                            Colors.black.withOpacity(0.001),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Transform.translate(
              offset: const Offset(90, -10),
              child: Text(
                widget.price,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
