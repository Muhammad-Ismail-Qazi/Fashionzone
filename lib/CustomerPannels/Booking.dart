import 'package:fashionzone/Components/BottomNavigationBarComponent.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Components/AppBarComponent.dart';
import '../Components/DrawerComponent.dart';
import 'Thanks.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final timeController = TextEditingController();
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(247, 84, 74, 158),
        iconTheme: const IconThemeData(color: Color.fromARGB(247, 84, 74, 158)),
        fontFamily: 'Poppins',
      ),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(224, 248, 249, 252),
        appBar: const MyCustomAppBarComponent(),
        drawer: const MyCustomDrawerComponent(),
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // image
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.1,
                    ),
                    child: SizedBox(
                      child: Image(
                        image: const AssetImage('images/logo.png'),
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.25,
                      ),
                    ),
                  ),
                  //space
                  const SizedBox(
                    height: 20,
                  ),
                  // full name
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.86,
                    child: Material(
                      elevation: 5,
                      shadowColor: Colors.black,
                      child: TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Full Name',
                              labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Color.fromARGB(247, 84, 74, 158),
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color.fromARGB(247, 84, 74, 158),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(247, 84, 74, 158),
                                    width: 1),
                              ),
                              border: OutlineInputBorder()),
                          style: const TextStyle(
                              fontFamily: 'Poppins', fontSize: 20),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your full name.';
                            } else if (!RegExp(r'^[A-Za-z\s]+$')
                                .hasMatch(value)) {
                              return 'Invalid name format. Please enter a valid name.';
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ),
                  //space
                  const SizedBox(
                    height: 20,
                  ),
                  //phone
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.86,
                    child: Material(
                      elevation: 4,
                      shadowColor: Colors.black,
                      child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Phone',
                              labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Color.fromARGB(247, 84, 74, 158),
                              ),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Color.fromARGB(247, 84, 74, 158),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(247, 84, 74, 158),
                                    width: 1),
                              ),
                              border: OutlineInputBorder()),
                          style: const TextStyle(
                              fontFamily: 'Poppins', fontSize: 20),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number.';
                            } else if (!RegExp(r'^\+92\d{10}$')
                                .hasMatch(value)) {
                              return 'Invalid format. Please enter a valid  format +92xxxxxxxxxx.';
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ),
                  //space
                  const SizedBox(
                    height: 20,
                  ),
                  //address
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.86,
                    child: Material(
                      elevation: 4,
                      shadowColor: Colors.black,
                      child: TextFormField(
                          keyboardType: TextInputType.streetAddress,
                          decoration: const InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Address',
                              labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Color.fromARGB(247, 84, 74, 158),
                              ),
                              prefixIcon: Icon(
                                Icons.location_city,
                                color: Color.fromARGB(247, 84, 74, 158),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(247, 84, 74, 158),
                                    width: 1),
                              ),
                              border: OutlineInputBorder()),
                          style: const TextStyle(
                              fontFamily: 'Poppins', fontSize: 20),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your street address.';
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ),
                  //space
                  const SizedBox(
                    height: 20,
                  ),
                  //time and date
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.86,
                    child: Material(
                      elevation: 5,
                      shadowColor: Colors.black,
                      child: TextFormField(
                        controller: timeController,
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Time',
                          labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Color.fromARGB(247, 84, 74, 158),
                          ),
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Color.fromARGB(247, 84, 74, 158),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(247, 84, 74, 158),
                                width: 1),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        onTap: () async {
                          final ThemeData theme = Theme.of(context);
                          final DateTime? pickedDateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 7)),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: theme.copyWith(
                                  colorScheme: theme.colorScheme.copyWith(
                                    primary:
                                        const Color.fromARGB(247, 84, 74, 158),
                                    // Set the color of the picker menu
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (pickedDateTime != null) {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: theme.copyWith(
                                    colorScheme: theme.colorScheme.copyWith(
                                      primary: const Color.fromARGB(247, 84, 74,
                                          158), // Set the color of the picker menu
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (pickedTime != null) {
                              final DateTime combinedDateTime = DateTime(
                                pickedDateTime.year,
                                pickedDateTime.month,
                                pickedDateTime.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );

                              final DateFormat formatter =
                                  DateFormat('dd/MM/yyyy hh:mm a');
                              final String formattedDateTime =
                                  formatter.format(combinedDateTime);

                              setState(() {
                                timeController.text = formattedDateTime;
                              });
                            }
                          }
                        },
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Colors.black), // Set the text color
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Select the date and time.';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  //space
                  const SizedBox(
                    height: 20,
                  ),
                  //SPACE
                  const SizedBox(
                    height: 20,
                  ),
                  //button booked
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
                              ? const Color.fromARGB(247, 255, 255,
                                  255) // White background when hovering
                              : const Color.fromARGB(247, 84, 74,
                                  158), // Purple background when not hovering
                        ),
                        onPressed: () {
                          // Fluttertoast.showToast(
                          //   msg: "Successfully Account create !",
                          //   toastLength: Toast.LENGTH_SHORT,
                          //   gravity: ToastGravity.BOTTOM,
                          //   backgroundColor:const Color.fromARGB(247, 84, 74, 158) ,
                          //   textColor: Colors.white,
                          // );
                          if (formKey.currentState!.validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ThankYou()));
                          }
                        },
                        child: Text(
                          "Reserve your seat",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: isHover
                                ? Colors.black45
                                : Colors
                                    .white, // black45 text when not hovering, white text when hovering
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Total price
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Total price: 600",
                        style: TextStyle(fontSize: 30)),
                  ),
                ],
              ),
            ),
          ),
        ),
        // bottomNavigationBar: const MyCustomBottomNavigationBar(),
      ),
    );
  }
}
