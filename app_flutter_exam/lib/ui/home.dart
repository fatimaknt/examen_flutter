import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_flutter_exam/services/weather_controller.dart';
import 'package:app_flutter_exam/models/weather_model.dart';
import 'package:app_flutter_exam/ui/detail_page.dart';
import 'package:app_flutter_exam/models/constants.dart';
import 'package:app_flutter_exam/main.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherController()..startProgress(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeatherController>();
    final bool isDark = Constants.isDark(context);
    final Color scaffoldBg = isDark ? const Color(0xff1a1a2e) : Colors.white;
    final Color cardBg = isDark ? const Color(0xff16213e) : Colors.white;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: scaffoldBg,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.asset('assets/profile.png', width: 40, height: 40),
            ),
            Row(
              children: [
                Icon(Icons.location_on,
                    color: Constants.primaryColor(context), size: 20),
                Text(
                  'Météo Monde',
                  style: TextStyle(
                    color: Constants.textColor(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isDark ? Icons.wb_sunny : Icons.nightlight_round,
                    color: Constants.textColor(context),
                  ),
                  onPressed: () => MyApp.of(context)?.toggleTheme(),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //Jauge de progression 
            if (controller.isLoading || controller.progress < 1.0) ...[
              Text(
                controller.loadingMessage,
                style: TextStyle(
                  color: Constants.textColor(context),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: controller.progress,
                  minHeight: 14,
                  backgroundColor: Constants.secondaryColor(context),
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Constants.primaryColor(context)),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${(controller.progress * 100).round()}%',
                style: TextStyle(
                  color: Constants.primaryColor(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],

            // Erreur + Réessayer 
            if (controller.errorMessage != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        controller.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => controller.retry(),
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text('Réessayer',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.primaryColor(context),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 20),

            //  Tableau météo (après chargement)
            if (!controller.isLoading &&
                controller.errorMessage == null &&
                controller.weathers.isNotEmpty) ...[

              // Bouton Recommencer
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => controller.startProgress(),
                  icon: Icon(Icons.refresh,
                      color: Constants.primaryColor(context)),
                  label: Text(
                    'Recommencer',
                    style:
                        TextStyle(color: Constants.primaryColor(context)),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Liste des villes 
              Expanded(
                child: ListView.builder(
                  itemCount: controller.weathers.length,
                  itemBuilder: (context, index) {
                    final Weather w = controller.weathers[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigation vers la DetailPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              consolidatedWeatherList:
                                  controller.weathers
                                      .map((w) => {
                                            'the_temp': w.temperature,
                                            'max_temp': w.temperature + 2,
                                            'min_temp': w.temperature - 2,
                                            'humidity': w.humidity,
                                            'wind_speed': 0,
                                            'weather_state_name':
                                                w.description,
                                            'weather_icon': '',
                                            'applicable_date': DateTime.now()
                                                .toString()
                                                .substring(0, 10),
                                          })
                                      .toList(),
                              selectedId: index,
                              location: w.cityName,
                              weather: w, 
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Constants.primaryColor(context)
                                  .withOpacity(.15),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            // Ville + description
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  w.cityName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Constants.textColor(context),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  w.description,
                                  style: TextStyle(
                                    color: Constants.textColor(context)
                                        .withOpacity(.6),
                                  ),
                                ),
                              ],
                            ),
                            // Température + humidité
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${w.temperature.round()}°C',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Constants.primaryColor(context),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.water_drop,
                                        size: 14,
                                        color: Colors.blue.withOpacity(.7)),
                                    Text(
                                      '${w.humidity}%',
                                      style: TextStyle(
                                        color: Constants.textColor(context)
                                            .withOpacity(.6),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}