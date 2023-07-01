import 'package:flutter/material.dart';
import '../CustomerPannels/Salon.dart';

class MyCustomCard_Component extends StatefulWidget {
  final String salonImagePath;
  final String stars;
  final String salonLogoPath;
  final String salonName;

  MyCustomCard_Component({
    Key? key,
    required this.salonImagePath,
    required this.salonLogoPath,
    required this.salonName,
    required this.stars,
  }) : super(key: key);

  @override
  State<MyCustomCard_Component> createState() =>
      _MyCustomCard_ComponentState();
}

class _MyCustomCard_ComponentState extends State<MyCustomCard_Component> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.03),
      child: Container(  // properties of a whole
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth*0.05),
        ),
        width: screenWidth * 0.7,
        height: screenWidth * 0.67,
        child: GestureDetector(
          onTap: () {
            // Navigate to the desired page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Salon()),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth*0.05),
            child: Material(
              elevation: 5,
              child: Container(
                decoration:   BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth*0.05),
                  
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0.0, 0.999],
                    colors: [

                      const Color.fromARGB(247, 84, 74, 158),
                      Colors.black.withOpacity(0.000001),
                    ],
                  ),

                  ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),// padding between image and card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Stack(
                        children: [
                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(screenWidth * 0.05),
                            child: Image(
                              image: AssetImage(widget.salonImagePath),
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
                                borderRadius:
                                BorderRadius.circular(20),
                                color: const  Color.fromARGB(247, 84, 74, 158) ,
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.yellow),
                                  const SizedBox(width: 5,),
                                  Text(widget.stars,style: const TextStyle(fontSize: 16,color: Colors.white),),
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
                              color: const Color.fromARGB(255, 108, 1, 171),),
                          ),
                          child: CircleAvatar(
                            radius: screenWidth * 0.1,
                            backgroundImage: AssetImage(widget.salonLogoPath),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        title: Text(
                          widget.salonName,
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontFamily: 'Poppins',
                            color: Colors.white
                          ),
                        ),
                        subtitle: const Text("Hair, clean, cut",style: TextStyle(color: Colors.white)),
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
}
