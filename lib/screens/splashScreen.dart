

import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds:5),(){
      context.goNamed("home");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:SizedBox(
        width:size.width,
        height:size.height,
          child:Center(
          child:Column(
          children:
      [
          Text("Welcome")
          ]
      )
      )
      )
    );
  }
}
