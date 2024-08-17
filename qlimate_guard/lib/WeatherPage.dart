import 'package:flutter/material.dart';
import './service.dart';
import './model.dart';
import './Icon.dart';
 class WeatherPage extends StatefulWidget {
   const WeatherPage({super.key});
 
   @override
   State<WeatherPage> createState() => _WeatherPageState();
 }
 
 class _WeatherPageState extends State<WeatherPage> {
   final weatherservice=Service('17744e7776d75be21216cc3b80e28545');
   Weather? _weather;

   fetchWeather(String value) async{
     try{
       String cityName=value;
       final weather = await weatherservice.getWeather(cityName);
       setState(() {
         _weather=weather as Weather?;
       });
     }catch(e){
       print('Error occurred: $e');
     }

 }
    initializeWeather() async{
   final cityname = await weatherservice.getCurrentCity();
   if (cityname != null) {
     fetchWeather(cityname);
   }
 }
   @override
   void initState() {
     super.initState();
     fetchWeather("Renigunta");
    // initializeWeather();
   }
   Widget build(BuildContext context) {
     return Scaffold(
       extendBodyBehindAppBar: true,
       resizeToAvoidBottomInset: false,
       appBar: AppBar(
         backgroundColor: Colors.transparent,
         //elevation: 0,
         title: TextField(
           decoration: InputDecoration(
             hintText: 'Search...',
             hintStyle: TextStyle(color: Colors.white70),
             border: InputBorder.none,
           ),
           style: TextStyle(color: Colors.white, fontSize: 18),
           onSubmitted: (value) {
             fetchWeather((value));
           },
         ),
       ),
       body: Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(
             colors: [Color(0xFF63B8FF), Color(0xFF1E90FF)],
             begin: Alignment.topLeft,
             end: Alignment.topRight,
           ),
         ),
         child:
         _weather == null ? Center(child: CircularProgressIndicator())
         :Column(
           children: [
             Expanded(
               child: Center(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text(
                       _weather!.cityName,
                       style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.white),
                     ),
                     SizedBox(height: 8),
                     Text(
                       '${_weather!.temperature}°C',
                       style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                     ),
                     SizedBox(height: 8),
                     WeatherIconWidget(iconCode: _weather!.icon),
                     SizedBox(height: 8),
                     Text(
                       _weather!.mainCondition,
                       style: TextStyle(fontSize: 24, color: Colors.white),
                     ),
                     SizedBox(height: 8),
                     Text(
                       'lat: ${_weather!.latitude}°',
                       style: TextStyle(fontSize: 18, color: Colors.white),
                     ),
                     Text(
                       'lon: ${_weather!.longitude}°',
                       style: TextStyle(fontSize: 18, color: Colors.white),
                     ),
                   ],
                 ),
               ),
             ),
             Container(
               padding: EdgeInsets.all(40),
               margin: EdgeInsets.only(bottom: 35),
               decoration: BoxDecoration(
                 color: Colors.white.withOpacity(0.8),
                 borderRadius: BorderRadius.circular(10),
               ),
               child: Column(
                 children: [
                   Text(
                     'Pressure: ${_weather!.pressure} hPa',
                     style: TextStyle(fontSize: 18, color: Colors.black),
                   ),
                   SizedBox(height: 8),
                   Text(
                     'Humidity: ${_weather!.humidity}%',
                     style: TextStyle(fontSize: 18, color: Colors.black),
                   ),
                   SizedBox(height: 8),
                   Text(
                     'Max Temp: ${_weather!.temp_max}°C',
                     style: TextStyle(fontSize: 18, color: Colors.black),
                   ),
                   SizedBox(height: 8),
                   Text(
                     'Min Temp: ${_weather!.temp_min}°C',
                     style: TextStyle(fontSize: 18, color: Colors.black),
                   ),
                   SizedBox(height: 8),
                   Text(
                     'Wind Speed: ${_weather!.windspeed} m/s',
                     style: TextStyle(fontSize: 18, color: Colors.black),
                   ),
                 ],
               ),
             ),
           ],
         ),
       ),
     );
   }
 }
 