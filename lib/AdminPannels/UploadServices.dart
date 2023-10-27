import 'dart:io' as io;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionzone/CommonPannels/Signup.dart';
import 'package:fashionzone/Components/AppBarComponent.dart';
import 'package:fashionzone/Components/DrawerComponent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart ' as firebase_storage;

import '../Components/AdminListtileUploadServices.dart';

class UploadServices extends StatefulWidget {
  const UploadServices({Key? key}) : super(key: key);

  @override
  State<UploadServices> createState() => _UploadServicesState();
}

class _UploadServicesState extends State<UploadServices> {
  final ImagePicker _imagePicker = ImagePicker();
  PickedFile? _imageFile;
  bool showError = false;
  final formKey = GlobalKey<FormState>();
  final servicesController = TextEditingController();
  final priceController = TextEditingController();
  String? servicePictureURL;
  String? service;
  String? price;
  List<Map<String, dynamic>> fetchedServices = [];
  Map<String, dynamic>? _selectedService;
  String? _selectedServiceId;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchServicesData();
  }

  // take photo
  void takePhoto(ImageSource source) async {
    final pickedFile = await _imagePicker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: const MyCustomAppBarComponent(appBarTitle: 'Upload Services'),
        drawer: const MyCustomDrawerComponent(),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 14.0, left: 14.0, right: 14.0),
                  child: Column(
                    children: [
                      // top two field and button of add
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: formKey,
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: Material(
                                  elevation: 5,
                                  shadowColor: Colors.black,
                                  child: TextFormField(
                                    controller: servicesController,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      labelText: 'Services',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(247, 84, 74, 158),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                247, 84, 74, 158),
                                            width: 1),
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                    style: const TextStyle(
                                        fontFamily: 'Poppins', fontSize: 15),
                                    validator: (value) {
                                      if (value!.isEmpty &&
                                          value.length < 3) {
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
                            ),
                            const SizedBox(
                                width:
                                    10), // Add space between the text fields
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Material(
                                elevation: 5,
                                shadowColor: Colors.black,
                                child: TextFormField(
                                  controller: priceController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: 'Price',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: Color.fromARGB(247, 84, 74, 158),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              247, 84, 74, 158),
                                          width: 1),
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  style: const TextStyle(
                                      fontFamily: 'Poppins', fontSize: 15),
                                  validator: (value) {
                                    if (value!.isEmpty && value.length < 3) {
                                      return 'Please enter the price.';
                                    } else if (!RegExp(r'^[0-9]+$')
                                        .hasMatch(value)) {
                                      return 'Invalid price format. Please enter a valid number.';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor:
                                      const Color.fromARGB(247, 84, 74, 158),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate() &&
                                      _imageFile != null) {
                                    FocusScope.of(context).unfocus();
                                    uploadServicesData();
                                  }
                                },
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // space in which the pic show
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(247, 84, 74, 158),
                          ),
                        ),
                        child: _imageFile == null
                            ? (servicePictureURL != null
                                ? Image.network(
                                    servicePictureURL!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset('assets/placeholder_image.png'))
                            : Image.file(
                                io.File(_imageFile!.path),
                                fit: BoxFit.cover,
                              ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 1,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(247, 84, 74, 158),
                              onPrimary: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              takePhoto(ImageSource.gallery);
                            },
                            child: const Text(
                              "Add service picture",
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 16),
                            )),
                      ),

                  const SizedBox(
                    height: 10,
                  ),
                      // edit button for save
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 1,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            backgroundColor: const Color.fromARGB(247, 84, 74, 158),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              saveEditedService(); // Save the edited data
                            }
                          },
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
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
                const SizedBox(
                  height: 30,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('services')
                      .where('userID', isEqualTo: user?.uid) // Add this line to filter services by the current user's UID
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // While waiting for data to load, you can display a loading indicator.
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // If there's an error, display an error message.
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // If data is available, build the list of services.
                      List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                      if (documents.isEmpty) {
                        // Handle the case when there are no services.
                        return const Text('No services added yet.',
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 16));
                      } else {
                        // Build the list of services using a ListView or other widget.
                        return ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(), // Prevents scrolling
                          children: documents.map((doc) {
                            Map<String, dynamic> serviceData = doc.data() as Map<String, dynamic>;
                            String id = doc.id; // Get the document ID
                            return MyCustomListTileAdminComponent(
                              id: id,
                              servicesName: serviceData['name'],
                              price: serviceData['price'].toString(),
                              imageFile: serviceData['imageURL'],
                              onDelete: () {
                                deleteService(id, serviceData['imageURL']);
                              },
                              onEdit: () {
                                editService(serviceData, id); // Pass the service data and ID to editService
                              },
                            );
                          }).toList(),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void uploadServicesData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (_imageFile == null) {
      Fluttertoast.showToast(
        msg: "Please select an image",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName =
          'service_${user?.uid}_$timestamp.jpg'; // Generate a unique file name
      final storageReference = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('servicesImage')
          .child(fileName);

      final uploadTask = storageReference.putFile(io.File(_imageFile!.path));
      final snapshot = await uploadTask.whenComplete(() {});

      if (snapshot.state == firebase_storage.TaskState.success) {
        final downloadURL = await snapshot.ref.getDownloadURL();
        servicePictureURL = downloadURL;

        final serviceData = {
          'name': servicesController.text,
          'price': int.parse(priceController.text),
          'imageURL': downloadURL,
          'userID': user?.uid,
        };

        final DocumentReference docRef = await FirebaseFirestore.instance
            .collection('services')
            .add(serviceData);

        final String serviceId = docRef.id;

        DocumentReference<Map<String, dynamic>> userRef =
            FirebaseFirestore.instance.collection('salons').doc(user?.uid);

        await userRef.update({
          'servicesId': FieldValue.arrayUnion([serviceId]),
        });

        Fluttertoast.showToast(
          textColor: Colors.white,
          backgroundColor: const Color.fromARGB(247, 84, 74, 158),
          msg: "Service added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );

        setState(() {
          servicesController.clear();
          priceController.clear();
          _imageFile = null;
        });
      } else {
        Fluttertoast.showToast(
          msg: "Failed to upload image",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Error: $error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Future<void> fetchServicesData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Handle the case when the user is not authenticated
      return ;
}

    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance
          .collection('services')
          .doc(user.uid)
          .get();
      print("This is the user id  check it with data base "+user.uid);

      print(documentSnapshot);


      if (documentSnapshot.exists) {
        // Data for the specific salon/user exists
        Map<String, dynamic> data = documentSnapshot.data() ?? {};

        setState(() {
          // Update your local variables with the fetched data
          service = data['name'] ?? '';
          price = (data['price'] ?? 0).toString();
          servicePictureURL = data['imageURL'] ?? '';
        });
      } else {
        print("Salon data not found for user: ${user.uid}");
        // Handle the case when the salon data is not found
      }
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }


  Future<void> deleteService(String documentId, String imageURL) async {
    try {
      // Check if the document exists before attempting to delete it
      final docSnapshot = await FirebaseFirestore.instance
          .collection('services')
          .doc(documentId)
          .get();

      if (docSnapshot.exists) {
        // Delete the service document from Firestore
        await FirebaseFirestore.instance
            .collection('services')
            .doc(documentId)
            .delete();

        // Delete the associated image from Firebase Storage
        final storageReference =
        firebase_storage.FirebaseStorage.instance.refFromURL(imageURL);
        await storageReference.delete();

        // Remove the service ID from the "salons" collection
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final DocumentReference<Map<String, dynamic>> userRef =
          FirebaseFirestore.instance.collection('salons').doc(user.uid);

          await userRef.update({
            'servicesId': FieldValue.arrayRemove([documentId]),
          });
        }

        // Successful deletion, you can add a print statement here for debugging
        print("Service deleted successfully");
        fetchServicesData(); // Fetch updated data after deletion
      } else {
        // Handle the case where the document no longer exists
        Fluttertoast.showToast(
          msg: "Document not found. It may have been deleted by another user.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        // Optionally, you can refresh the data or take other actions here.
      }
    } catch (error) {
      // Error occurred while deleting the service, print the error for debugging
      print("Error deleting service: $error");
      Fluttertoast.showToast(
        msg: "Error deleting service: $error",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  // Function to edit a selected service
  void editService(Map<String, dynamic> selectedService, String serviceId) {
    setState(() {
      // Set the selected service for editing
      _selectedService = selectedService;
      _selectedService?['id'] = serviceId; // Add the 'id' field
      servicesController.text = selectedService['name'];
      priceController.text = selectedService['price'].toString();
      servicePictureURL = selectedService['imageURL'];
      _imageFile = null;
      // You can also store the service ID for later use
      _selectedServiceId = serviceId;
    });
  }

  // Function to save changes to the edited service
  void saveEditedService() async {
    print("this is the id check it: $_selectedService");
    try {
      print("inside try");
      if (_selectedService != null) {
        final documentId = _selectedService?['id'];
        print("documentId: $documentId"); // Add this line to check the documentId
        if (documentId != null) {
          // Check if the document exists before updating it
          final docSnapshot = await FirebaseFirestore.instance
              .collection('services')
              .doc(documentId)
              .get();

          if (docSnapshot.exists) {
            final updatedServiceData = {
              'name': servicesController.text,
              'price': int.parse(priceController.text),
              'imageURL': servicePictureURL,
            };

            await FirebaseFirestore.instance
                .collection('services')
                .doc(documentId)
                .update(updatedServiceData);

            Fluttertoast.showToast(
              textColor: Colors.white,
              backgroundColor: const Color.fromARGB(247, 84, 74, 158),
              msg: "Service updated successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );

            // Clear the selected service and fields after saving
            setState(() {
              _selectedService = null;
              servicesController.clear();
              priceController.clear();
              _imageFile = null;
            });
          } else {
            // Handle the case where the document no longer exists
            Fluttertoast.showToast(
              msg: "Document not found. It may have been deleted by another user.",
              backgroundColor: Colors.red,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
            // Optionally, you can reset the form or take other actions here.
          }
        } else {
          // Handle the case where the 'id' field is null in _selectedService
          print("Error: 'id' field is null in _selectedService");
        }
      } else {
        // Handle the case where _selectedService is null
        print("Error: _selectedService is null");
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Error updating service: $error",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

}
