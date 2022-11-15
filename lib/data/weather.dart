class Weather {
  String name = '';
  String description = '';
  double temperature = 0;
  double percived = 0;
  int pressure = 0;
  int humidity = 0;

  Weather(this.name, this.description, this.temperature, this.percived,
      this.pressure, this.humidity);

  Weather.fromJson(Map<String, dynamic> weatherMap) {
    name = weatherMap['name'];
    // this.temperature = (weatherMap['main']['temp'] * (9/5) - 459.67) ?? 0;
    temperature = (weatherMap['main']['temp'] - 273.15) ?? 0;
    percived = (weatherMap['main']['feels_like'] - 273.15) ?? 0;
    pressure = weatherMap['main']['pressure'] ?? 0;
    humidity = weatherMap['main']['humidity'] ?? 0;
    description = weatherMap['weather'][0]['main'] ?? '';
  }
}
