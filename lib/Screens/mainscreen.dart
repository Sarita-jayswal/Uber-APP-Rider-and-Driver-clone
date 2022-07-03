import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_app/Widgets/divider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String idScreen = "mainscreen";
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  Position? currentPosition;
  var geoLocator = Geolocator();

  void locatePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        appBar: AppBar(
          title: const Text("Rider App"),
        ),
        drawer: Container(
          color: Colors.white,
          width: 255,
          child: Drawer(
              child: ListView(
            children: [
              SizedBox(
                height: 165,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(children: [
                    Image.asset("images/user_icon.png", height: 65, width: 65),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Profile Name",
                          style:
                              TextStyle(fontSize: 16, fontFamily: "Brand-Bold"),
                        ),
                        SizedBox(height: 60),
                        Text("Visit Profile")
                      ],
                    )
                  ]),
                ),
              ),
              const DividerWidget(),
              const SizedBox(height: 12),
              const ListTile(
                leading: Icon(Icons.history),
                title: Text(
                  "History",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "Visit Profile",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  "About",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          )),
        ),
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;
                locatePosition();
              },
            ),
            Positioned(
              top: 45,
              left: 22,
              child: GestureDetector(
                onTap: () {
                  scaffoldkey.currentState!.openDrawer();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 6,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7))
                      ]),
                  child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.menu,
                        color: Colors.black,
                      )),
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                    height: 320,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 16,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7),
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          const Text("Hey there,",
                              style: TextStyle(fontSize: 12)),
                          const Text("Where to?",
                              style: TextStyle(
                                  fontSize: 20, fontFamily: "Brand-Bold")),
                          const SizedBox(height: 20),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 6,
                                    spreadRadius: 0.5,
                                    offset: Offset(0.7, 0.7),
                                  )
                                ]),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.search,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Search Drop Destination",
                                  style: TextStyle(fontSize: 10),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Icon(Icons.home, color: Colors.grey),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("Add Home"),
                                  SizedBox(height: 4),
                                  Text("Your current address",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ))
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          const DividerWidget(),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(Icons.work, color: Colors.grey),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("Add Work"),
                                  SizedBox(height: 4),
                                  Text(
                                    "Your work address",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ))),
          ],
        ));
  }
}
