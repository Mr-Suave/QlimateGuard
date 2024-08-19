import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qlimate_guard/main.dart';

import './air_quality.dart';
import 'painter.dart';

class HomeScreen extends StatelessWidget {
  final AirQuality airQuality;
  const HomeScreen(this.airQuality, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: false,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/back.png'))),
                ),
            
                Padding(
                  padding: const EdgeInsets.only(top: kToolbarHeight * 3),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          CustomPaint(
                            size: Size(400,200),
                            painter: AirQualityPainter(airQuality.aqi),
                          ),

                          Column(
                            children: [
                              SizedBox(
                                width: 400,
                                height: MediaQuery.of(context).size.height * 0.5,
                                child: Column(
                                  children: [
                                    // SizedBox(
                                    //   height: 30,
                                    // ),
                                    Center(
                                      child: Text(
                                        "Location: ",
                                        style: TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 45,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                     Center(
                                      child: Text(
                                        airQuality.cityName,
                                        style: TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    Text(
                                      "AQI: " + airQuality.aqi.toString(),
                                      style: TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    
                                    Container(
                                      width: 400,
                                      height: MediaQuery.of(context).size.width*0.287,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                    
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SingleChildScrollView(
                                            child: Text(
                                              airQuality.message!,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  //height: 1.5,
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(onPressed: (){
                                      Navigator.push(context, 
                                      MaterialPageRoute(builder: (context) => MyApp()));
                                    }, child: Text(
                                      "Back"
                                    ))
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
