import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weathercommuteapplication/components/CustomDropDown.dart';
import 'package:weathercommuteapplication/components/weatherCard.dart';
import 'package:weathercommuteapplication/model/wetherDetails.dart';

import '../apis/api_service.dart';
import '../state_management/state_manager.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    WeatherDetails details = context.watch<StateManager>().details;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child:  AnimatedContainer(
          // width: size.width-30,
          curve: Curves.easeInOut,
          height: 250,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            image: DecorationImage(
              image:details.isDay??false
                  ? AssetImage("assets/day_2.jpg")
                  : AssetImage("assets/night.jpg",),
              fit: BoxFit.cover,
            ),
          ),
          duration: Duration(milliseconds: 500),

          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              CustomDropDown(
                dropDownValue: context.watch<StateManager>().countryDropdownValue,
                onChanged: (String? value) {
                  context.read<StateManager>().changeCountry(value!);
                },
                items: context.watch<StateManager>().countriesList.map<DropdownMenuItem<String>>((instance) {
                  return DropdownMenuItem<String>(
                    value: instance.name,
                    onTap: () {
                      context.read<StateManager>().getStatesByCountry(instance.isoCode);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            instance.flag,
                            style: const TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            width: 200,
                            child: Text(
                              instance.name,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Raleway",
                                fontStyle: FontStyle.italic,
                                overflow: TextOverflow.ellipsis,
                                color: details.isDay??false ? Colors.black : Colors.grey,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              context.read<StateManager>().hasState ?
                CustomDropDown(
                  dropDownValue: context.watch<StateManager>().stateDropdownValue,
                  onChanged: (String? value) {
                    context.read<StateManager>().changeState(value!);
                  },
                  items: context.watch<StateManager>().statesList.map<DropdownMenuItem<String>>((instance) {
                    return DropdownMenuItem<String>(
                      value: instance.name,
                      onTap: () {
                        context.read<StateManager>().getCitiesByState(instance.countryCode, instance.isoCode);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                instance.name,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Raleway",
                                  fontStyle: FontStyle.italic,
                                  overflow: TextOverflow.ellipsis,
                                  color: details.isDay??false ? Colors.black : Colors.grey,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ):
              SizedBox.shrink(),
              const SizedBox(height: 20),
              context.read<StateManager>().hasState &&  context.read<StateManager>().hasCity ?
                CustomDropDown(
                  dropDownValue: context.watch<StateManager>().cityDropdownValue,
                  onChanged: (String? value) {
                    context.read<StateManager>().changeCity(value!);
                  },
                  items: context.watch<StateManager>().citiesList.map<DropdownMenuItem<String>>((instance) {
                    return DropdownMenuItem<String>(
                      value: instance.name,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                instance.name,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Raleway",
                                  fontStyle: FontStyle.italic,
                                  overflow: TextOverflow.ellipsis,
                                  color: details.isDay??false ? Colors.black : Colors.grey,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ):SizedBox.shrink(),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<StateManager>().getCountryWeather();
                  context.read<StateManager>().searchNextWeather();
                },
                child: const Text("Get Current Weather",),
              ),
              if (context.read<StateManager>().weatherReturned)
            WeatherCard(details: context.read<StateManager>().details)
    else
                const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}



