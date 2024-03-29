
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Components/AppBarComponent.dart';
import '../Components/DrawerComponent.dart';
import '../Components/NearYouComponent.dart';
import '../Components/TopSalonComponent.dart';
import 'Salon.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({Key? key}) : super(key: key);

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  String? salonName;
  String? coverPictureURL;
  String? logoPictureURL;
  String? userName;
  bool isLoading = true; // Track whether data is being fetched
  List<Map<String, dynamic>> salonList = [];
  List<String> salonIds = []; // Create a list to store salon IDs
  String? salonIdGet;
  String? salonIdPass;
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    fetchSalonData();
    searchController = TextEditingController();
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
        backgroundColor: const Color.fromARGB(240, 249, 249, 252),
        appBar: const MyCustomAppBarComponent(appBarTitle: 'Dashboard'),
        drawer: const MyCustomDrawerComponent(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              // find best salon
              const Center(
                  child: Text(
                    "Find the best salon",
                    style: TextStyle(
                        color: Colors.black45,
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  )),
              // services
              const Center(
                  child: Text(
                    "Services!",
                    style: TextStyle(
                        color: Colors.black45,
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  )),
              // search bar
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  contentPadding: const EdgeInsets.only(left: 20),
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontFamily: 'Poppins',
                    color: const Color.fromARGB(247, 84, 74, 158),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search,
                        color: Color.fromARGB(247, 84, 74, 158)),
                    onPressed: () {
                      performSearch(searchController.text);
                    },
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
              // Salon Cards (conditionally rendered based on data availability)
              if (isLoading)
                const CircularProgressIndicator(
                  backgroundColor: Color.fromARGB(247, 84, 74, 158),
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: salonList.map((salonData) {
                      return GestureDetector(
                        onTap:(){
                          salonIdPass= salonData['userID'];
                          navigateToSalon(salonIdPass!);
                        },
                        child: MyCustomCardComponent(
                          salonCoverImagePath: salonData['coverPicture'] ?? '', // Provide a default value
                          salonLogoPath: salonData['logoPicture'] ?? '', // Provide a default value
                          salonName: salonData['name'] ?? '', // Provide a default value
                          stars: '4.5',
                          owner: salonData['owner'] ?? '', // Use the owner's name from salonData
                          // salonId: salonIdGet.toString(),
                        ),
                      );
                    }).toList(),
                  ),
                ),

              const Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text(
                        "Near you",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text(
                        "View more",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // near you portion
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MyCustomListTileComponent(
                        listTileLogoPath: 'images/logo1.jpeg',
                        listTileSalonName: 'FashionZone'),
                  ],
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: const MyCustomBottomNavigationBar(),
      ),
    );
  }
  Future<void> fetchSalonData() async {
    try {
      // Fetch data for all salons
      QuerySnapshot salonQuerySnapshot = // when we have to fetch multiple documents we use QuerySnapshot
      await FirebaseFirestore.instance.collection('salons').get();

      // Check if there is at least one salon
      if (salonQuerySnapshot.docs.isNotEmpty) {
        // Fetch salon data and owner names concurrently
        List<Map<String, dynamic>> salonDataList = await Future.wait(
          salonQuerySnapshot.docs.map((salonDocument) async {
            final salonData = salonDocument.data() as Map<String, dynamic>;

            // Fetch the owner's name based on the salon's userID
            final String? ownerUserId = salonData['userID'];

            if (ownerUserId != null) {
              final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(ownerUserId)
                  .get();

              if (userSnapshot.exists) {
                final userData = userSnapshot.data() as Map<String, dynamic>;
                final String ownerName = userData['name'] ?? '';
                salonData['owner'] = ownerName;

                salonIdGet = salonDocument.id;

                salonIds.add(salonIdGet!);

              }
            }
            return salonData;
          }),
        );

        setState(() {
          salonList = salonDataList; // Assign the fetched data to salonList
          isLoading = false; // Data has been fetched, set isLoading to false
        });

        // Now, you have the salon IDs in the salonIds list
        // You can use salonIds for further processing
        // print('Salon IDS store in list : $salonIds');
      }
    } catch (e) {
      print('Error fetching salon data: $e');
      // Handle the error as needed
    }
  }


  void navigateToSalon(String  salonIdPass) {


    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Salon(salonId: salonIdPass.toString())),
    );
  }

  void performSearch(String query) {

    List<Map<String, dynamic>> searchResults = salonList.where((salon) {
      final name = salon['name'] as String;
      return name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      salonList = searchResults;
    });
  }

}