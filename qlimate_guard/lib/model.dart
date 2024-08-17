class Weather {
  final String cityName;
  final String icon;
  final double temperature;
  final String mainCondition;
  final double longitude;
  final double latitude;
  final double pressure;
  final double humidity;
  final double temp_max;
  final double temp_min;
  final double windspeed;



  Weather({
    required this.cityName,
    required this.icon,
    required this.temperature,
    required this.mainCondition,
    required this.latitude,
    required this.longitude,
    required this.pressure,
    required this.humidity,
    required this.temp_max,
    required this.temp_min,
    required this.windspeed,
  });

    factory Weather.fromJson(Map<String, dynamic> json) {
      return Weather(
        cityName: json['name'],
        icon: json['weather'][0]['icon'],
        temperature: (json['main']['temp']).toDouble(),
        mainCondition: json['weather'][0]['description'],
        longitude: json['coord']['lon'],
        latitude: json['coord']['lat'],
        pressure: (json['main']['pressure']).toDouble(),
        humidity: (json['main']['humidity']).toDouble(),
        temp_max: (json['main']['temp_max']).toDouble(),
        temp_min: (json['main']['temp_min']).toDouble(),
        windspeed: (json['wind']['speed']).toDouble(),
      );
    }
}