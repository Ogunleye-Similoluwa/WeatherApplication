import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weathercommuteapplication/state_management/state_manager.dart';

import '../model/wetherDetails.dart';

class WeatherCard extends StatelessWidget {
  final WeatherDetails details;

  WeatherCard({required this.details});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<StateManager>().changeSelectedWeather(details);
        context.pushNamed("info");
      },
      child: AnimatedContainer(
        curve: Curves.easeInOut,
        height: 250,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Color(0xFFE1BEE7)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(15),
          ),
          image: DecorationImage(
            image: details.isDay!
                ? AssetImage("assets/day_3.jpeg")
                : AssetImage("assets/night_2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        duration: Duration(seconds: 1),
        child: ListView(
          children: [
            buildRow("Condition:  ", details.conditionText ?? "Not Available", details.isDay!),
            SizedBox(height: 10),
            Container(
              height: 90,
              child: Image.network(
                "https:${details.image}",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 10),
            buildRow("City:  ", details.city ?? "Not Available", details.isDay!),
            buildRow("State:  ", details.region?.isEmpty ?? true ? "Not Available" : details.region!, details.isDay!),
            buildRow("Country:", details.country ?? "Not Available", details.isDay!),
            buildRow("Date:  ", context.read<StateManager>().formatStringDate(details.localTime!), details.isDay!),
            buildRow("Time:  ", context.read<StateManager>().formatTime(details.localTime!) ?? "Not Available", details.isDay!),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, String value, bool isDay) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: isDay ? Colors.black : Colors.white,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontFamily: "Raleway",
            fontWeight: FontWeight.w400,
            fontSize: 16,
            overflow: TextOverflow.ellipsis,
            color: isDay ? Colors.black : Colors.white,
          ),
        ),
      ],
    );
  }
}
