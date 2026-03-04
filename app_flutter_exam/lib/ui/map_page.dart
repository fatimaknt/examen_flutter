import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:app_flutter_exam/models/constants.dart';

class MapPage extends StatelessWidget {
  final String cityName;
  final double lat;
  final double lon;
  final int temperature;
  final String description;

  const MapPage({
    Key? key,
    required this.cityName,
    required this.lat,
    required this.lon,
    required this.temperature,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LatLng cityLocation = LatLng(lat, lon);
    final bool isDark = Constants.isDark(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('📍 $cityName'),
        backgroundColor: Constants.primaryColor(context),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // ── Infos rapides ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Constants.primaryColor(context).withOpacity(.15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cityName,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Constants.textColor(context),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$temperature°C — $description',
                  style: TextStyle(
                    color: Constants.textColor(context).withOpacity(.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '📍 Lat: ${lat.toStringAsFixed(4)} | Lon: ${lon.toStringAsFixed(4)}',
                  style: TextStyle(
                    color: Constants.primaryColor(context),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // ── Carte OpenStreetMap ──
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: cityLocation,
                initialZoom: 11,
              ),
              children: [
                // Tuiles OpenStreetMap (gratuit, sans clé API)
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app_flutter_exam',
                ),
                // Marker sur la ville
                MarkerLayer(
                  markers: [
                    Marker(
                      point: cityLocation,
                      width: 80,
                      height: 80,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Constants.primaryColor(context),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '$temperature°C',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.location_on,
                            color: Constants.primaryColor(context),
                            size: 36,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}