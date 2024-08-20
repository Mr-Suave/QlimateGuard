import "dart:ui";

import "package:speech_to_text/speech_to_text.dart";
import "./voulunteer_page.dart";

import "hospital.dart";
import "firestation.dart";
import "./fire_station_login.dart";

import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:geocoding/geocoding.dart";
import "package:url_launcher/url_launcher.dart";
import "package:geolocator/geolocator.dart";

class GetHelpUi extends StatefulWidget {
  const GetHelpUi({super.key});

  @override
  State<GetHelpUi> createState() => _GetHelpUi();
}

class _GetHelpUi extends State<GetHelpUi> {
  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;
  String _speechGot = "";

  void getListener() async {
    _speechEnabled = await _speechToText.initialize();
  }

  void _getAudioInput() async {
    if (_speechToText.isNotListening) {
      await _speechToText.listen(onResult: _onObtainingResult);
    }
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onObtainingResult(result) async {
    setState(() {
      _speechGot = "${result.recognizedWords}";
      // print("${result.recognizedWords}");
      if (_speechGot == "call ambulance") {
        dialANumber("108");
      }
      if (_speechGot == "call fire engine") {
        dialANumber("101");
      }
    });
  }

  //invoke dialer
  dialANumber(String phn) async {
    final Uri dialNumber = Uri(scheme: "tel", path: phn);
    await launchUrl(dialNumber);
  }

  String fireStationKey = "2015";
  TextEditingController keycontroller = TextEditingController();
  bool _hideText = true;
  late List<Placemark> getLocalityInfo;
  late String city = "";
  late String state = "";
  final hospital = GetHospitalInfo();
  final firestationInfo = FirestationInfo();
  late Future<Map<String, dynamic>> firestations = Future.value({});

  late Map<String, String> fireStationInfo = {};

  void _displayPasswordDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Enter the security Key"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: keycontroller,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _hideText,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hideText = !_hideText;
                              });
                            },
                            icon: Icon(_hideText
                                ? Icons.visibility_off
                                : Icons.visibility))),
                  )
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      if (keycontroller.text == fireStationKey) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                        keycontroller.clear();
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Enterd Wrong key")));
                        keycontroller.clear();
                      }
                    },
                    child: const Text("Enter Fire Station Data"))
              ],
            );
          });
        });
  }

  //get user pincode
  Future<String> _getUserPincode() async {
    try {
      Position position = await hospital.userCurrentLocation();
      String pincode = await _getPinCode(position);
      return pincode;
    } catch (e) {
      setState(() {
        city = "Error:$e";
      });
      throw "Error occured is:$e";
    }
  }

  Future<String> _getPinCode(Position position) async {
    try {
      getLocalityInfo =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (getLocalityInfo.isNotEmpty) {
        setState(() {
          city = getLocalityInfo[0].locality!;
          state = getLocalityInfo[0].administrativeArea!;
        });
        print("The city obtained is:$city");
        return city;
      } else {
        setState(() {
          city = "Not able to find the city";
        });
        return Future.error("Unable to find City");
      }
    } catch (e) {
      throw "The Error is:$e";
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserPincode().then((_) {
      firestations = firestationInfo.searchUsingPincode(city, state);
    });
    getListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  hospital.getNearbyHospitals();
                  firestations =
                      firestationInfo.searchUsingPincode(city, state);
                });
              },
              icon: const Icon(Icons.refresh))
        ],
        centerTitle: true,
        title: const Text(
          'GET HELP',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 100,
        backgroundColor: const Color.fromARGB(255, 24, 13, 122),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(FontAwesomeIcons.locationDot),
                    Text(
                      city,
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text('Hospitals',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 320,
                  width: double.infinity,
                  child: Card(
                    elevation: 15,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 10,
                            sigmaY: 10,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.pink, width: 2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: FutureBuilder<List<Map<String, String>>>(
                                  future: hospital.getNearbyHospitals(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: CircularProgressIndicator()),
                                      );
                                    }
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text(snapshot.error.toString()),
                                      );
                                    }
                                    if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Center(
                                          child: Text(
                                              "Unable to fetch hospitals"));
                                    }
                                    final hospitalData = snapshot.data ?? [];
                                    return ListView.builder(
                                        itemCount: 3,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            child: ListTile(
                                              title: Text(hospitalData[index]
                                                      ["name"] ??
                                                  "Name of hospital is not available"),
                                              subtitle: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(hospitalData[
                                                                      index]
                                                                  ["address"] ??
                                                              "Address is not Found"),
                                                          Text(hospitalData[
                                                                      index]
                                                                  ["Phone"] ??
                                                              "108")
                                                        ],
                                                      ),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            dialANumber(hospitalData[
                                                                        index]
                                                                    ["Phone"] ??
                                                                "108");
                                                          },
                                                          child: const Text(
                                                              "Call"))
                                                    ],
                                                  )),
                                            ),
                                          );
                                        });
                                  }),
                            ),
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text('Fire Stations',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 340,
                  width: double.infinity,
                  child: Card(
                    elevation: 15,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.green, width: 2),
                          ),
                          child: Card(
                            child: FutureBuilder(
                              future: firestations,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator()),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text(
                                          "The error is :${snapshot.error}"));
                                } else if (snapshot.hasData) {
                                  final data = snapshot.data!;
                                  if (data.isEmpty) {
                                    return const Center(
                                      child: Text("No Fire Stations found"),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Locality:${data["Locality"] ?? "N/A"}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w200),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            "SubLocality:${data["SubLocality"] ?? "N/A"}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            "City:${data["City"] ?? "N/A"}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            "State:${data["State"] ?? "N/A"}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Text(
                                            "Telephone(or)Mobile:${data["Mobile Number"] ?? "N/A"}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 20),
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                dialANumber(
                                                    data["Mobile Number"]);
                                              },
                                              child: const Text(
                                                  "Call Fire Station"))
                                        ],
                                      ),
                                    );
                                  }
                                } else {
                                  return const Center(
                                      child: Text("Some error occured"));
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        dialANumber("108");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              12), // Radius for the corners
                        ),
                      ),
                      child: const Text('Ambulance',
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        dialANumber("101");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              12), // Radius for the corners
                        ),
                      ),
                      child: const Text('Fire Engine',
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    _displayPasswordDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Radius for the corners
                    ),
                  ),
                  child: const Text('Add a Fire Station',
                      style: TextStyle(
                        color: Colors.black,
                      )),
                ),
                SizedBox(
                  height: 150,
                  width: 400,
                  child: Card(
                    child: Column(
                      children: [
                        Text(_speechToText.isListening
                            ? "Listening..."
                            : _speechEnabled
                                ? "Try saying \"call ambulance\" or \"call fire engine\" "
                                : "Speech is not available"),
                        const SizedBox(height: 16),
                        FloatingActionButton(
                          onPressed: _speechToText.isListening
                              ? _stopListening
                              : _getAudioInput,
                          tooltip: "Listen",
                          child: Icon(_speechToText.isNotListening
                              ? Icons.mic_off
                              : Icons.mic),
                        ),
                        Expanded(
                            child: Text(_speechGot.isNotEmpty
                                ? _speechGot
                                : "No Speech Detected")),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
