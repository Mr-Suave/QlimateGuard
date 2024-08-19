import 'package:flutter/material.dart';
import 'package:qlimate_guard/splash_screen.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'main.dart';
import 'package:flutter/material.dart';

import './fetch_data.dart';
import 'home_screen.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: fetchData(),
          builder: (context, snap) {
            if (snap.hasData) {
              return HomeScreen(snap.data!!);
            } else {
              return const Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              );
            }
          }),
    );
  }
}