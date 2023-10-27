import 'package:flutter/material.dart';

import '../CustomerPannels/Salon.dart';

class MyCustomCardComponent extends StatefulWidget {
  final String salonCoverImagePath;
  final String stars;
  final String salonLogoPath;
  final String salonName;
  final String owner;
  // final String salonId;

  MyCustomCardComponent({
    Key? key,
    required this.salonCoverImagePath,
    required this.salonLogoPath,
    required this.salonName,
    required this.stars,
    required this.owner,
    // required this.salonId,
  }) : super(key: key);

  @override
  State<MyCustomCardComponent> createState() => _MyCustomCardComponentState();
}

class _MyCustomCardComponentState extends State<MyCustomCardComponent> {

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.03),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        width: screenWidth * 0.7,
        height: screenWidth * 0.67,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
          child: Material(
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.1, 0.5],
                  colors: [
                    const Color.fromARGB(247, 84, 74, 158),
                    Colors.black.withOpacity(0.000001),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.05),
                            child: Image.network(
                              widget.salonCoverImagePath,
                              height: screenHeight * 0.2,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            bottom: screenHeight * 0.01,
                            left: screenWidth * 0.02,
                            child: Container(
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(247, 84, 74, 158),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.yellow),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.stars,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color.fromARGB(255, 108, 1, 171),
                            ),
                          ),
                          child: CircleAvatar(
                            radius: screenWidth * 0.1,
                            backgroundImage:
                                NetworkImage(widget.salonLogoPath),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        title: Text(
                          widget.salonName,
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(widget.owner,
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigateToSalon(BuildContext context, String salonId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Salon(salonId: salonId)),
    );
  }


}
