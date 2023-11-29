import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'CheckCustomerDetails.dart';

class CheckAppointment extends StatefulWidget {
  const CheckAppointment({Key? key}) : super(key: key);

  @override
  State<CheckAppointment> createState() => _CheckAppointmentState();
}

class _CheckAppointmentState extends State<CheckAppointment> {
  List<Map<String, dynamic>> pendingBookings = [];
  List<Map<String, dynamic>> completeBookings = [];
  List<String> serviceIds =[];
  String salonId = "";
  String? userName;
  String? imageUrl;
  String? contact;

  @override
  void initState() {
    super.initState();
    fetchSalonIDsForCurrentUser().then((salonIds) {
      if (salonIds.isNotEmpty) {
        salonId = salonIds.first;
        fetchBookings(salonId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar:AppBar(
          backgroundColor: const Color.fromARGB(247, 84, 74, 158),
          title: const Center(
            child: Text(
              "Appointments",
              style: TextStyle(fontFamily: 'Poppins', fontSize: 25, color: Colors.white),
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white, // Set text color of the selected tab
            unselectedLabelColor: Colors.white, // Set text color of unselected tabs
            tabs: [
              Tab(
                text: "PENDING",
              ),
              Tab(
                text: "COMPLETE",
              ),
            ],
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 14.0),
              child: Icon(Icons.notifications, color: Colors.white),
            )
          ],
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.white), // Set color of the drawer icon
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),

        body: TabBarView(
          children: [
            // First TabBarView for "PENDING"
            buildBookingListView(pendingBookings),

            // Second TabBarView for "COMPLETE"
            buildBookingListView(completeBookings),
          ],
        ),
      ),
    );
  }

  // A helper function to build a ListView for bookings
  Widget buildBookingListView(List<Map<String, dynamic>> bookings) {
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        String userId = bookings[index]['userId'];
        String date = bookings[index]['date'];
        String status = bookings[index]['status'];
        serviceIds = bookings[index]['service_ids'] ?? [];



        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckAppointmentDetails(
                customerName: userName.toString(),
                appointmentSlot: date,
                serviceId: serviceIds,
                contactInformation: contact.toString(),
                status: status,
                imageURL: imageUrl.toString(),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: imageUrl != null
                    ? CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl!),
                  radius: 35,
                )
                    : const CircleAvatar(
                  backgroundImage:
                  AssetImage('assets/default_avatar.png'),
                  radius: 30,
                ),
                trailing: const Icon(Icons.pending, size: 30),
                title: Text(userName ?? "",
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: Colors.black)),
                subtitle: Text(date),
              ),
            ),
          ),
        );
      },
    );
  }
  // return salon ID
  Future<List<String>> fetchSalonIDsForCurrentUser() async {
    try {
      // Get the current user's ID
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        // Handle the case where there is no logged-in user
        return [];
      }

      // Reference to the Firestore collection
      final CollectionReference salonsCollection =
      FirebaseFirestore.instance.collection('salons');

      // Query Firestore to find all salon documents where the userID matches the current user's ID
      final QuerySnapshot salonQuery = await salonsCollection
          .where('userID', isEqualTo: currentUser.uid)
          .get();

      // Extract salon IDs from the matching documents
      final List<String> salonIDs =
      salonQuery.docs.map((doc) => doc.id).toList();
      salonId = salonIDs.toString();
      
      return salonIDs;
    } catch (error) {
      // Handle any errors that occur during the process
      print('Error fetching salon IDs: $error');
      return [];
    }
  }

  // booking detail against salon id
  Future<void> fetchBookings(String salonId) async {
    // Clear the existing data when fetching new data
    pendingBookings.clear();
    completeBookings.clear();
    serviceIds.clear();

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      final QuerySnapshot bookings = await FirebaseFirestore.instance
          .collection('bookings')
          .where('salonID', isEqualTo: salonId)
          .get();
      for (QueryDocumentSnapshot booking in bookings.docs) {
        final Map<String, dynamic> data =
            booking.data() as Map<String, dynamic>;
        String date = data['date_time'];
        String userId = data['user_id'];
        String status = data['status'];
        serviceIds = data['service_ids'];
        print('The salon id is : $salonId');
        if (status == 'Pending') {
          // Fetch user details
          fetchUserDetails(userId);
          pendingBookings.add({'date': date, 'userId': userId,'status': status});
          pendingBookings.addAll(serviceIds as Iterable<Map<String, dynamic>>);
        } else if (status == 'Complete') {
          completeBookings
              .add({'date': date, 'userId': userId, });
        }
      }

      // Trigger a rebuild to display the fetched data

    }
  }
  // user deatrails against user id
  Future<Map<String, dynamic>> fetchUserDetails(String userId) async {
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final Map<String, dynamic> userDetails =
            userDoc.data() as Map<String, dynamic>;
        setState(() {
          userName = userDetails['name'];
        });
        imageUrl = userDetails['profilePicture'];
        contact = userDetails['phone'];

        return userDetails;
      } else {
        // Handle the case where the user document doesn't exist
        print("User document does not exist for userId: $userId");
        return {};
      }
    } catch (error) {
      // Handle any errors that occur during the process
      print('Error fetching user details: $error');
      return {};
    }
  }


}
