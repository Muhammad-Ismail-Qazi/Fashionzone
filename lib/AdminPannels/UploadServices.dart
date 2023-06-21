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
        body: Padding(
          padding: const EdgeInsets.only(bottom:14.0),
          child: SingleChildScrollView(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 14.0 ,left: 14.0,right:14.0 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: Material(
                            elevation: 5,
                            shadowColor: Colors.black,
                            child: TextFormField(
                              // controller: nameController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Services',
                                labelStyle: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  color: Color.fromARGB(247, 84, 74, 158),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(247, 84, 74, 158), width: 1),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              style: const TextStyle(fontFamily: 'Roboto', fontSize: 15),
                              validator: (value) {
                                if (value!.isEmpty && value.length < 3) {
                                  return 'Please enter your full name.';
                                } else if (!RegExp(r'^[A-Za-z\s]+$').hasMatch(value)) {
                                  return 'Invalid name format. Please enter a valid name.';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10), // Add space between the text fields
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: Material(
                            elevation: 5,
                            shadowColor: Colors.black,
                            child: TextFormField(
                              // controller: nameController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Price',
                                labelStyle: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  color: Color.fromARGB(247, 84, 74, 158),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(247, 84, 74, 158), width: 1),
                                ),
                                border: OutlineInputBorder(),
                              ),
                              style: const TextStyle(fontFamily: 'Roboto', fontSize: 15),
                              validator: (value) {
                                if (value!.isEmpty && value.length < 3) {
                                  return 'Please enter the price.';
                                } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                  return 'Invalid price format. Please enter a valid number.';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.86,
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

                              },
                              child: Text(
                                "Add",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  color: isHover ? Colors.black45 : Colors.white, // black45 text when not hovering, white text when hovering
                                ),
                              ),
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(14.0),
                ),
                MyCustomListTileComponent(servicesName: "HairCutting",price: 200),
                MyCustomListTileComponent(servicesName: "HairColor",price: 500),
                MyCustomListTileComponent(servicesName: "HeadMassage",price: 100),
                MyCustomListTileComponent(servicesName: "BodyMassage",price: 150),
                MyCustomListTileComponent(servicesName: "MakeUp",price: 200),
                MyCustomListTileComponent(servicesName: "NailPolish",price: 300),
                MyCustomListTileComponent(servicesName: "Beard",price: 200),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.86,
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
        ),
        bottomNavigationBar: const MyCustomBottomNavigationBar(),
        // floatingActionButton: MouseRegion(
        //   onEnter: (_) {
        //     setState(() {
        //       isHover = true;
        //     });
        //   },
        //   onExit: (_) {
        //     setState(() {
        //       isHover = false;
        //     });
        //   },
        //   child: FloatingActionButton(
        //     backgroundColor: isHover ? Colors.white : const Color.fromARGB(247, 84, 74, 158),
        //     onPressed: () {
        //       Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboard(),));
        //     },
        //     child: const Icon(Icons.arrow_forward),
        //   ),
        // ),
      ),
    );
  }
}
