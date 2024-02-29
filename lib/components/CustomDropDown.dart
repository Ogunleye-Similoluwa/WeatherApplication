import 'package:flutter/material.dart';


class CustomDropDown extends StatelessWidget {
  void Function()? onTap ;
  void  Function(String?)? onChanged;
  String dropDownValue;
  List<DropdownMenuItem<String>>? items;
  Widget? dropDownItemChild;
  double ? height;
  double? width;

  CustomDropDown({required this.onChanged, this.height,this.width,this.onTap, this.dropDownItemChild, required this.dropDownValue, required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height??50,
      width: width??200 ,
      padding: EdgeInsets.only(left: 0,right: 0),
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)
      ),
      child: DropdownButton<String>(
        value: dropDownValue,
        elevation: 0,
        style: const TextStyle(
            fontSize: 20,
            fontFamily: "Raleway",
            color: Colors.black),
        underline: const SizedBox(),
        onChanged: onChanged,
        items: items
      ),
    );
  }
}
