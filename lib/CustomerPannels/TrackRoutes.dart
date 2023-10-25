import 'dart:async';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionzone/Components/AppBarComponent.dart';
import 'package:fashionzone/Components/DrawerComponent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoutesTracking extends StatefulWidget {
  final String salonID;
  const RoutesTracking({Key? key, required this.salonID}) : super(key: key);

  @override
  State<RoutesTracking> createState() => _RoutesTrackingState();
}

class _RoutesTrackingState extends State<RoutesTracking> {
  Position? userPosition;
  LatLng salonPosition = const LatLng(0.0000, 0.0000);
  List<LatLng> route=[];

  @override
  void initState() {
    super.initState();
    fetchSalonData(widget.salonID);
  }

  final Completer<GoogleMapController> _controller = Completer();
  static  CameraPosition kGooglePlex = const CameraPosition(
    target:LatLng(33.729435, 73.036947),
    zoom: 14,
  );

  Set<Polyline> polyLines = {};
  List<LatLng> polylineCoordinates = [];

  List<Marker> googleMarkerAdding = [
    const Marker(
      markerId: MarkerId('default location'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(33.729435, 73.036947),
      infoWindow: InfoWindow(title: 'Faisal Mosque'),
    ),
  ];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyCustomAppBarComponent(appBarTitle: 'Find Route'),
      drawer: const MyCustomDrawerComponent(),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: kGooglePlex,
            mapType: MapType.normal,
            myLocationEnabled: true,
            markers: Set<Marker>.of(googleMarkerAdding),
            polylines: polyLines,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search places',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
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
          userPosition = await getUserCurrentLocation();

          if (userPosition != null) {
            setState(() async {
              googleMarkerAdding.add(
                Marker(
                  markerId: const MarkerId('Current Location'),
                  position: LatLng(userPosition!.latitude, userPosition!.longitude),
                  infoWindow: const InfoWindow(title: 'Current Location'),
                ),
              );
              route.add(
                LatLng(userPosition!.latitude, userPosition!.longitude),
              );
              GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(userPosition!.latitude, userPosition!.longitude),
                    zoom: 14,
                  ),
                ),
              );
              route.add(
                LatLng(salonPosition.latitude, salonPosition.longitude),
              );
              polyLines.add(
                 Polyline(
                    polylineId: const PolylineId('1'),
                  points: route
                )
              );

              setState(() {});
            });


          }
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

  void fetchSalonData(String salonID) async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection('salons').doc(salonID).get();
      if (snapshot.exists) {
        var data = snapshot.data();
        if (data != null) {
          String name = data['name'];
          double latitude = double.parse(data['latitude']);
          double longitude = double.parse(data['longitude']);

          if (latitude != null && longitude != null) {
            salonPosition = LatLng(latitude, longitude);
            getBytesFromAssets('images/mapicon.png', 100).then((markerIcon) {
              if (markerIcon != null) {
                setState(() {
                  googleMarkerAdding.add(
                    Marker(
                      markerId: MarkerId(name),
                      icon: BitmapDescriptor.fromBytes(markerIcon),
                      position: LatLng(latitude, longitude),
                      infoWindow: InfoWindow(title: name),
                    ),
                  );
                });
              }
            });
          }
        } else {
          if (kDebugMode) {
            print('No data found for the provided salonID');
          }
        }
      } else {
        if (kDebugMode) {
          print('Document does not exist');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }

  Future<Uint8List?> getBytesFromAssets(String path, int width) async {
    try {
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      if (kDebugMode) {
        print("Check the image ");
        print(fi.image);
      }
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading image: $e');
      }
      return null;
    }
  }


}
