import 'package:flutter/material.dart';
import 'package:qlimate_guard/splash_screen.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'main.dart';
import 'HomePage.dart';

class Volunteer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home : const Homepage(),
    );
}
}