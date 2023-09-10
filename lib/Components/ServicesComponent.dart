import 'package:flutter/material.dart';

class MyCustomCustomerServicesComponent extends StatefulWidget {
  final String servicesImagePath;
  final String servicePrice;
  final String serviceName;


  MyCustomCustomerServicesComponent({
    Key? key,
    required this.servicesImagePath,
    required this.servicePrice,
    required this.serviceName,


  }) : super(key: key);

  @override
  State<MyCustomCustomerServicesComponent> createState() =>
      _MyCustomCustomerServicesComponentState();
}

class _MyCustomCustomerServicesComponentState extends State<MyCustomCustomerServicesComponent> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.13,
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
                      child: Image(
                        image: NetworkImage(widget.servicesImagePath),
                        fit: BoxFit.cover,
                      ),
                    )

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
            child: Transform.translate(
              offset: const Offset(90, -10),
              child: Text(
                widget.servicePrice,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
