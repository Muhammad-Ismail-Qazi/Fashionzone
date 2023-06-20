import 'package:fashionzone/Components/AppBarComponent.dart';
import 'package:fashionzone/Components/BottomNavigationBarComponent.dart';
import 'package:fashionzone/Components/DrawerComponent.dart';
import 'package:flutter/material.dart';

import '../Components/AdminListtileUploadServices.dart';
import 'AdminDashboard.dart';
class UploadServices extends StatefulWidget {
  const UploadServices({Key? key}) : super(key: key);

  @override
  State<UploadServices> createState() => _UploadServicesState();
}

class _UploadServicesState extends State<UploadServices> {
  bool isHover= false;
  TextEditingController _textFieldController = TextEditingController();

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(247, 84, 74, 158),
        backgroundColor:const Color.fromARGB(247, 84, 74, 158) ,
        iconTheme: const IconThemeData(color: Color.fromARGB(247, 84, 74, 158)),
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: const MyCustomAppBarComponent(),
        drawer: const MyCustomDrawerComponent(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  "Services",
                  style: TextStyle( fontSize: 20, color: Colors.black45),
                ),
              ),
              MyCustomListTileComponent(servicesName: "HairCutting",),
              MyCustomListTileComponent(servicesName: "HairColor",),
              MyCustomListTileComponent(servicesName: "HeadMassage",),
              MyCustomListTileComponent(servicesName: "BodyMassage",),
              MyCustomListTileComponent(servicesName: "MakeUp",),
              MyCustomListTileComponent(servicesName: "NailPolish",),
              MyCustomListTileComponent(servicesName: "Beard",),
              const SizedBox(
                height: 30,
              ),


              SizedBox(
                height: 60,
                width: 390,
                child: MouseRegion(
                  onHover: (event) {
                    setState(() {
                      isHover = true;
                    });
                  },
                  onExit: (event) {
                    setState(() {
                      isHover = false;
                    });
                  },
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: isHover
                          ? const Color.fromARGB(247, 255, 255, 255) // White background when hovering
                          : const Color.fromARGB(247, 84, 74, 158), // Purple background when not hovering
                    ),
                    onPressed: () {
                      // Add your button onPressed logic here
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.upload_outlined, // Replace with the desired icon
                          color: isHover ? Colors.black45 : Colors.white,
                        ),
                        const SizedBox(width: 8), // Add some spacing between the icon and text
                        Text(
                          "Upload Services",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            color: isHover ? Colors.black45 : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
        bottomNavigationBar: const MyCustomBottomNavigationBar(),
        floatingActionButton: MouseRegion(
          onEnter: (_) {
            setState(() {
              isHover = true;
            });
          },
          onExit: (_) {
            setState(() {
              isHover = false;
            });
          },
          child: FloatingActionButton(
            backgroundColor: isHover ? Colors.white : const Color.fromARGB(247, 84, 74, 158),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboard(),));
            },
            child: const Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }
}
