import 'package:fashionzone/Components/BottomNavigationBarComponent.dart';
import 'package:flutter/material.dart';

import '../Components/AppBarComponent.dart';
import '../Components/DrawerComponent.dart';
import '../Components/GalleryComponent.dart';
import '../Components/ServicesComponent.dart';
import 'Booking.dart';

class Salon extends StatefulWidget {
  const Salon({Key? key}) : super(key: key);

  @override
  State<Salon> createState() => _SalonState();
}

class _SalonState extends State<Salon> {
  bool isHover=false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(247, 84, 74, 158),
        iconTheme: const IconThemeData(color: Color.fromARGB(247, 84, 74, 158)),
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar:const  MyCustomAppBarComponent(),
        drawer: const MyCustomDrawerComponent(),
        body:  Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/background_img.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      heightFactor: 0.7,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.96),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.05,
                              ),
                              // Title
                              const Text(
                                'Gents',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black45,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                              // Subtitle
                              const Text(
                                'Hair, Color, Beard',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black45,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Rating
                                  MouseRegion(
                                    onHover: (event) {
                                      setState(() {
                                        isHover=true;
                                      });
                                    },
                                    onExit: (event) {
                                      setState(() {
                                        isHover=false;
                                      });
                                    },
                                    child: Card(
                                      elevation: 5,
                                      color: isHover
                                          ? const Color.fromARGB(247, 255, 255, 255) // White background when hovering
                                          : const Color.fromARGB(247, 84, 74, 158), // Purple
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child:  Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 6),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              "4.5",
                                              style: TextStyle(fontSize: 20 ,color: isHover ? Colors.black45 : Colors.white, ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Location
                                  MouseRegion(
                                    onHover: (event) {
                                      setState(() {
                                        isHover=true;
                                      });
                                    },
                                    onExit: (event) {
                                      setState(() {
                                        isHover=false;
                                      });
                                    },
                                    child: Card(
                                      color: isHover
                                          ? const Color.fromARGB(247, 255, 255, 255) // White background when hovering
                                          : const Color.fromARGB(247, 84, 74, 158),
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child:  Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 6),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.map,
                                              color: Colors.red,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "View on Google Map",
                                              style: TextStyle(fontSize: 20,color: isHover?Colors.black45: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MouseRegion(
                                    onHover: (event) {
                                      setState(() {
                                        isHover=true;
                                      });

                                    },
                                    onExit: (event) {
                                      setState(() {
                                        isHover=false;
                                      });
                                    },
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const Booking(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 5,
                                        backgroundColor: isHover
                                            ? const Color.fromARGB(247, 255, 255, 255) // White background when hovering
                                            : const Color.fromARGB(247, 84, 74, 158),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                      child:  SizedBox(
                                        height: 40,
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            'Book Now',
                                            style: TextStyle(fontSize: 20,color: isHover?Colors.black45: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // Text of Gallery and View more
                              Row(
                                children: [
                                  const Text(
                                    "Gallery",
                                    style: TextStyle(
                                      fontSize: 20,

                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      // Handle 'View more' tap
                                    },
                                    child: const Text(
                                      "View more",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                              // Gallery
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.15,
                                  child:  const Row(
                                    children: [
                                      MyCustomGalleryComponent(
                                        galleryImagePath: 'images/gallery1.jpg',
                                      ),
                                      MyCustomGalleryComponent(
                                        galleryImagePath: 'images/gallery2.jpg',
                                      ),
                                      MyCustomGalleryComponent(
                                        galleryImagePath: 'images/gallery3.jpg',
                                      ),
                                      MyCustomGalleryComponent(
                                        galleryImagePath: 'images/gallery4.jpg',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // Text of Services
                              Row(
                                children: [
                                  const Text(
                                    "Services",
                                    style: TextStyle(
                                      fontSize: 20,

                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      // Handle 'View more' tap
                                    },
                                    child: const Text(
                                      "View more",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                              // Services
                               SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    MyCustomServicesComponent(selection: true,
                                      servicesImagePath: 'images/services1.jpg',price: '300',
                                    ),
                                    MyCustomServicesComponent(selection: true,
                                      servicesImagePath: 'images/services2.jpg',
                                      price: "250",
                                    ),
                                    MyCustomServicesComponent(selection: false,
                                      servicesImagePath: 'images/services3.jpg',
                                      price: '150',
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.24,
                    left: MediaQuery.of(context).size.width * 0.4,
                    child: Material(
                      elevation: 5,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.125,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'images/logo0.jpeg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        bottomNavigationBar: const MyCustomBottomNavigationBar(),
      ),
    );
  }
}