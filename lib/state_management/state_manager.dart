import 'package:country_state_city/country_state_city.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weathercommuteapplication/apis/api_service.dart';
import 'package:weathercommuteapplication/model/wetherDetails.dart';

import '../model/weatherCondition.dart';
class StateManager with ChangeNotifier{

ApiService service = ApiService();
late var  countriesList = [];
 late var  statesList = [];
late var  citiesList = [];

var finalSearch ="";

WeatherDetails details = WeatherDetails();

WeatherDetails selectedWeather = WeatherDetails();


bool hasState = true;
bool hasCity = true;
bool weatherReturned = false;
 Map<String,dynamic> currentWeather= {};

 late String countryDropdownValue = "" ;
 String stateDropdownValue = "" ;
 String cityDropdownValue = "" ;

 String countryCode = "";
 String stateCode = "";
 String countryFlag = "";
 List<WeatherCondition> weatherCondition = [];


  void createWeatherConditions(){
    WeatherCondition clear = WeatherCondition(
        "Clear",
        "Clear weather typically means a cloudless sky with no significant cloud cover. The sun is shining brightly, and visibility is excellent.",
        "Enjoy outdoor activities, and consider using convertibles or motorcycles.",
        ["Convertible", "Motorcycle"],
        ["sunny_clear1.jpeg", "sunny_clear2.jpeg", "sunny_clear3.jpeg"]
    );
    weatherCondition.add(clear);

    WeatherCondition sunny = WeatherCondition(
        "Sunny",
        "Similar to clear weather, sunny days feature a bright and shining sun, creating a warm and pleasant atmosphere.",
        "Enjoy outdoor activities, and consider using convertibles or motorcycles.",
        ["Convertible"," Motorcycle",],
        ["sunny1.jpeg", "sunny2.jpg", "sunny3.jpeg"]
    );

    weatherCondition.add(sunny);

    WeatherCondition partlyCloudy = WeatherCondition(
        "Partly Cloudy",
        "Partly cloudy conditions have a mix of both clouds and clear sky. The sun is still visible, but there is some cloud cover.",
        "No specific precautions needed. Enjoy outdoor activities.",
        ["Standard Vehicle",],
        ["partly_couldy1.jpeg", "partly_couldy2.jpeg", "partly_couldy3.jpeg"]
    );

    weatherCondition.add(partlyCloudy);
    WeatherCondition mostlyCloudy = WeatherCondition(
        "Mostly Cloudy",
        "Mostly cloudy days have a significant amount of cloud cover, with limited sunlight. It may feel cooler compared to clear or sunny days.",
        "No specific precautions needed. Standard vehicles are suitable.",
        ["Standard Vehicle",],
        ["mostly_cloudy1.jpeg", "mostly_cloudy2.jpeg", "mostly_cloudy3.jpeg"]
    );

    weatherCondition.add(partlyCloudy);
    WeatherCondition overcast = WeatherCondition(
        "Overcast",
        "Overcast conditions occur when the sky is completely covered by clouds, often resulting in a darker and gloomier atmosphere. There might be a chance of rain.",
        "Be prepared for potential rain. Standard vehicles are suitable.",
        ["Standard Vehicle",],
        ["overcast1.jpeg", "overcast2.jpeg", "overcast3.jpeg"]
    );
    weatherCondition.add(overcast);
    WeatherCondition foggy = WeatherCondition(
        "Foggy",
        "Foggy conditions occur when there is a thick layer of fog, reducing visibility significantly.",
        "Drive with caution, use headlights, and consider vehicles with advanced visibility features.",
        ["Vehicle with Advanced Visibility Features"],
        ["foggy1.jpeg", "foggy2.jpeg", "foggy23jpeg.JPG"]
    );
    weatherCondition.add(foggy);

    WeatherCondition misty = WeatherCondition(
        "Misty",
        "Misty conditions involve fine water droplets in the air, creating a hazy atmosphere with reduced visibility.",
        "Drive carefully with headlights on. Use vehicles with good visibility features.",
        ["Standard Vehicle"],
        ["misty1.jpeg", "misty2.jpeg"]
    );
    weatherCondition.add(misty);

    WeatherCondition rain = WeatherCondition(
        "Rain",
        "Rainy conditions involve steady and continuous precipitation, creating wet road surfaces.",
        "Drive with caution, use windshield wipers, and consider vehicles with good traction.",
        ["Vehicle with Good Traction"],
        ["rainy1.jpg", "rainy2.jpg", "rainy3.jpg"]
    );
    weatherCondition.add(rain);
    WeatherCondition drizzle = WeatherCondition(
        "Drizzle",
        "Drizzle is light rain characterized by fine droplets falling from the sky.",
        "Drive carefully with headlights on. Use vehicles with good visibility features.",
       ["Standard Vehicle"],
        ["drizzle.jpg", "drizzle2.jpg", "drizzle3.jpg"]
    );
    weatherCondition.add(drizzle);

    WeatherCondition showers = WeatherCondition(
        "Showers",
        "Showers refer to short periods of heavier rainfall than drizzle.",
        "Drive with caution, use windshield wipers, and consider vehicles with good traction.",
        ["Vehicle with Good Traction"],
        ["showers1.jpeg", "showers2.jpeg", "showers3.jpg"]
    );
    weatherCondition.add(showers);
    WeatherCondition thunderstorm = WeatherCondition(
        "Thunderstorm",
        "Thunderstorms involve heavy rain, thunder, lightning, and strong winds.",
        "Avoid driving if possible. If necessary, use a sturdy and well-equipped vehicle.",
        ["Sturdy Vehicle"],
        ["thunder_storm1.jpeg", "thunder_storm2.jpeg", "thunder_storm3.jpeg"]
    );

    weatherCondition.add(thunderstorm);
    WeatherCondition snow = WeatherCondition(
        "Snow",
        "Snowfall involves the accumulation of snow on the ground, creating slippery and potentially hazardous road conditions.",
        "Use vehicles with winter tires, all-wheel drive, or four-wheel drive.",
        ["Winter Vehicle"],
        ["snow1.jpeg", "snow2.webp", "snow3.jpg"]
    );
    weatherCondition.add(snow);
    WeatherCondition blizzard = WeatherCondition(
        "Blizzard",
        "A blizzard is a severe snowstorm characterized by strong winds, low visibility, and heavy snowfall.",
        "Avoid driving in blizzard conditions. If necessary, use a well-equipped vehicle.",
       [ "Well-Equipped Vehicle"],
        ["blizzard1.jpeg", "blizzard2.jpg"]
    );
    weatherCondition.add(blizzard);
    WeatherCondition hail = WeatherCondition(
        "Hail",
        "Hailstorms involve the falling of hailstones, which can cause damage to vehicles.",
        "It's advisable to seek shelter during hailstorms and avoid driving.",
        ["No Driving during Hailstorm",],
        ["hail1.jpeg", "hail2.jpeg", "hail3.jpeg"]
    );
    weatherCondition.add(hail);
    WeatherCondition sleet = WeatherCondition(
        "Sleet",
        "Sleet is a mix of rain and snow, creating icy conditions on surfaces.",
        "Vehicles with good traction, winter tires, and anti-lock braking systems are suitable.",
        ["Vehicle with Good Traction"],
        ["sleet1.jpeg", "sleet2.jpeg", "sleet3.jpeg"]
    );
    weatherCondition.add(sleet);
    WeatherCondition freezingRain = WeatherCondition(
        "Freezing Rain",
        "Freezing rain occurs when rain falls and freezes upon contact with cold surfaces, creating icy conditions.",
        "Avoid driving in freezing rain if possible. If necessary, use a vehicle with good traction and anti-lock brakes.",
        ["Vehicle with Good Traction"],
        ["f_rain.jpg", "f_rain2.jpg", "f_rain3.jpg"]
    );
    weatherCondition.add(freezingRain);
    WeatherCondition tornado = WeatherCondition(
        "Tornado",
        "Tornadoes are violent windstorms characterized by a twisting, funnel-shaped cloud. They can cause significant damage.",
        "It's highly advisable to seek shelter during a tornado. No vehicle is suitable for driving in tornado conditions.",
        ["No Driving during Tornado"],
        ["tornado.jpeg", "tornado2.jpeg","tornado3.jpeg",]
    );
    weatherCondition.add(tornado);
    WeatherCondition hurricane = WeatherCondition(
        "Hurricane",
        "Hurricanes are powerful tropical storms with strong winds and heavy rain, often accompanied by storm surges.",
        "It's not advisable to drive during a hurricane. Evacuation plans typically involve public transportation or designated emergency vehicles.",
        ["No Driving during Hurricane"],
        ["hurricane1.jpeg", "hurricane2.jpeg", "hurricane3.jpeg"]
    );
    weatherCondition.add(hurricane);
    WeatherCondition typhoon = WeatherCondition(
        "Typhoon",
        "Typhoons are the same as hurricanes but occur in the Northwest Pacific Ocean.",
        "Similar to hurricanes, it's not advisable to drive during a typhoon. Evacuation plans typically involve public transportation or designated emergency vehicles.",
        ["No Driving during Typhoon"],
        ["hurricane1.jpeg", "hurricane2.jpeg", "hurricane3.jpeg"]
    );
    weatherCondition.add(typhoon);
    WeatherCondition cyclone = WeatherCondition(
        "Cyclone",
        "Cyclones are the same as hurricanes but occur in the South Pacific and Indian Ocean.",
        "Similar to hurricanes and typhoons, it's not advisable to drive during a cyclone. Evacuation plans typically involve public transportation or designated emergency vehicles.",
        ["No Driving during Cyclone"],
        ["hurricane1.jpeg", "hurricane2.jpeg", "hurricane3.jpeg"]
    );
    weatherCondition.add(cyclone);
    WeatherCondition dustStorm = WeatherCondition(
        "Dust Storm",
        "Dust storms involve strong winds blowing loose soil and dust particles, reducing visibility.",
        "It's not advisable to drive in a dust storm. If caught in one, pull off the road safely and wait until visibility improves.",
       [ "No Driving during Dust Storm"],
        ["dust_storm1.jpeg", "dust_storm2.jpeg", "dust_storm3.jpeg"]
    );
    weatherCondition.add(dustStorm);
    WeatherCondition sandstorm = WeatherCondition(
        "Sandstorm",
        "Sandstorms involve strong winds blowing loose sand particles, reducing visibility.",
        "It's not advisable to drive in a sandstorm. If caught in one, pull off the road safely and wait until visibility improves.",
        ["No Driving during Sandstorm"],
        ["sand_storm1.jpeg", "sand_storm2.jpeg"]
    );
    weatherCondition.add(sandstorm);

    WeatherCondition lightning = WeatherCondition(
        "Lightning",
        "Lightning is associated with thunderstorms, featuring electrical discharges in the atmosphere.",
        "Avoid driving during lightning storms. Seek shelter.",
        ["No Driving during Lightning Storm"],
        ["lightning1.jpeg", "lightning2.jpeg","lightning3.jpeg"]
    );
    weatherCondition.add(lightning);
    WeatherCondition heatwave = WeatherCondition(
        "Heatwave",
        "A heatwave involves an extended period of excessively hot weather.",
        "Use a vehicle with a functional air conditioning system. Stay hydrated and avoid strenuous activities during peak heat.",
        ["Vehicle with Functional Air Conditioning"],
        ["heatwave1.jpeg", "heatwave2.jpeg", "heatwave3.jpeg"]
    );
    weatherCondition.add(heatwave);
    WeatherCondition coldwave = WeatherCondition(
        "Coldwave",
        "A coldwave is an extended period of extremely cold weather.",
        "Use any standard vehicle. Dress warmly and be prepared for icy conditions on the road.",
        ["Any Standard Vehicle"],
        ["coldwave1.jpeg", "coldwave2.jpeg", "coldwave3.jpeg"]
    );
    weatherCondition.add(coldwave);
    WeatherCondition tsunami = WeatherCondition(
        "Tsunami",
        "Tsunamis are large ocean waves typically caused by undersea earthquakes or volcanic eruptions.",
        "Follow evacuation plans, do not drive, and seek higher ground on foot.",
        ["No Driving during Tsunami"],
        ["tsunami1.jpeg", "tsunami2.jpg", "tsunami3.jpg"]
    );
    weatherCondition.add(tsunami);
    WeatherCondition aurora = WeatherCondition(
        "Aurora",
        "An aurora is a natural light display in the sky, often seen in polar regions.",
        "Enjoy the natural spectacle. Any vehicle is suitable for observing auroras.",
        ["Any Vehicle"],
        ["aurora1.jpeg"]
    );
    weatherCondition.add(aurora);
    WeatherCondition rainbow = WeatherCondition(
        "Rainbow",
        "Rainbows occur when light is refracted, dispersed, and reflected in water droplets, creating a spectrum of colors in the sky.",
        "Enjoy the beautiful phenomenon. Any vehicle is suitable.",
        ["Any Vehicle"],
        ["rainbow1.jpeg"]
    );
    weatherCondition.add(rainbow);
    WeatherCondition solarEclipse = WeatherCondition(
        "Solar Eclipse",
        "A solar eclipse occurs when the moon passes between the sun and Earth, blocking all or part of the sun's light.",
        "Enjoy the astronomical event safely. Follow safety guidelines for eye protection.",
        ["Any Vehicle"],
        ["solar1.jpeg"]
    );
    weatherCondition.add(solarEclipse);
    WeatherCondition lunarEclipse = WeatherCondition(
        "Lunar Eclipse",
        "A lunar eclipse occurs when the Earth passes between the sun and the moon, causing the Earth's shadow to cover the moon.",
        "Enjoy the astronomical event safely. Any vehicle is suitable for observing lunar eclipses.",
        ["Any Vehicle"],
        ["lunar1.jpeg"]
    );
    weatherCondition.add(lunarEclipse);
    WeatherCondition calm = WeatherCondition(
        "Calm",
        "Calm weather indicates low wind speeds and generally mild conditions.",
        "Any standard vehicle is suitable for driving in calm weather.",
        ["Any Standard Vehicle"],
        ["calm.jpeg"]
    );
    weatherCondition.add(calm);
    WeatherCondition breezy = WeatherCondition(
        "Breezy",
        "Breezy conditions involve moderate winds that are noticeable but not extreme.",
        "Any standard vehicle is suitable for driving in breezy conditions.",
        ["Any Standard Vehicle"],
        ["breezy.jpeg"]
    );
    weatherCondition.add(breezy);
    WeatherCondition flood = WeatherCondition(
        "Flood",
        "Flooding occurs when water exceeds normal levels and covers land areas.",
        "Avoid driving in flooded areas. Seek higher ground and follow emergency plans.",
        ["No Driving during Flood"],
        ["flood1.jpeg", "flood2.jpeg", "flood3.jpeg"]
    );
    weatherCondition.add(flood);

    notifyListeners();
    }
  void getCountries()async{
    final countries = await getAllCountries();
    countries.removeWhere((element) => element.name == "Antarctica");
    countriesList = countries;
    countryDropdownValue = countriesList[0].name;
    countryFlag = countriesList[0].flag;
    countryCode = countriesList[0].isoCode;
    getStatesByCountry(countryCode);
    notifyListeners();
  }

