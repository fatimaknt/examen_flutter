import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_flutter_exam/main.dart';
import 'package:app_flutter_exam/models/weather_model.dart';
import 'package:app_flutter_exam/ui/map_page.dart';
import 'package:app_flutter_exam/widgets/weather_item.dart';
import 'package:app_flutter_exam/models/constants.dart';
import 'package:app_flutter_exam/ui/home.dart';

class DetailPage extends StatefulWidget {
  final List consolidatedWeatherList;
  final int selectedId;
  final String location;
  final Weather weather;

  const DetailPage({
    Key? key,
    required this.consolidatedWeatherList,
    required this.selectedId,
    required this.location,
    required this.weather,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bool isDark = Constants.isDark(context);

    final Color cardBg = isDark ? const Color(0xff16213e) : Colors.white;
    final Color textGrey = isDark ? Colors.white54 : Colors.grey;
    final Color listCardBg = isDark ? const Color(0xff1a1a2e) : Colors.white;

    final Shader linearGradient = const LinearGradient(
      colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    int selectedIndex = widget.selectedId;
    var weatherStateName =
        widget.consolidatedWeatherList[selectedIndex]['weather_state_name'];
    imageUrl = weatherStateName.replaceAll(' ', '').toLowerCase();

    return Scaffold(
      backgroundColor: Constants.secondaryColor(context),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Constants.secondaryColor(context),
        elevation: 0.0,
        title: Text(
          widget.location,
          style: TextStyle(color: Constants.textColor(context)),
        ),
        iconTheme: IconThemeData(color: Constants.textColor(context)),
        actions: [
          IconButton(
            onPressed: () => MyApp.of(context)?.toggleTheme(),
            icon: Icon(
              isDark ? Icons.wb_sunny : Icons.nightlight_round,
              color: Constants.textColor(context),
            ),
          ),
          IconButton(
            onPressed: () {
               Navigator.pushReplacement(context, 
                    MaterialPageRoute(builder: (context) => Home()));
            },
            icon: Icon(Icons.settings, color: Constants.textColor(context)),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // ── Liste horizontale des jours ──
          Positioned(
            top: 10,
            left: 10,
            child: SizedBox(
              height: 150,
              width: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.consolidatedWeatherList.length,
                itemBuilder: (BuildContext context, int index) {
                  var futureWeatherName = widget
                      .consolidatedWeatherList[index]['weather_state_name'];
                  var weatherURL =
                      futureWeatherName.replaceAll(' ', '').toLowerCase();
                  var parsedDate = DateTime.parse(
                      widget.consolidatedWeatherList[index]['applicable_date']);
                  var newDate =
                      DateFormat('EEEE').format(parsedDate).substring(0, 3);

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    margin: const EdgeInsets.only(right: 20),
                    width: 80,
                    decoration: BoxDecoration(
                      color: index == selectedIndex
                          ? cardBg
                          : const Color(0xff9ebcf9),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 1),
                          blurRadius: 5,
                          color: Colors.blue.withOpacity(.3),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.consolidatedWeatherList[index]['the_temp']
                                  .round()
                                  .toString() +
                              "C",
                          style: TextStyle(
                            fontSize: 17,
                            color: index == selectedIndex
                                ? Constants.primaryColor(context)
                                : Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Image.asset('assets/$weatherURL.png', width: 40),
                        Text(
                          newDate,
                          style: TextStyle(
                            fontSize: 17,
                            color: index == selectedIndex
                                ? Constants.primaryColor(context)
                                : Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // ── Panel bas ──
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * .55,
              width: size.width,
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // ── Carte météo principale ──
                  Positioned(
                    top: -50,
                    right: 20,
                    left: 20,
                    child: Container(
                      width: size.width * .7,
                      height: 300,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.center,
                          colors: [Color(0xffa9c1f5), Color(0xff6696f5)],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(.1),
                            offset: const Offset(0, 25),
                            blurRadius: 3,
                            spreadRadius: -10,
                          ),
                        ],
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -40,
                            left: 20,
                            child: Image.asset(
                              'assets/$imageUrl.png',
                              width: 150,
                            ),
                          ),
                          Positioned(
                            top: 120,
                            left: 30,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                weatherStateName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          // ── Température ──
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.consolidatedWeatherList[selectedIndex]
                                          ['the_temp']
                                      .round()
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()..shader = linearGradient,
                                  ),
                                ),
                                Text(
                                  'o',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()..shader = linearGradient,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // ── Weather items ──
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              width: size.width * .8,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherItem(
                                    text: 'Wind Speed',
                                    value: widget
                                        .consolidatedWeatherList[selectedIndex]
                                            ['wind_speed']
                                        .round(),
                                    unit: 'km/h',
                                    imageUrl: 'assets/windspeed.png',
                                  ),
                                  WeatherItem(
                                    text: 'Humidity',
                                    value: widget.consolidatedWeatherList[
                                            selectedIndex]['humidity']
                                        .round(),
                                    unit: '',
                                    imageUrl: 'assets/humidity.png',
                                  ),
                                  WeatherItem(
                                    text: 'Max Temp',
                                    value: widget
                                        .consolidatedWeatherList[selectedIndex]
                                            ['max_temp']
                                        .round(),
                                    unit: 'C',
                                    imageUrl: 'assets/max-temp.png',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── Coordonnées GPS 
                  Positioned(
                    top: 265,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Constants.primaryColor(context).withOpacity(.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: 16,
                                  color: Constants.primaryColor(context)),
                              const SizedBox(width: 4),
                              Text(
                                // ✅ corrigé
                                'Lat: ${widget.weather.lat.toStringAsFixed(3)}',
                                style: TextStyle(
                                  color: Constants.textColor(context),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: 16,
                                  color: Constants.primaryColor(context)),
                              const SizedBox(width: 4),
                              Text(
                                // ✅ corrigé
                                'Lon: ${widget.weather.lon.toStringAsFixed(3)}',
                                style: TextStyle(
                                  color: Constants.textColor(context),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── Liste verticale + bouton Maps ──
                  Positioned(
                    top: 310,
                    left: 20,
                    child: SizedBox(
                      height: size.height * .55 - 330,
                      width: size.width * .9,
                      child: Column(
                        children: [
                          // Bouton Google Maps
                          SizedBox(
                            width: double.infinity,
                            height: 44,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapPage(
                                      cityName: widget.location,
                                      lat: widget.weather.lat,
                                      lon: widget.weather.lon,
                                      temperature: widget
                                          .consolidatedWeatherList[
                                              selectedIndex]['the_temp']
                                          .round(),
                                      description: weatherStateName,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.map,
                                  color: Colors.white, size: 18),
                              label: const Text(
                                'Voir sur Google Maps',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Constants.primaryColor(context),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Liste des jours 
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: widget.consolidatedWeatherList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var futureWeatherName =
                                    widget.consolidatedWeatherList[index]
                                        ['weather_state_name'];
                                var futureImageURL = futureWeatherName
                                    .replaceAll(' ', '')
                                    .toLowerCase();
                                var myDate = DateTime.parse(
                                    widget.consolidatedWeatherList[index]
                                        ['applicable_date']);
                                var currentDate =
                                    DateFormat('d MMMM, EEEE').format(myDate);

                                return Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, top: 10, right: 10, bottom: 5),
                                  height: 80,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    color: listCardBg,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Constants.secondaryColor(context)
                                            .withOpacity(.1),
                                        spreadRadius: 5,
                                        blurRadius: 20,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          currentDate,
                                          style: TextStyle(
                                            color: Constants.primaryColor(
                                                context),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              widget
                                                  .consolidatedWeatherList[
                                                      index]['max_temp']
                                                  .round()
                                                  .toString(),
                                              style: TextStyle(
                                                color: textGrey,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              '/',
                                              style: TextStyle(
                                                color: textGrey,
                                                fontSize: 30,
                                              ),
                                            ),
                                            Text(
                                              widget
                                                  .consolidatedWeatherList[
                                                      index]['min_temp']
                                                  .round()
                                                  .toString(),
                                              style: TextStyle(
                                                color: textGrey,
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/$futureImageURL.png',
                                              width: 30,
                                            ),
                                            Text(
                                              widget.consolidatedWeatherList[
                                                  index]['weather_state_name'],
                                              style: TextStyle(
                                                color: Constants.textColor(
                                                    context),
                                                fontSize: 12,
                                              ),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}