import 'package:flutter/material.dart';
import 'package:qlimate_guard/splash_screen.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'main.dart';

// Example screens
class FirstScreen extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Screen')),
      body: const Center(child: Text('This is the first screen'))
      ,
    );
  }
}