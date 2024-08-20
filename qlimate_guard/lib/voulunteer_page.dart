import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import 'package:url_launcher/url_launcher.dart';

class VoulunteerPage extends StatefulWidget {
  final String username;
  const VoulunteerPage({super.key,required this.username});

  @override
  State<VoulunteerPage> createState() => _VoulunteerPageState();
}

class _VoulunteerPageState extends State<VoulunteerPage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            backgroundColor: Colors.orange,
            title: const Text("Volunteer Alerts",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 27, 228, 215))),
            centerTitle: true,
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16,),
              Text('Hello ${widget.username}!',style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.orange),),
              const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange, width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(16))),
                  child: SizedBox(
                    height: 500,
                    width: double.infinity,
                    child: Card(
                      elevation: 26,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: _firestore.collection("Alerts").snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child:
                                      Text("The error occured is ${snapshot.error}"));
                            }
                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                              return Center(child: Text("No current alerts"));
                            }
                            final alerts = snapshot.data!.docs;
                            return ListView.builder(
                                itemCount: alerts.length,
                                itemBuilder: (context, index) {
                                  final gotAlert = alerts[index];
                                  final alertId = gotAlert.id;
                                  final alertContent =
                                      gotAlert["Content"] ?? "No text inside the alert";
                                  final city = gotAlert["Places"] ?? "Maps not found";
                                  return ListTile(
                                    title: Text(alertContent),
                                    
                                  );
                                });
                          }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
