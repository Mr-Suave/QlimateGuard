import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class AdminPage extends StatefulWidget {
  final String username;

  const AdminPage({super.key,required this.username});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void _deleteAlert(String AlertId) async {
    try {
      await _firestore.collection("Alerts").doc(AlertId).delete();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("The alert has been deleted successfully")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error occured in deleteing the alert")));
    }
  }
  final TextEditingController _cityController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _disasterSelected;
  final List<String> _naturalDisasters=[
    'Cyclone','Tornado','Hurricane','Blizzards','Ice storms','Heatwaves','Cold waves','Wildfires','Landslides','Earthquake','Floods',
  ];

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          elevation: 15,
          centerTitle: true,
          backgroundColor: Colors.orange[500],
          title: Text("Admin",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.lightBlue[200]),),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16,),
              Text('Hello ${widget.username}!',style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.orange),),
              const SizedBox(height: 20,),
          
               SizedBox(
                width: double.infinity,
                height: 300,
                child: Card(     
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange,width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ), 
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 12,),
                            DropdownButtonFormField<String>(
                              value: _disasterSelected,
                              decoration: const InputDecoration(
                                labelText: 'Select a Disaster',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String? newdisaster){
                                setState(() {
                                  _disasterSelected=newdisaster;
                                });
                              },
                              validator: (value){
                                if(value==null){
                                  return 'Please select a disaster';
                                }
                                return null;
                              },
                              items: _naturalDisasters.map<DropdownMenuItem<String>>((String disaster){
                                return DropdownMenuItem<String>(
                                  value: disaster,
                                  child: Text(disaster),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 35,),
                              TextFormField(
                                controller: _cityController,
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.name,
                                validator: (value){
                                  if(value==null || value.isEmpty){
                                    return 'Please enter the city/place';
                                  }
                                  return null;
                                },
                                decoration:const  InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: "City/Place",
                                                hintStyle: TextStyle(color: Colors.white),
                                              ),
                                ),
                              const SizedBox(height: 35,),
                              ElevatedButton(
                                style:  ButtonStyle(
                                  shadowColor: MaterialStateProperty.all(Colors.orange),
                                  elevation: MaterialStateProperty.all(30),
                                ), 
                                onPressed: () async{
                                  if(_formKey.currentState!.validate()){
                                    CollectionReference alerts =FirebaseFirestore.instance.collection('Alerts');
                                    DateTime now=DateTime.now();
                                    Map<String,String> data={
                                      'Places': '${_cityController.text}',
                                      'Content': '->  $_disasterSelected in ${_cityController.text}. Be safe and help the needy. ~ ${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}'
                                    };
                                    try{
                                      await alerts.add(data);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Alert added Successfully")));
                                    }catch(e){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Error in adding the alert")));
                                    }
                                  }
                        
                              }, child: const Text('Send Alert',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Text('Alerts sent',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.orange)),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                height: 400,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange,width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ), 
                  child:  StreamBuilder<QuerySnapshot>(
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
                                    
                                    trailing: IconButton(
                                        onPressed: () {
                                          _deleteAlert(alertId);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.green,
                                        )),
                                  );
                                });
                          }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}