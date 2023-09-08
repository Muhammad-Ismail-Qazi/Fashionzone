import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionzone/Components/BottomNavigationBarComponent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Components/AppBarComponent.dart';
import '../Components/DrawerComponent.dart';
import '../Components/GalleryComponent.dart';
import '../Components/ServicesComponent.dart';
import 'Booking.dart';

class Salon extends StatefulWidget {
  final String salonId;
  const Salon({Key? key,required this.salonId}) : super(key: key);

  @override
  State<Salon> createState() => _SalonState();
}

class _SalonState extends State<Salon> {
  String? salonName;
  String? coverPictureURL;
  String? logoPictureURL;
  String? userName;
  List<Map<String, dynamic>> fetchedServices = [];
  List<Map<String, dynamic>> fetchedVideos = [];
  String? serviceName ;
  String? servicePrice ;
  String? servicePictureURL;
  bool isChecked = false; // Initialize isChecked in the parent widget

  void initState() {
    super.initState();

    fetchServicesData();
    fetchVideosData();
    fetchSalonData(widget.salonId);
    fetchSalonOwnerName(widget.salonId);
    // Print the salon ID when the widget is initialized
    print('Salon ID: ${widget.salonId}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(247, 84, 74, 158),
        iconTheme: const IconThemeData(color: Color.fromARGB(247, 84, 74, 158)),
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar:
            const MyCustomAppBarComponent(appBarTitle: 'Check Salon Details'),
        drawer: const MyCustomDrawerComponent(),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  decoration:  BoxDecoration(
                    image: DecorationImage(
                      image: Image.network(coverPictureURL ?? '').image,
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
                             Text(
                              salonName.toString(),
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.black45,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            // Subtitle
                             Text(
                              userName.toString(),
                              style: const TextStyle(
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
                                Card(
                                  elevation: 5,
                                  color: const Color.fromARGB(
                                      247, 84, 74, 158), // Purple
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 6),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "4.5",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Location
                                Card(
                                  color: const Color.fromARGB(247, 84, 74, 158),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 6),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.map,
                                          color: Colors.red,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "View on Google Map",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ],
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
                                ElevatedButton(
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
                                    backgroundColor:
                                        const Color.fromARGB(247, 84, 74, 158),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const SizedBox(
                                    height: 40,
                                    width: 150,
                                    child: Center(
                                      child: Text(
                                        'Book Now',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
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
                            // Gallery
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: fetchedVideos.map((videoData) {
                                  return MyCustomGalleryComponent(
                                    galleryVideoPath:  videoData['videoUrl'].toString(),
                                  );
                                }).toList(),
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
                                children: fetchedServices.map((serviceData) {
                                  return MyCustomCustomerServicesComponent(
                                    // Pass the isChecked value
                                    servicesImagePath: serviceData['imageURL'].toString(),
                                    servicePrice: serviceData['price'].toString(),
                                    serviceName: serviceData['name'].toString(),
                                  );
                                }).toList(),
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
                        child: Image(
                          image: NetworkImage(logoPictureURL ?? ''),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.125,
                          fit: BoxFit.cover, // Adjust this as needed
                        ),
                      )

                    ),
                  ),
                ),

              ],
            ),
          ),
        ),

        // bottomNavigationBar: const MyCustomBottomNavigationBar(),
      ),
    );
  }
  Future<void> fetchSalonData(String salonId) async {
    try {
      DocumentSnapshot salonDataSnapshot =
      await FirebaseFirestore.instance.collection('salons').doc(salonId).get();

      if (salonDataSnapshot.exists) {
        Map<String, dynamic> salonData =
        salonDataSnapshot.data() as Map<String, dynamic>;
        setState(() {
          salonName = salonData['name'] ?? '';
          coverPictureURL = salonData['coverPicture'] ?? '';
          logoPictureURL = salonData['logoPicture'] ?? '';
        });
      }
    } catch (e) {
      print('Error fetching salon data: $e');
      // Handle the error as needed
    }
  }

  Future<void> fetchSalonOwnerName(String salonId) async {
    try {
      // Fetch the salon document to get the owner's UID
      DocumentSnapshot salonDataSnapshot =
      await FirebaseFirestore.instance.collection('salons').doc(salonId).get();

      if (salonDataSnapshot.exists) {
        // The salon ID is also the user ID
        String ownerUid = salonId;
        print("Owner UID: $ownerUid");

        // Query the "users" collection based on the owner's UID
        DocumentSnapshot ownerDataSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(ownerUid)
            .get();

        if (ownerDataSnapshot.exists) {
          Map<String, dynamic> ownerData =
          ownerDataSnapshot.data() as Map<String, dynamic>;
          setState(() {
            userName = ownerData['name'] ?? '';
          });
        }
      }
    } catch (e) {
      print('Error fetching owner data: $e');
      // Handle the error as needed
    }
  }


  Future<void> fetchServicesData() async {
    try {
      print("Fetching services for salon ID: ${widget.salonId}");

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('services')
          .where('userID', isEqualTo: widget.salonId)
          .get();

      List<Map<String, dynamic>> servicesData = querySnapshot.docs.map((doc) => doc.data()).toList();

      setState(() {
        fetchedServices = servicesData;
      });

      print("Service Data: $fetchedServices");
    } catch (e) {
      print("Error fetching services data: $e");
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Future<void> fetchVideosData() async {
    try {
      print("Fetching videos for salon ID: ${widget.salonId}");

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('videos')
          .where('userID', isEqualTo: widget.salonId)
          .get();

      List<Map<String, dynamic>> videosData = querySnapshot.docs.map((doc) => doc.data()).toList();

      setState(() {
        fetchedVideos = videosData;
      });

      print("Videos Data: $fetchedVideos");

      Fluttertoast.showToast(
        msg: "Videos data fetched successfully!",
        textColor: const Color.fromARGB(247, 84, 74, 158),
      );
    } catch (e) {
      print("Error fetching videos data: $e");
      Fluttertoast.showToast(
        msg: "Error fetching videos data: $e",
        textColor: Colors.red,
      );
    }
  }


}
