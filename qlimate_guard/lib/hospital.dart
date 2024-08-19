import "package:geolocator/geolocator.dart";
import "dart:convert";
import "package:http/http.dart" as http;

class GetHospitalInfo {
  //get user's current location using geolocator package

  Future<Position> userCurrentLocation() async {
    bool isServiceEnabled;
    LocationPermission permission;

    //checking if the location service is enabled
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error("Location Services are disabled");
    }

    //checking if the permission is provided for the app for using location in mobile
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(
            "Location permission is denied.Location cannot be obtained");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location Permission is denied forever");
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  //getting the nearby hospitals based on the current location

  Future<List<Map<String, String>>> getNearbyHospitals() async {
    try {
      Position position = await userCurrentLocation();
      final latitude = position.latitude;
      final longitude = position.longitude;

      final hosInfoURL =
          'https://overpass-api.de/api/interpreter?data=[out:json];(node["amenity"="hospital"](around:20000,$latitude,$longitude););out;';
      final opFromAPI = await http.get(Uri.parse(hosInfoURL));
      if (opFromAPI.statusCode == 200) {
        final data = jsonDecode(opFromAPI.body);
        List<dynamic> hospitalData = data["elements"]??[];
        List<Map<String, String>> hospitals = [];
        //Avoid the hospitals like dental etc;
        List<String> unnecessary = [
          "Centre",
          "Center",
          "Orthopaedic",
          "dental",
          "eye clinc",
          "research",
          "Ayurvedic",
          "Homeo",
          "Ortho",
          "Eye Hospital",
          "Nursing Home"
        ];

        for (var ele in hospitalData) {
          String hosName = ele["tags"]["name"];
          String hosaddr = ele["tags"]["addr:full"] ?? "Unable to find Address";
          String hosNo = ele["tags"]["contact:mobile"] ??
              ele["tags"]["contact:phone"] ??
              ele["tags"]["phone"] ??
              ele["tags"]["mobile"] ??
              "Mobile Number not available";
          if (hosNo != "Mobile Number not available" &&
              (hosNo.length == 10 || hosNo.length == 11) &&
              (hosaddr.length < 75)) {
            if (!unnecessary.any((keyword) => hosName.contains(keyword))) {
              hospitals.add({
                "name": hosName,
                "address": hosaddr,
                "Phone": hosNo,
              });
            }
          }
        }
        return hospitals;
      } else {
        throw "Unable to load the hospitals";
      }
    } catch (e) {
      return [];
    }
  }
}
