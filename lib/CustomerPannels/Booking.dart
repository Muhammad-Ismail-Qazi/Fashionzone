import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionzone/Components/BottomNavigationBarComponent.dart';
import 'package:fashionzone/Components/NearYouComponent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAndSetUserData();
  }

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
        appBar: const MyCustomAppBarComponent(appBarTitle: 'Booking'),
        drawer: const MyCustomDrawerComponent(),
        body: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                              fontFamily: 'Poppins', fontSize: 16),
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
                  //email
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width *
                        0.86,
                    child: Material(
                      elevation: 5,
                      shadowColor: Colors.black,
                      child: TextFormField(
                          controller: emailController,
                          keyboardType:
                          TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: Color.fromARGB(
                                      247, 84, 74, 158)),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color.fromARGB(
                                    247, 84, 74, 158),
                              ),
                              enabledBorder:
                              OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white),
                              ),
                              focusedBorder:
                              OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(
                                        247, 84, 74, 158),
                                    width: 1),
                              ),
                              border: OutlineInputBorder()),
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email address.';
                            } else if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                .hasMatch(value)) {
                              return 'Invalid email address format. Please enter a valid email address.';
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ),
                  // space
                  const SizedBox(height: 20),
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
                              fontFamily: 'Poppins', fontSize: 16),
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
                        controller: addressController,
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
                              fontFamily: 'Poppins', fontSize: 16),
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
                    child:ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: const Color.fromARGB(247, 84, 74, 158),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          // Get the current user
                          User? user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            // Create a reference to the Firestore collection for bookings
                            CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');

                            // Generate a unique booking id (you can use a package like 'uuid' for this)
                            String bookingId = UniqueKey().toString();

                            // Get the selected date and time from the controller
                            String selectedDateTime = timeController.text;

                            // Create a new booking document
                            await bookings.doc(bookingId).set({
                              'booking_id': bookingId,
                              'date_time': selectedDateTime,
                              'user_id': user.uid,
                              'service_id': 'your_service_id_here', // Replace with your actual service id
                            });

                            // Navigate to the thank you screen or perform any other actions
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ThankYou()),
                            );
                          }
                        }
                      },
                      child: const Text(
                        "Reserve your seat",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ),

                  ),
                  // Total price
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Total price: 600",
                        style: TextStyle(fontSize: 30,fontFamily: 'Poppins')),
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

  void fetchAndSetUserData() async {
    try {
      // Get the current user first
      User? user = FirebaseAuth.instance.currentUser;
      // Now check if the user is available or not
      if (user != null) {
        // Fetch the user data from Firestore using the user's UID
        DocumentSnapshot<Map<String, dynamic>> userDataSnapshot =
        await FirebaseFirestore.instance
            .collection('users') // 'users' is your collection name
            .doc(user.uid)
            .get();

        if (userDataSnapshot.exists) {
          // Extract the user data from the snapshot
          Map<String, dynamic> userData = userDataSnapshot.data()!;

          // Set the fetched data in the text fields
          setState(() {
            nameController.text = userData['name'] ?? '';
            emailController.text = userData['email'] ?? '';
            phoneController.text = userData['phone'] ?? '';
            addressController.text = userData['address'] ?? '';
          });
        }
      }
    } catch (e) {
      // Handle any errors that occur during fetching the data
      print('Error fetching user data: $e');
    }
  }
}
