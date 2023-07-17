import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../Components/AppBarComponent.dart';
import '../Components/BottomNavigationBarComponent.dart';
import '../Components/DrawerComponent.dart';
import '../Components/NearYouComponent.dart';
import '../Components/TopSalonComponent.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({Key? key}) : super(key: key);

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
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
        appBar: const MyCustomAppBarComponent(),
        drawer: const MyCustomDrawerComponent(),
        body: SingleChildScrollView(
          child: Column(
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
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              )),
              // services
              const Center(
                  child: Text(
                "Services!",
                style: TextStyle(
                    color: Colors.black45,
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              )),
              // search bar
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Material(
                  elevation: 5,
                  shape: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextField(
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
                      suffixIcon: GestureDetector(
                        onTap: () {
                          // Handle button press here
                          // Add your desired functionality when the icon button is pressed
                        },
                        child: IconButton(
                          icon: const Icon(Icons.search,
                              color: Color.fromARGB(247, 84, 74, 158)),
                          onPressed: () {
                            // Handle button press here
                            // Add your desired functionality when the icon button is pressed
                          },
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // salon that are famous
                    MyCustomCard_Component(
                      salonImagePath: 'images/topsalon1.jpeg',
                      salonLogoPath: 'images/logo.png',
                      salonName: 'BeautyXone',
                      stars: '4.5',
                    ),
                    MyCustomCard_Component(
                        salonImagePath: 'images/topsalon2.jpeg',
                        salonName: 'Style',
                        salonLogoPath: 'images/logo1.jpeg',
                        stars: '4.3'),
                    MyCustomCard_Component(
                      salonImagePath: 'images/topsalon1.jpeg',
                      salonLogoPath: 'images/logo.png',
                      salonName: 'BeautyXone',
                      stars: '4.5',
                    ),
                    MyCustomCard_Component(
                        salonImagePath: 'images/topsalon2.jpeg',
                        salonName: 'Style',
                        salonLogoPath: 'images/logo1.jpeg',
                        stars: '4.3'),
                    MyCustomCard_Component(
                        salonImagePath: 'images/topsalon3.jpeg',
                        salonName: 'Beauty Balon',
                        stars: '4.0',
                        salonLogoPath: 'images/logo2.jpeg'),
                    MyCustomCard_Component(
                        salonImagePath: 'images/topsalon3.jpeg',
                        salonName: 'Beauty Balon',
                        stars: '4.0',
                        salonLogoPath: 'images/logo2.jpeg'),
                  ],
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
                          fontSize: 20,
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
                          fontSize: 20,
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
                    MyCustomListTileComponent(
                        listTileSalonName: 'BeautyTime',
                        listTileLogoPath: 'images/logo2.jpeg'),
                    MyCustomListTileComponent(
                        listTileLogoPath: 'images/logo.png',
                        listTileSalonName: 'StyleXone'),
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
}
