import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionzone/CustomerPannels/CustomerDashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../Components/AppBarComponent.dart';
import '../Components/DrawerComponent.dart';
import 'Thanks.dart';
import 'package:http/http.dart'as http;

class Booking extends StatefulWidget {
  final List<Service> selectedServices;
  final String salonId;
  const Booking(
      {Key? key, required this.selectedServices, required this.salonId})
      : super(key: key);

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
  double totalPrice = 0.0;
  NotificationServices notificationServices = NotificationServices();
  String deviceIdCurrentUser = '';
  String deviceIdSalon = '';

  @override
  void initState() {
    super.initState();
    fetchAndSetUserData();
    getDeviceIdForCurrentUser();
    getDeviceIdForSalon(widget.salonId);
    totalPrice = calculateTotalPrice(widget.selectedServices);
    notificationServices.requestNotificationPermission(); // get permission
    notificationServices.messageInitiating(context); // message process
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
                          } else if (!RegExp(r'^[A-Za-z\s]+$')
                              .hasMatch(value)) {
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
                                      primary: const Color.fromARGB(
                                          247, 84, 74, 158),
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
                        backgroundColor: const Color.fromARGB(247, 84, 74, 158),
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
                        style: const TextStyle(
                            fontSize: 30, fontFamily: 'Poppins')),
                  ),
                  SizedBox(
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
                                backgroundImage:
                                    NetworkImage(service.imageFile),
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
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black54),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (widget.selectedServices
                                          .contains(service)) {
                                        setState(() {
                                          totalPrice -=
                                              double.parse(service.price);
                                          widget.selectedServices
                                              .remove(service);
                                        });
                                      } else if (widget
                                          .selectedServices.isEmpty) {
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
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
    }
  }

  void _reserveSeat() async {
    if (widget.selectedServices.isEmpty) {
      // check if there is no services selected
      Fluttertoast.showToast(
          msg: 'No service selected :-)', backgroundColor: Colors.red);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CustomerDashboard()),
      );
    } else {
      //if there is services in the list
      if (formKey.currentState!.validate()) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Create a reference to the Firestore collection for bookings
          CollectionReference bookings =
              FirebaseFirestore.instance.collection('bookings');
          // Get the selected date and time from the controller
          String selectedDateTime = timeController.text;
          // Retrieve the service IDs for selected services
          List<String> serviceIds = await getServiceIds(widget
              .selectedServices); // fetch the services with help of service id

          // Create a new booking collection with an automatically generated ID
          await bookings.add({
            'date_time': selectedDateTime,
            'user_id': user.uid,
            'totalPrice': totalPrice,
            'service_ids': serviceIds,
            'status': 'Pending',
            'salonID': widget.salonId,
          });

          ///from here
          getDeviceIdForCurrentUser();
          if (kDebugMode) {
            print("current login user device id : $deviceIdCurrentUser");
          }
          if (kDebugMode) {
            print("salon  user device id : $deviceIdSalon");
          }
          getDeviceIdForSalon(widget.salonId);

          // Get the device IDs for the current user and the salon
          String currentUserDeviceId = await getDeviceIdForCurrentUser();
          String salonDeviceId = await getDeviceIdForSalon(widget.salonId);
          // Send notification to the salon
          // await sendNotificationToSalon(salonDeviceId);

          // Navigate to the thank you screen or perform any other actions
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ThankYou()),
          );
        }
      }
    }
  }

  //get the device ids
  Future<String> getDeviceIdForCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user?.uid ?? '';

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('userDevices')
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        deviceIdCurrentUser = querySnapshot.docs[0]['deviceId'] as String;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting device ID: $e');
      }
    }

    return deviceIdCurrentUser;
  }

  Future<String> getDeviceIdForSalon(String salonId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('userDevices')
          .where('userId',
              isEqualTo: salonId) // Assuming the field is named 'userId'
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        deviceIdSalon = querySnapshot.docs[0]['deviceId'] as String;
      }
    } catch (e) {
      print('Error getting device ID: $e');
    }

    return deviceIdSalon;
  }

  Future<List<String>> getServiceIds(List<Service> services) async {
    List<String> serviceIds = [];
    for (final service in services) {
      // Assuming there's a 'services' collection in Fire store with documents having 'name' field
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('services')
          .where('userID', isEqualTo: service.userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document's ID as the service ID (assuming service names are unique)
        String serviceId = querySnapshot.docs.first.id;
        serviceIds.add(serviceId);
      }
    }
    return serviceIds;
  }
  Future<void> sendNotificationToSalon(String salonDeviceId) async {
    var data ={
      'to' : salonDeviceId,
      'priority':'high',
      'notification': {
        'title': 'Reservation request',
        'body' : 'Your request is an process',
        'data':{
          'type':'fashionzone',
          'id':'true',
        }
      }
    };
     await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
    body :jsonDecode(data.toString()),
    headers: {
      'content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'AAAACRKoSdw:APA91bElA1l95AYLE08PUB-v9sx8--BfWAFIO-fzCalPmxkZ24peIxbscgsdri7cUc1jgMwgDz1p-ln4Zh3nGOHSm0rGgN0S5cyd5M6IhiMdksalP_WYYV0MYCRYKlf8S0F0SuoXgNMP',

    }
    );
  }
}

// service helper class to get the service
class Service {
  final String name;
  final String price;
  final String imageFile;
  final String userId;
  final String salonId;

  Service({
    required this.name,
    required this.price,
    required this.imageFile,
    required this.userId,
    required this.salonId,
  });
}

//Notification service helper class
class NotificationServices {
  FirebaseMessaging message = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); // this is call when our app is active

  void requestNotificationPermission() async {
    NotificationSettings setting = await message.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
    if (setting.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print("user granted the permission ");
      }
    } else if (setting.authorizationStatus == AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print("User provide the provisional permission");
      }
    } else {
      if (kDebugMode) {
        print("user denied the permission");
      }
    }
  }

  void messageInitiating(BuildContext context) {
    FirebaseMessaging.onMessage.listen((event) {
      if (kDebugMode) {
        print("Message is initializing below are the details");
        print(event.notification?.title.toString());
        print(event.notification?.body.toString());
      }

      showNotification(event); // actually the event is message
      initLocalNotification(context, event);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationDetails channel = AndroidNotificationDetails(
        Random.secure().nextInt(1000).toString(), // channel id
        'FASHIONZONE' // channel name
        );
    AndroidNotificationDetails androidNotificationChannel =
        AndroidNotificationDetails(
      // here we pass that details to easily visualize
      channel.channelId.toString(),
      channel.channelName.toString(),
      channelDescription: 'Reserve your seat ',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'Ticker',
    );
    NotificationDetails notificationPlatformDetails = NotificationDetails(
      android: androidNotificationChannel,
    );
    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title.toString(),
          message.notification?.body.toString(),
          notificationPlatformDetails);
    });
  }

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings = const AndroidInitializationSettings(
        '@mipmap/ic_launcher'); // to add your custom icon use drawable kb size
    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings, // now the icon is set for android
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      handelMessage(context, message);
    });
  }

  void handelMessage(BuildContext context, RemoteMessage message) {
    if (message.data['fashionzone'] == "true") {
      // Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckAppointment(salonId),));
    }
  }
}
