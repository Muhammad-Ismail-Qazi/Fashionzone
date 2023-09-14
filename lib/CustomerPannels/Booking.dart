import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionzone/Components/BottomNavigationBarComponent.dart';
import 'package:fashionzone/Components/NearYouComponent.dart';
import 'package:fashionzone/CustomerPannels/CustomerDashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../Components/AppBarComponent.dart';
import '../Components/DrawerComponent.dart';
import 'Thanks.dart';

class Booking extends StatefulWidget {
  final List<Service> selectedServices;

  const Booking({Key? key, required this.selectedServices}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

// service helper class
class Service {
  final String name;
  final String price;
  final String imageFile;
  final String userId;

  Service(
      {required this.name,
        required this.price,
        required this.imageFile,
        required this.userId});
}

class _BookingState extends State<Booking> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final timeController = TextEditingController();
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    fetchAndSetUserData();
    totalPrice = calculateTotalPrice(widget.selectedServices);
  }

  double calculateTotalPrice(List<Service> services) {
    double total = 0.0;
    for (final service in services) {
      total += double.parse(service.price);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
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
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(
                            fontFamily: 'Poppins', fontSize: 16),
                        validator: (value) {
                          if (value!.isEmpty) {
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
                  //space
                  const SizedBox(
                    height: 20,
                  ),
                  //email
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.86,
                    child: Material(
                      elevation: 5,
                      shadowColor: Colors.black,
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: Color.fromARGB(247, 84, 74, 158)),
                          prefixIcon: Icon(
                            Icons.email,
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
                        style: const TextStyle(
                            fontFamily: 'Poppins', fontSize: 16),
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
                        },
                      ),
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
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(
                            fontFamily: 'Poppins', fontSize: 16),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number.';
                          } else if (!RegExp(r'^\+92\d{10}$').hasMatch(value)) {
                            return 'Invalid format. Please enter a valid  format +92xxxxxxxxxx.';
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
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(
                            fontFamily: 'Poppins', fontSize: 16),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your street address.';
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
                                          158),
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
                            color: Colors.black),
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor:
                        const Color.fromARGB(247, 84, 74, 158),
                      ),
                      onPressed: _reserveSeat,
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Total price: $totalPrice",
                        style: const TextStyle(fontSize: 30, fontFamily: 'Poppins')),
                  ),
                  Container(
                    height: 165,
                    child: Scrollbar(
                      thickness: 5,
                      interactive: true,
                      radius: const Radius.circular(5),
                      thumbVisibility: true,
                      trackVisibility: true,
                      child: ListView.builder(
                        itemCount: widget.selectedServices.length,
                        itemBuilder: (context, index) {
                          final service = widget.selectedServices[index];
                          return Material(
                            elevation: 5,
                            child: ListTile(
                              minVerticalPadding: 20,
                              contentPadding: const EdgeInsets.all(0),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(service.imageFile),
                                radius: 40,
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(left: 14.0),
                                child: Text(
                                  service.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 14.0),
                                child: Text(
                                  service.price,
                                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (widget.selectedServices.contains(service)) {
                                        setState(() {
                                          totalPrice -= double.parse(service.price);
                                          widget.selectedServices.remove(service);
                                        });
                                      } else if (widget.selectedServices.isEmpty) {
                                        setState(() {
                                          totalPrice = 0.0;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void fetchAndSetUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userDataSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDataSnapshot.exists) {
          Map<String, dynamic> userData = userDataSnapshot.data()!;
          setState(() {
            nameController.text = userData['name'] ?? '';
            emailController.text = userData['email'] ?? '';
            phoneController.text = userData['phone'] ?? '';
            addressController.text = userData['address'] ?? '';
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void _reserveSeat() async {
    if (widget.selectedServices.isEmpty) {
      Fluttertoast.showToast(msg: 'No service selected :-)');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CustomerDashboard()),
      );
    } else {
      if (formKey.currentState!.validate()) {
        // Get the current user
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // Create a reference to the Firestore collection for bookings
          CollectionReference bookings =
          FirebaseFirestore.instance.collection('bookings');

          // Get the selected date and time from the controller
          String selectedDateTime = timeController.text;

          // Retrieve the service IDs for selected services
          List<String> serviceIds = await getServiceIds(widget.selectedServices);

          // Create a new booking document with an automatically generated ID
          await bookings.add({
            'date_time': selectedDateTime,
            'user_id': user.uid,
            'totalPrice': totalPrice,
            'service_ids': serviceIds, // Use service IDs instead of toString()
          });

          // Navigate to the thank you screen or perform any other actions
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ThankYou()),
          );
        }
      }
    }
  }

  Future<List<String>> getServiceIds(List<Service> services) async {
    List<String> serviceIds = [];
    for (final service in services) {
      // Assuming there's a 'services' collection in Firestore with documents having 'name' field
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('services')
          .where('name', isEqualTo: service.name)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document's ID as the service ID (assuming service names are unique)
        String serviceId = querySnapshot.docs.first.id;
        serviceIds.add(serviceId);
      }
    }
    return serviceIds;
  }

}
