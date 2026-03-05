class City{
  bool isSelected;
  final String city;
  final String country;
  final bool isDefault;

  City({required this.isSelected, required this.city, required this.country, required this.isDefault});

  //List of Cities data
  static List<City> citiesList = [
  City(
   isSelected: true,
   city: 'Dakar',
   country: 'Senegal',
   isDefault: true),

 City(
  isSelected: true,
  city: 'Paris',
  country: 'France',
  isDefault: false),

 City(
  isSelected: true,
  city: 'New York',
  country: 'USA',
  isDefault: false),

 City(
  isSelected: true,
  city: 'Tokyo',
  country: 'Japan',
  isDefault: false),

 City(
  isSelected: true,
  city: 'Dubai',
  country: 'UAE',
  isDefault: false),
  ];

  //Get the selected cities
  static List<City> getSelectedCities(){
    List<City> selectedCities = City.citiesList;
    return selectedCities
        .where((city) => city.isSelected == true)
        .toList();
  }
}






















