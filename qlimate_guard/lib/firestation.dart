import "package:cloud_firestore/cloud_firestore.dart";

class FirestationInfo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //search across the data base for the fire station using the city Name
  Future<Map<String, dynamic>> searchUsingPincode(
      String city, String state) async {
    try {
      CollectionReference collection = _firestore.collection("FireStations");
      QuerySnapshot fsInfo =
          await collection.where("City", isEqualTo: city).get();
      if (fsInfo.docs.isEmpty) {
        fsInfo = await collection.where("State", isEqualTo: state).get();
      }
      if (fsInfo.docs.isNotEmpty) {
        var data = fsInfo.docs.first.data() as Map<String, dynamic>;
        return data;
      } else {
        return {};
      }
    } catch (e) {
      throw "The error occured is $e";
    }
  }
}
