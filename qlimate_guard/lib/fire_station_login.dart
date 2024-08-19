import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:qlimate_guard/get_help_ui.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final sublocalitycontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final districtcontroller = TextEditingController();
  final postcodecontroller = TextEditingController();
  final statecontroller = TextEditingController();
  final localitycontroller = TextEditingController();
  final numbercontroller = TextEditingController();
  final telephonecontroller = TextEditingController();

  Future<bool> _fireStationExistence(String number) async {
    QuerySnapshot existence = await FirebaseFirestore.instance
        .collection("FireStations")
        .where("Mobile Number", isEqualTo: number)
        .get();
    return existence.docs.isNotEmpty;
  }

  void _addFireStationToDatabase(BuildContext context) async {
    CollectionReference firestationinfo =
        FirebaseFirestore.instance.collection("FireStations");
    firestationinfo.add({
      "Locality": localitycontroller.text,
      "City": citycontroller.text,
      "District": districtcontroller.text,
      "PinCode": postcodecontroller.text,
      "State": statecontroller.text,
      "SubLocality": sublocalitycontroller.text,
      "Mobile Number": numbercontroller.text,
      "Telephone": telephonecontroller.text,
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Data Added Successfully")));
  }

  void _displayDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Attention"),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    "The information you entered here is used for displaying purpose in Emergency situations"),
                SizedBox(
                  height: 16,
                ),
                Text(
                    "Ensure that you filled all the columns with correct. Remember that all the fields are case sensitive."),
                SizedBox(
                  height: 16,
                ),
                Text("The information provided will not be shared to anyone"),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    if (localitycontroller.text.isEmpty ||
                        citycontroller.text.isEmpty ||
                        districtcontroller.text.isEmpty ||
                        postcodecontroller.text.isEmpty ||
                        statecontroller.text.isEmpty ||
                        (numbercontroller.text.isEmpty ||
                            telephonecontroller.text.isEmpty) ||
                        sublocalitycontroller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please fill all the fields")));
                    } else {
                      if (await _fireStationExistence(numbercontroller.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "FireStation already Exists with this mobile number")));
                      } else if (await _fireStationExistence(
                          telephonecontroller.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Firen Station already exists with this number")));
                      } else {
                        _addFireStationToDatabase(context);
                        Navigator.pop(
                          context,MaterialPageRoute(builder: (context) => GetHelpUi()) );
                      }
                    }
                  },
                  child: const Text("Continue to Enter"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 66, 66),
          title: const Text("FireStations Login Page"),
          centerTitle: true,
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Locality",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white)),
              TextFormField(
                controller: localitycontroller,
                
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 249, 161, 70),
                    )),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
              ),
              const SizedBox(height: 16),
              const Text("SubLocality",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white)),
              TextFormField(
                keyboardType: TextInputType.streetAddress,
                controller: sublocalitycontroller,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 249, 161, 70),
                    )),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
              ),
              const SizedBox(height: 16),
              const Text("City",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white)),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: citycontroller,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 249, 161, 70),
                    )),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
              ),
              const SizedBox(height: 16),
              const Text("District",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white)),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: districtcontroller,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 249, 161, 70),
                    )),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
              ),
              const SizedBox(height: 16),
              const Text("State",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white)),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: statecontroller,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 249, 161, 70))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
              ),
              const SizedBox(height: 16),
              const Text("PinCode(6-digit)",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white)),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: postcodecontroller,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 249, 161, 70))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6)
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter the 6 digit pincode";
                  } else if (value.length != 6) {
                    return "Pincode must have 6 digits";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              const Text("Mobile Number(firestation authority)",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white)),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(),
                controller: numbercontroller,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 249, 161, 70),
                    )),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10)
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Text("Telephone Number",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white)),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(),
                controller: telephonecontroller,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 249, 161, 70),
                    )),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(7)
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (localitycontroller.text.isEmpty ||
                        citycontroller.text.isEmpty ||
                        districtcontroller.text.isEmpty ||
                        postcodecontroller.text.isEmpty ||
                        statecontroller.text.isEmpty ||
                        (numbercontroller.text.isEmpty ||
                            telephonecontroller.text.isEmpty) ||
                        sublocalitycontroller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please fill all the fields")));
                    } else {
                      if (await _fireStationExistence(numbercontroller.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "FireStation already Exists with this mobile number")));
                      } else if (await _fireStationExistence(
                          telephonecontroller.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Firen Station already exists with this number")));
                      } else {
                        _displayDialog(context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: const Color.fromARGB(255, 179, 255, 252),
                      foregroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  child: const Text("Add FireStation"))
            ],
          ),
        ),
      ),
    );
  }
}
