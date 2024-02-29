import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weathercommuteapplication/model/weatherCondition.dart';

import '../model/wetherDetails.dart';
import '../state_management/state_manager.dart';

class WeatherDetailsScreen extends StatefulWidget {
  @override
  State<WeatherDetailsScreen> createState() => _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    WeatherDetails weatherDetails = context.read<StateManager>().details;

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWeatherInfo(weatherDetails),
            SizedBox(height: 16.0),
            _buildWeatherConditionInfo(weatherDetails),
            SizedBox(height: 16.0),
            _buildVehicleInfo(weatherDetails),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(WeatherDetails weatherDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location: ${weatherDetails.city}, ${weatherDetails.region}, ${weatherDetails.country}',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text('Local Time: ${weatherDetails.localTime}'),
        Text('Temperature: ${weatherDetails.temperature}'),
        Text('Is Day: ${weatherDetails.isDay ?? false}'),
      ],
    );
  }

  Widget _buildWeatherConditionInfo(WeatherDetails weatherDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weather Condition: ${weatherDetails.conditionText}',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Image.network("https:${weatherDetails.image}" ?? ''),
        SizedBox(height: 8.0),
        Text('Wind: ${weatherDetails.windMph} mph / ${weatherDetails.windKph} kph'),
        Text('Wind Degree: ${weatherDetails.windDegree}'),
        Text('Pressure: ${weatherDetails.pressureIn} in / ${weatherDetails.pressureMb} mb'),
        Text('Precipitation: ${weatherDetails.precipMm} mm / ${weatherDetails.precipIn} in'),
        Text('Humidity: ${weatherDetails.humidity}'),
        Text('Cloud: ${weatherDetails.cloud}'),
        Text('Gust: ${weatherDetails.gustMph} mph / ${weatherDetails.gustKph} kph'),
      ],
    );
  }

  Widget _buildVehicleInfo(WeatherDetails weatherDetails) {
    return Column(
crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vehicle Recommendation:',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        _getVehicleRecommendation(weatherDetails),
      ],
    );
  }

  Widget _getVehicleRecommendation(WeatherDetails weatherDetails) {
    List<WeatherCondition> weather = context.read<StateManager>().weatherCondition;
    List<Widget> images = [];
    List<Text> recommendedVehicles = [];
    WeatherCondition weatherCondition = weather.where((element) =>
    element.description == weatherDetails.conditionText ||
        weatherDetails.conditionText!.toLowerCase().contains(element.description.toLowerCase())).first;

    for (String image in weatherCondition.weatherImages ){
      Widget getImage =   Container(width:200,height:200,child: Image.asset("assets/$image",fit: BoxFit.cover,));
    images.add(getImage);
    }

    for (String text in weatherCondition.recommendedVehicle ){
      Text getText = Text(text);
      recommendedVehicles.add(getText);
    }
    return Container(
      height: 400,
      child: ListView(
       children: [
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(
               'Condition',
               style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
             ),
             Text(weatherCondition.description),
           ],
         ),
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(
               'Weather Description',
               style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
             ),
             Text(weatherCondition.weatherDescription),
           ],
         ),
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(
               'Recommended Vehicles',
               style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
             ),
             Row(
               children: recommendedVehicles,
             ),
           ],
         ),
         SingleChildScrollView(
           scrollDirection: Axis.horizontal,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: images,
           ),
         )

       ],
         ),
    );
  }
}
