class City {
  final String city;
  final int woeid;

  City({
    required this.city,
    required this.woeid,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      city: json['title'] ?? '',
      woeid: json['woeid'] ?? 0,
    );
  }

  static List<City> getSelectedCities() {
    return [
      City(city: 'London', woeid: 44418),
      City(city: 'New York', woeid: 2459115),
      City(city: 'Tokyo', woeid: 1118370),
    ];
  }
}
