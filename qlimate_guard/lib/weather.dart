import 'package:flutter/material.dart';
import 'package:qlimate_guard/splash_screen.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'main.dart';
import 'dart:convert';
import './WeatherPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class FourthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:WeatherPage(),
    );
  }
}