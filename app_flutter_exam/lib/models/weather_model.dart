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

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? '',
      temperature: (json['main']['temp'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      description: _mapDescription(json['weather'][0]['main'] ?? ''),
      lat: (json['coord']['lat'] as num).toDouble(),
      lon: (json['coord']['lon'] as num).toDouble(),
    );
  }

  static String _mapDescription(String main) {
    switch (main.toLowerCase()) {
      case 'clear': return 'clear';
      case 'clouds': return 'lightcloud';
      case 'rain': return 'lightrain';
      case 'drizzle': return 'lightrain';
      case 'thunderstorm': return 'thunderstorm';
      case 'snow': return 'snow';
      case 'mist':
      case 'fog':
      case 'haze': return 'heavycloud';
      default: return 'heavycloud';
    }
  }
}