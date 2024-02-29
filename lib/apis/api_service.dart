import 'package:country_state_city/utils/utils.dart';
import 'package:diacritic/diacritic.dart';
import "package:http/http.dart";

import 'package:http/http.dart' as http;

import 'dart:convert';
class ApiService{
  static const weatherApiKey = "65018b8534b442f5a2c115208241702";
  static const BASE_URL = "http://api.weatherapi.com/v1";

  final Map<String, String> headers = {'Content-Type': 'application/json'};
  final Map<String, String> countryHeaders =   {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*'
  };


  Future<Map<String,dynamic>> getCountryWeather (String city) async {
   String newCity= removeDiacriticMarks(city);
   Map<String,dynamic> emptyMap = {};
   print(newCity);
    Uri uri = Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=$weatherApiKey&q=$newCity");
    http.Response result = await http.get(uri, headers: headers,);
    if (result.statusCode == 200) {
      Map<String, dynamic> response = json.decode(result.body);
      print(response);
      return response;
    } else {
     return emptyMap;
    }
  }

  String removeDiacriticMarks(String text) {
    return removeDiacritics(text);
  }


  Future<Map<String,dynamic>> getFutureCountryWeather (String city, DateTime date) async {
    String newCity= removeDiacriticMarks(city);
    Map<String,dynamic> emptyMap = {};
    Uri uri = Uri.parse(
        "http://api.weatherapi.com/v1/future.json?key=$weatherApiKey&q=$newCity&dt=$date");
    http.Response result = await http.get(uri, headers: headers,);
    print(result.body);
    if (result.statusCode == 200) {
      Map<String, dynamic> response = json.decode(result.body);
      print(response);
      return response;
    } else {
      return emptyMap;
    }
  }


}