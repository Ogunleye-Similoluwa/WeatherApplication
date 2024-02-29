class WeatherDetails {
  String? city;
  String? region;
  String? country;
  double? lat;
  double? lon;
  String? localTime;
  String? temperature;
  bool? isDay;
  String? conditionText;
  String? image;
  String? windMph;
  String? windKph;
  String? windDegree;
  String? pressureIn;
  String? pressureMb;
  String? precipMm;
  String? precipIn;
  String? humidity;
  String? cloud;
  String? gustMph;
  String? gustKph;

  WeatherDetails({
    this.city,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.localTime,
    this.temperature,
    this.isDay,
    this.conditionText,
    this.image,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.pressureIn,
    this.pressureMb,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.gustMph,
    this.gustKph,
  });

  factory WeatherDetails.fromJson(Map<String, dynamic> json) {
    return WeatherDetails(
      city: json['location']['name'],
      region: json['location']['region'],
      country: json['location']['country'],
      lat: json['location']['lat'],
      lon: json['location']['lon'],
      localTime: json['current']['last_updated'],
      temperature: json['current']['temp_c'].toString(),
      isDay: json['current']['is_day'] == 1,
      conditionText: json['current']['condition']['text'],
      image: json['current']['condition']['icon'],
      windMph: json['current']['wind_mph'].toString(),
      windKph: json['current']['wind_kph'].toString(),
      windDegree: json['current']['wind_degree'].toString(),
      pressureIn: json['current']['pressure_in'].toString(),
      pressureMb: json['current']['pressure_mb'].toString(),
      precipMm: json['current']['precip_mm'].toString(),
      precipIn: json['current']['precip_in'].toString(),
      humidity: json['current']['humidity'].toString(),
      cloud: json['current']['cloud'].toString(),
      gustMph: json['current']['gust_mph'].toString(),
      gustKph: json['current']['gust_kph'].toString(),
    );
  }
}


