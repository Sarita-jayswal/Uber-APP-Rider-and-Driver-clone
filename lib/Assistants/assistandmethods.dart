import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:uber_app/Assistants/requesthttp.dart';
import 'package:uber_app/DataHandler/appdata.dart';
import 'package:uber_app/Models/address.dart';
import 'package:uber_app/map.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String placeAddress = "";
    String url =
        "http://api.positionstack.com/v1/reverse?access_key=$mapKey&query=${position.latitude},${position.longitude}";
    var response = await RequestAssistant.getRequest(url);
    if (response != "failed") {
      placeAddress = response["data"][0]["country"];
      Address userPickUpAddress = Address();
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;
      Provider.of<AppData>(context, listen: false)
          .updatePickUpLocationAddress(userPickUpAddress);
    }
    return placeAddress;
  }
}
