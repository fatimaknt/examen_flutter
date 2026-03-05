import 'dart:async';
import 'package:app_flutter_exam/services/weather_service.dart';
import 'package:flutter/foundation.dart';
import '../models/weather_model.dart';


class WeatherController with ChangeNotifier {
  final WeatherService _service = WeatherService();

  // Liste des météos récupérées
  List<Weather> _weathers = [];
  List<Weather> get weathers => _weathers;

  // État de chargement
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Gestion des erreurs
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Progression de la barre de chargement (0.0 à 1.0)
  double _progress = 0.0;
  double get progress => _progress;

  // Liste des villes à récupérer
  final List<String> cityNames = [
    'Dakar',
    'Paris',
    'New York',
    'Tokyo',
    'London',
  ];

  // Message dynamique affiché pendant le chargement
         String _loadingMessage = "Nous téléchargeons les données...";
  String get loadingMessage => _loadingMessage;

  // Logique principale : Récupération séquentielle avec délai
  Future<void> startProgress() async {
    // Réinitialisation des états
    _progress = 0.0;
         _isLoading = true;
    _errorMessage = null;
         _weathers = [];
    _loadingMessage = "Démarrage du téléchargement...";
          notifyListeners();

    try {
      for (int i = 0; i < cityNames.length; i++) {
           String city = cityNames[i];

    // Mise à jour du message
           _updateLoadingMessage(i);
        notifyListeners();

              // Appel API
            final weather = await _service.fetchWeather(city);
          _weathers.add(weather);
 // Mise à jour de la progression
        _progress = (i + 1) / cityNames.length;
        notifyListeners();

        // Pause de 2 secondes entre les appels (sauf pour le dernier)
           if (i < cityNames.length - 1) {
                  await Future.delayed(const Duration(seconds: 2));
           }
      }

      // Fin du chargement
 _isLoading = false;
      _loadingMessage = "Téléchargement terminé !";
         notifyListeners();
    } catch (e) {
      // Gestion de l'erreur
        _errorMessage =
          "Oups ! Une erreur est survenue. Veuillez vérifier votre connexion.";
        _isLoading = false;
    notifyListeners();
      // On rethrow l'erreur pour que l'UI puisse l'afficher si besoin via un SnackBar par ex.
      // rethrow;
    }
  }

  // Met à jour le message de chargement en fonction de l'étape
  void _updateLoadingMessage(int index) {
       if (index == 0) {
            _loadingMessage = "Nous téléchargeons les données...";
    } else if (index == cityNames.length - 1) {
                _loadingMessage = "C'est presque fini...";
        } else {
      _loadingMessage = "Chargement de la météo à ${cityNames[index]}...";
      }
  }

  // Relancer le processus en cas d'erreur
      void retry() {
          startProgress();
   }
}
