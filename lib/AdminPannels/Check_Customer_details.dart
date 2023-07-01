
import 'package:fashionzone/Components/AppBarComponent.dart';
import 'package:fashionzone/Components/BottomNavigationBarComponent.dart';
import 'package:fashionzone/Components/DrawerComponent.dart';
import 'package:flutter/material.dart';

class CheckAppointmentDetails extends StatefulWidget {
  const CheckAppointmentDetails({Key? key}) : super(key: key);

  @override
  State<CheckAppointmentDetails> createState() => _CheckAppointmentDetailsState();
}

class _CheckAppointmentDetailsState extends State<CheckAppointmentDetails> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(247, 84, 74, 158),
        backgroundColor:const Color.fromARGB(247, 84, 74, 158) ,
        iconTheme: const IconThemeData(color: Color.fromARGB(247, 84, 74, 158)),
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const MyCustomAppBarComponent(),
        drawer: const MyCustomDrawerComponent(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 80.0,
                    backgroundImage: AssetImage('images/ismail.jpg'),
                  ),
                  const SizedBox(height: 16.0),
                  const Row(
                    children:  [
                      Icon(Icons.person, color: Colors.black),
                      SizedBox(width: 8.0),
                      Text(
                        'Customer Name:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Muhammad Ismail',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.black),
                      SizedBox(width: 8.0),
                      Text(
                        'Appointment Slot:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '2/3/2023 1:00 am',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const  Row(
                    children: [
                      Icon(Icons.assignment, color: Colors.black),
                      SizedBox(width: 8.0),
                      Text(
                        'Service:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Hair, Color, Massage',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const Row(
                    children: [
                      Icon(Icons.phone, color: Colors.black),
                      SizedBox(width: 8.0),
                      Text(
                        'Contact Information:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '+923414142798',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  const Row(
                    children: [
                      Icon(Icons.info, color: Colors.black),
                      SizedBox(width: 8.0),
                      Text(
                        'Appointment Status:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'pending',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  // here is the button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Perform action - Confirm Appointment
                        },
                        icon: Icon(Icons.check),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                        ),
                        color: Colors.blue,
                        iconSize: 50.0,
                      ),

                      const SizedBox(width: 20.0),
                      IconButton(
                        onPressed: () {
                          // Perform action - Cancel Appointment
                        },
                        icon: Icon(Icons.cancel),
                        color: Colors.red,
                        iconSize: 50.0,
                      ),
                      const SizedBox(width: 20.0),
                      IconButton(
                        onPressed: () {
                          // Perform action - Mark as Completed
                        },
                        icon: Icon(Icons.done_all),
                        color: Colors.green,
                        iconSize: 50.0,
                      ),
                    ],
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
