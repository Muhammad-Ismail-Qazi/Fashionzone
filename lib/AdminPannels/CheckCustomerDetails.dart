import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionzone/Components/AppBarComponent.dart';
import 'package:fashionzone/Components/DrawerComponent.dart';
import 'package:flutter/material.dart';

class CheckAppointmentDetails extends StatefulWidget {
  final String? customerName;
  final String? appointmentSlot;

  final String? contactInformation;
   String? status;
  final String? imageURL;
  final String? documentId;

   CheckAppointmentDetails({
    Key? key,
    this.customerName,
    this.appointmentSlot,
    this.contactInformation,
     this.status,
    this.imageURL,
    this.documentId,
  }) : super(key: key);

  @override
  State<CheckAppointmentDetails> createState() => _CheckAppointmentDetailsState();
}

class _CheckAppointmentDetailsState extends State<CheckAppointmentDetails> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(247, 84, 74, 158),
        backgroundColor: const Color.fromARGB(247, 84, 74, 158),
        iconTheme: const IconThemeData(color: Color.fromARGB(247, 84, 74, 158)),
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const MyCustomAppBarComponent(appBarTitle: 'Check Customer Details'),
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
                  CircleAvatar(
                    radius: 80.0,
                    backgroundImage: widget.imageURL != null
                        ? NetworkImage(widget.imageURL!)
                        : const AssetImage('assets/default_avatar.png') as ImageProvider<Object>,
                  ),

                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.black),
                      const SizedBox(width: 8.0),
                      const Text(
                        'Customer Name:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        widget.customerName.toString(),
                        style: const TextStyle(fontSize: 16.0, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                   Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.black),
                      const SizedBox(width: 8.0),
                      const Text(
                        'Appointment Slot:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                       widget.appointmentSlot.toString(),
                        style: const TextStyle(fontSize: 16.0, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                   Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.black),
                      const SizedBox(width: 8.0),
                      const Text(
                        'Contact Information:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        widget.contactInformation ?? 'N/A',
                        style: const TextStyle(fontSize: 16.0, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                   Row(
                    children: [
                      const Icon(Icons.info, color: Colors.black),
                      const SizedBox(width: 8.0),
                      const Text(
                        'Appointment Status:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        widget.status.toString() ,
                        style: const TextStyle(fontSize: 16.0, fontFamily: 'Poppins'),
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
                          updateAppointmentStatus('Confirmed');
                        },
                        icon: const Icon(Icons.check),
                        color: Colors.blue,
                        iconSize: 50.0,
                      ),
                      const SizedBox(width: 20.0),
                      IconButton(
                        onPressed: () {
                          // Perform action - Cancel Appointment
                          updateAppointmentStatus('Canceled');
                        },
                        icon: const Icon(Icons.cancel),
                        color: Colors.red,
                        iconSize: 50.0,
                      ),
                      const SizedBox(width: 20.0),
                      IconButton(
                        onPressed: () {
                          // Perform action - Mark as Completed
                          updateAppointmentStatus('Completed');
                        },
                        icon: const Icon(Icons.done_all),
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
        // bottomNavigationBar: const MyCustomBottomNavigationBar(),
      ),
    );
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateAppointmentStatus(String status) async {
    try {
      await _firestore
          .collection('bookings') // Replace with your collection name
          .doc(widget.documentId)
          .update({'status': status});

      // Update the local widget state after the status change
      setState(() {
        widget.status = status;
      });
    } catch (e) {
      print('Error updating status: $e');
    }
  }
}