  getStatesByCountry(String country)async{
   final states = await getStatesOfCountry(country);

   if (states.isEmpty){
     hasState = false;
     hasCity = false;
     notifyListeners();

     return statesList;
   }
   else {
     hasState = true;
     statesList = states;
     stateDropdownValue = statesList[0].name;
     stateCode =states[0].isoCode;
     await getCitiesByState(country, stateCode);
   }
   notifyListeners();
 }

 getCitiesByState(String countryCode, String stateCode)async{
   final cities = await getStateCities(countryCode, stateCode);
   if (cities.isEmpty){
     hasCity = false;
     return citiesList;
   }
   else {
     hasCity= true;
     citiesList = cities;
     cityDropdownValue = cities[0].name;
   }
    notifyListeners();
 }

  StateManager(){
      getCountries();
      createWeatherConditions();
  }

  void changeCountry(String value){
    countryDropdownValue = value;
    notifyListeners();
  }

 void changeState(String value){
   stateDropdownValue = value;
   notifyListeners();
 }

 void changeCity(String value){
   cityDropdownValue = value;
   notifyListeners();
 }

 void changeSelectedWeather(WeatherDetails details){
    selectedWeather = details;
    notifyListeners();
 }
 void getCountryWeather() async{
    finalSearch = hasCity ? cityDropdownValue :hasState? stateDropdownValue:countryDropdownValue;
  Map<String, dynamic> response =hasCity? await service.getCountryWeather(finalSearch):

  hasState?await service.getCountryWeather(finalSearch):await service.getCountryWeather(finalSearch);

    if(response == {}){
      print("try again");
    }
    else{
      weatherReturned=true;
      details = WeatherDetails.fromJson(response);
    }
    notifyListeners();

 }
void searchNextWeather()async {
  DateTime currentDate = DateTime.now();
  for (int i = 14; i <= 24; i++) {
    DateTime nextDate = currentDate.add(Duration(days: i));
    await service.getFutureCountryWeather(finalSearch, nextDate);
  }
}

String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}
String formatStringDate(String date) {
  date = date.replaceAllMapped(
      RegExp(r'(\d{4}-\d{2}-\d{2} )(\d:\d{2})'), (match) {
    return '${match.group(1)}0${match.group(2)}';
  });

  return DateFormat("EEE, MMM d, yyyy").format(DateTime.parse(date));
}

String formatTime(String time){
  time = time.replaceAllMapped(
      RegExp(r'(\d{4}-\d{2}-\d{2} )(\d:\d{2})'), (match) {
    return '${match.group(1)}0${match.group(2)}';
  });
  return DateFormat("h:mm a").format(DateTime.parse(time));

}

}