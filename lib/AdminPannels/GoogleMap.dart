import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import '../Components/AppBarComponent.dart';
import '../Components/DrawerComponent.dart';
import 'dart:ui' as ui;

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key? key}) : super(key: key);

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  TextEditingController searchController = TextEditingController();
  var uuid = const Uuid();
  String? sessionToken;
  List<dynamic> places = [];
  final Completer<GoogleMapController> _controller = Completer( );
  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(33.729435, 73.036947),
    zoom: 14,
  );
  List<Marker> googleMarker = [];
  List<Marker> googleMarkerAdding = [
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(33.729435, 73.036947),
        infoWindow: InfoWindow(
          title: 'Faisal Mosque',
        )),
  ];
  Uint8List? markerImage;

  @override
  void initState() {
    super.initState();
    googleMarker.addAll(googleMarkerAdding);
    searchController.addListener(() {
      onChange();
    });
    // Fetch the salon data and add a marker for it
    String userId = FirebaseAuth.instance.currentUser!.uid;
    fetchSalonFromFirestore(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBarComponent(appBarTitle: 'Add Google Map'),
      drawer: const MyCustomDrawerComponent(),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: kGooglePlex,
            mapType: MapType.normal,
            myLocationEnabled: true,
            markers: Set<Marker>.of(googleMarkerAdding),
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(

                hintText: 'Search places',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),

              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        backgroundColor: const Color.fromARGB(247, 84, 74, 158),
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            if (kDebugMode) {
              print("Your current latitude and longitude is :");
              print("${value.latitude} ${value.longitude}");
            }

            googleMarkerAdding.add(
              Marker(
                markerId: const MarkerId('2'),
                position: LatLng(value.latitude.toDouble(), value.longitude.toDouble()),
                infoWindow: const InfoWindow(title: 'Your current location'),
              ),
            );
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(value.latitude.toDouble(), value.longitude.toDouble()),
                  zoom: 14,
                ),
              ),
            );
            convertCoordinatesIntoAddress(value.latitude.toDouble(), value.longitude.toDouble());
            //open bottom sheet
            setState(() {});
          });
        },
        child: const Icon(Icons.my_location_outlined),
      ),
    );
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) {
      if (kDebugMode) {
        print("error$error");
      }
    });
    return await Geolocator.getCurrentPosition();
  }

  void onChange() {
    if (searchController.text.isNotEmpty) {
      if (sessionToken == null) {
        setState(() {
          sessionToken = uuid.v4();
        });
      }
      createSuggestion(searchController.text);
    }
  }

  void createSuggestion(String input) async {
    String APIKEY = 'AIzaSyC5WwVhfdBloWcVzKYOVFAqKRzZoAC4DfU';
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$APIKEY&sessiontoken=$sessionToken';

    try {
      var response = await http.get(Uri.parse(request));
      if (kDebugMode) {
        print(response.body.toString());
      }
      if (response.statusCode == 200) {
        setState(() {
          places = json.decode(response.body)['predictions'];

        });
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  void convertCoordinatesIntoAddress(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        if (kDebugMode) {
          print("Address: ${place.street}");
        }
        _showAddressBottomSheet(place.street ?? 'No address found',lat.toString(),long.toString());
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  void _showAddressBottomSheet(String address, String lat,String long,) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Confirm your address',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 14),
              Text(
                address,
                style: const TextStyle(fontSize: 16,fontFamily: 'Poppins',fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 14),
              Text(
                "$lat , $long",
                style: const TextStyle(fontSize: 16,fontFamily: 'Poppins',fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 14),
              ElevatedButton(
               style: ElevatedButton.styleFrom(
                 elevation: 5,
                 backgroundColor:  const Color.fromARGB(
                     247, 84, 74, 158),
               ),
                onPressed: () {
                  // Send the location to the Firestore database
                  String userId = FirebaseAuth.instance.currentUser!.uid; // Get the current user ID
                  sendAddressToFirestore(userId, address,lat,long);
                  Navigator.pop(context);
                },
                child: const Text('Add to GoogleMap'),
              ),
            ],
          ),
        );
      },
    );
  }
  void sendAddressToFirestore(String userId, String address,String latitude,String longitude) {
    FirebaseFirestore.instance
        .collection('salons')
        .where('userID', isEqualTo: userId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.update({
          'salonAddress': address,
          'latitude':latitude,
          'longitude':longitude,

        }).then((value) {
          if (kDebugMode) {
            print('Address added to Firestore');
          }
          Fluttertoast.showToast(
            gravity: ToastGravity.BOTTOM,
              msg: 'Successfully added your salon!');
        }).catchError((error) {
          if (kDebugMode) {
            print('Failed to add address: $error');
          }
        });
      });
    }).catchError((error) {
      if (kDebugMode) {
        print('Failed to find the salon with the userID: $error');
      }
    });
  }
  void fetchSalonFromFirestore(String userId) async {
    FirebaseFirestore.instance
        .collection('salons')
        .where('userID', isEqualTo: userId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var salonData = doc.data() as Map<String, dynamic>;
        var salonName = salonData['name'];
        var salonAddress = salonData['salonAddress'];
        var salonLatitude = salonData['latitude'];
        var salonLongitude = salonData['longitude'];
        if (salonName != null && salonAddress != null) {
          getBytesFromAssets('images/mapicon.png', 100).then((markerIcon) {
            setState(() {
              googleMarkerAdding.add(
                Marker(
                  markerId: MarkerId(salonName),
                  icon: BitmapDescriptor.fromBytes(markerIcon!),
                  position: LatLng(
                      double.parse(salonLatitude), double.parse(salonLongitude)),
                  infoWindow: InfoWindow(title: salonName),
                ),
              );
            });
          });
        } else {
          if (kDebugMode) {
            print('Salon name or address is null');
          }
        }
      });
    }).catchError((error) {
      if (kDebugMode) {
        print('Failed to fetch salon data: $error');
      }
    });
  }
  Future<Uint8List?> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width); // use targetWidth instead of targetHeight
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
  }
}
