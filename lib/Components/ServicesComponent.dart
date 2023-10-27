import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCustomCustomerServicesComponent extends StatefulWidget {
  final String servicesImagePath;
  final String servicePrice;
  final String serviceName;
  final Function(bool isSelected) onServiceSelected;

  const MyCustomCustomerServicesComponent({
    Key? key,
    required this.servicesImagePath,
    required this.servicePrice,
    required this.serviceName,
    required this.onServiceSelected,
  }) : super(key: key);

  @override
  State<MyCustomCustomerServicesComponent> createState() =>
      _MyCustomCustomerServicesComponentState();
}

class _MyCustomCustomerServicesComponentState
    extends State<MyCustomCustomerServicesComponent> {
  bool isSelected = false;

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
          // Price (Top Center)
          Positioned(
            top: 15,
            right: 50,
            left: 80,
            child: Transform.translate(
              offset: const Offset(0, -10),
              child: Text(
                widget.servicePrice,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          // Name (Bottom Center)
          Positioned(
            bottom: 10,
            left: 100/2,
            right: 100/2,
            child: Text(
              widget.serviceName,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          // Add the "+" icon button with circular background to the top right corner
          Positioned(
            top: 5,
            right: 18,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: const Color.fromARGB(247, 84, 74, 158),
              child: Center(
                child: IconButton(
                  icon: isSelected
                      ? const Icon(Icons.minimize, color: Colors.white, size: 20)
                      : const Icon(Icons.add, color: Colors.white, size: 20),
                  onPressed: () {
                    setState(() {
                      isSelected = !isSelected;
                    });
                    widget.onServiceSelected(isSelected);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
