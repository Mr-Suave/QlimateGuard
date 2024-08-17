import 'package:flutter/material.dart';

class WeatherIconWidget extends StatelessWidget {
  final String iconCode;

  WeatherIconWidget({required this.iconCode});

  @override
  Widget build(BuildContext context) {
    final iconUrl = 'http://openweathermap.org/img/wn/$iconCode@2x.png';

    return Image.network(
      iconUrl,
      width: 100,
      height: 100,
    );
  }
}