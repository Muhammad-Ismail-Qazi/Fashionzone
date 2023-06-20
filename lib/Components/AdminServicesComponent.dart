import 'package:flutter/material.dart';

class MyCustomAdminServicesComponent extends StatefulWidget {
  final String servicesImagePath;
  String price;
  MyCustomAdminServicesComponent(
      {Key? key, required this.servicesImagePath, required this.price})
      : super(key: key);

  @override
  State<MyCustomAdminServicesComponent> createState() => _MyCustomAdminServicesComponentState();
}

class _MyCustomAdminServicesComponentState extends State<MyCustomAdminServicesComponent> {
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
                  child: Image.asset(
                    widget.servicesImagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Align(
                  alignment: Alignment.bottomCenter ,
                  child: Text(widget.price,style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
            ],
          ),
        ),
      ),
    );
  }
}
