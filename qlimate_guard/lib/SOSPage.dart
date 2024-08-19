import 'dart:convert';

import 'package:flutter/material.dart';
import './loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './secrets.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;

class SOSPage extends StatefulWidget {
  const SOSPage({super.key});

  @override
  State<SOSPage> createState() => _SOSPageState();
}

class _SOSPageState extends State<SOSPage> {
  final TextEditingController _cityController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _disasterSelected;
  final List<String> _naturalDisasters=[
    'Cyclone','Tornado','Hurricane','Blizzards','Ice storms','Heatwaves','Cold waves','Wildfires','Landslides','Earthquake','Floods',
  ];
  String? _languageSelected;
  final List<String> _languages=[
    'Hindi','Bengali','Gujarati','Kannada','Malayalam','Marathi','Tamil','Telugu','Urdu','English',
  ];

  bool _isGeneratingSuggestions = false;
  String? _generatedSuggestions;

  Future<void> _generateSuggestions() async{
    try{
    final disaster=_disasterSelected;
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: GeminiApiKey);
  final content = [Content.text('Give me suggestions in a $disaster situation in 5 short points in $_languageSelected. Explain each point but dont include text formatting, output in plaintext')];
  final response = await model.generateContent(content);
  setState(() {
    _generatedSuggestions = response.text;
    _isGeneratingSuggestions=false;
  });}catch (e){
    _generatedSuggestions='Failed to fetch suggestions';
  }finally{
    setState(() {
      _isGeneratingSuggestions=false;
    });
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[300],
      appBar: PreferredSize(
        preferredSize:const Size.fromHeight(70),
        child: AppBar(
          centerTitle: true,
          title: Text('HelpBot',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.red[800]),),
          backgroundColor: Colors.green[400],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40,),
              SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green,width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ), 
                    color:const Color(0xFFF5F5F5),     
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
                                style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                dropdownColor: Colors.white,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(color: Colors.black),
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
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                                items: _naturalDisasters.map<DropdownMenuItem<String>>((String disaster){
                                  return DropdownMenuItem<String>(
                                    value: disaster,
                                    child: Text(disaster),
                                  );
                                }).toList(),
                              ),
                                const SizedBox(height: 35,),
                                DropdownButtonFormField<String>(
                                value: _languageSelected,
                                style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                dropdownColor: Colors.white,
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(color: Colors.black),
                                  labelText: 'Select a language',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (String? newlanguage){
                                  setState(() {
                                    _languageSelected=newlanguage;
                                  });
                                },
                                validator: (value){
                                  if(value==null){
                                    return 'Please select a language';
                                  }
                                  return null;
                                },
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                                items: _languages.map<DropdownMenuItem<String>>((String language){
                                  return DropdownMenuItem<String>(
                                    value: language,
                                    child: Text(language),
                                  );
                                }).toList(),
                              ),
                                const SizedBox(height: 35,),
                                ElevatedButton(
                                  style:  ButtonStyle(
                                    shadowColor: MaterialStateProperty.all(Colors.green),
                                    elevation: MaterialStateProperty.all(30),
                                  ),
                                  onPressed: (){
                                    if(_formKey.currentState!.validate()){
                                      setState(() {
                                        _isGeneratingSuggestions=true;
                                      });
                                      _generateSuggestions();
                                      
                                    }
                          
                                }, child: const Text('Ask',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                ),
                                
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                                SizedBox(
                                  width: double.infinity,
                                  height: 400,
                                  child:  Card(
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.green,width: 3),
                                      borderRadius: BorderRadius.all(Radius.circular(15))
                                      ), 
                                    color:const Color(0xFFF5F5F5),
                                    child: Padding(
                                      padding:const EdgeInsets.all(10.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.chat,color: Colors.lightBlue,),
                                                const SizedBox(width: 8,),
                                                Text('HelpBot Suggestions',style: TextStyle(color: Colors.blue[300],fontSize: 21,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
                                        
                                              ],
                                            ),
                                            const SizedBox(height: 16,),
                                            _isGeneratingSuggestions? const CircularProgressIndicator(): Text(_generatedSuggestions ?? 'No suggestions generated yet. Tap the SOS once again',style: const TextStyle(color: Colors.black),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
            ],
          ),
        ),
      )
    );
  }
}