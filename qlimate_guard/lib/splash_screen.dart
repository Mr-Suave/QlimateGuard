import 'package:flutter/material.dart';
import 'package:qlimate_guard/main.dart';
class SplaschScreen extends StatefulWidget {
  const SplaschScreen({super.key});

  @override
  State<SplaschScreen> createState() => _SplaschScreenState();
  
}
 

class _SplaschScreenState extends State<SplaschScreen> {
  @override
      void initState() {
        super.initState();
        Future.delayed(
          const Duration(seconds: 2),
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          },
        );
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/logo.png'),)
    );
  }
}
