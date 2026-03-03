class Weather {
  final String cityName;
  final double temperature;
  final int humidity;
  final String description;
  final double lat;
  final double lon;

  Weather({
      required this.cityName,
  required this.temperature,
    required this.humidity,
     required this.description,
         required this.lat,
     required this.lon,
  });

  // Factory pour créer une instance de Weather à partir d'un JSON
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
       cityName: json['name'] ?? '',
  temperature: (json['main']['temp'] as num).toDouble(),
       humidity: json['main']['humidity'] as int,
           description: json['weather'][0]['description'] ?? '',
      lat: (json['coord']['lat'] as num).toDouble(),
          lon: (json['coord']['lon'] as num).toDouble(),
        );
   }
}
