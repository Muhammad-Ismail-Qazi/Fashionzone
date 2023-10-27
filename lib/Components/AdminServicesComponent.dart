import 'package:flutter/material.dart';

class MyCustomAdminServicesComponent extends StatefulWidget {
  final String servicesImagePath;
  String price;
  final String serviceName;
  MyCustomAdminServicesComponent(
      {Key? key, required this.servicesImagePath,
        required this.price,
        required this.serviceName,
      })
      : super(key: key);

  @override
  State<MyCustomAdminServicesComponent> createState() =>
      _MyCustomAdminServicesComponentState();
}

class _MyCustomAdminServicesComponentState
    extends State<MyCustomAdminServicesComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: NetworkImage(widget.servicesImagePath),
                      fit: BoxFit.cover,
                    ),
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
              Positioned(
                top: 10, // Adjust the top position as needed
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    widget.serviceName,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    widget.price,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
