import 'package:flutter/material.dart';

import '../Models/address.dart';
//import 'package:geocode/geocode.dart';

class AppData extends ChangeNotifier {
  Address? pickUpLocation;
  void updatePickUpLocationAddress(Address pickUpAddress) {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }
}
