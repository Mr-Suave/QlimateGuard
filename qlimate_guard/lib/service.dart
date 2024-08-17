import 'dart:convert';

import 'package:flutter/material.dart';
import './model.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
class Service{
  static const base='https://api.openweathermap.org/data/2.5/weather';
  final String apikey;

  Service(this.apikey);

  Future<Weather> getWeather(String cityName) async{

    final response=await http.get(Uri.parse("$base?q=$cityName&units=metric&appid=$apikey"));
    
    if(response.statusCode==200){
      return Weather.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('Error 404');
    }
  }

  Future<String?> getCurrentCity() async{
    try{
      LocationPermission permission=await Geolocator.checkPermission();
      if(permission == LocationPermission.denied){
        permission=await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }
      Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks=await placemarkFromCoordinates(position.latitude,position.longitude);
      if(placemarks.isNotEmpty){
        String? city=placemarks[0].locality;
        print(city);
        return city ?? "";
      }
      else{
        throw Exception('No placemarks found.');
      }
    } catch(e){
      print('Error getting current city: $e');
      return null;
    }
    }
}