import 'package:fashionzone/Components/AppBarComponent.dart';
import 'package:fashionzone/Components/BottomNavigationBarComponent.dart';
import 'package:fashionzone/Components/DrawerComponent.dart';
import 'package:flutter/material.dart';

class CheckAppointmentDetails extends StatefulWidget {
  final String? customerName;
  final String? appointmentSlot;
  final List<String> serviceId;
  final String? contactInformation;
  final String? status;
  final String? imageURL;

  const CheckAppointmentDetails({
    Key? key,
    this.customerName,
    this.appointmentSlot,
    required this.serviceId,
    this.contactInformation,
    this.status,
    this.imageURL,
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
                      const Icon(Icons.assignment, color: Colors.black),
                      SizedBox(width: 8.0),
                      const Text(
                        'Service:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        ' ${widget.serviceId.join(', ')}',
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
                        },
                        icon: const Icon(Icons.check),
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
                        icon: const Icon(Icons.cancel),
                        color: Colors.red,
                        iconSize: 50.0,
                      ),
                      const SizedBox(width: 20.0),
                      IconButton(
                        onPressed: () {
                          // Perform action - Mark as Completed
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
}
