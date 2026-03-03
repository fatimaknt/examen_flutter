import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

// Service responsable des appels API vers OpenWeather
class WeatherService {
  // Clé API OpenWeatherMap
  final String apiKey = 'e3cc1d773c52402179929280d9b16524';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  // Récupère la météo pour une ville donnée
  Future<Weather> fetchWeather(String city) async {
    try {
            final url = Uri.parse(
        '$baseUrl?q=$city&appid=$apiKey&units=metric&lang=fr',
        );
            final response = await http.get(url);

      if (response.statusCode == 200) {
             return Weather.fromJson(json.decode(response.body));
      } else {
          throw Exception(
          'Impossible de charger les données pour $city (Code: ${response.statusCode})',
         );
        }
    } catch (e) {
          throw Exception('Erreur réseau : $e');
       }
    }
}
