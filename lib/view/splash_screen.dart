import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        Image.asset(
          "assets/images/splash_pic.jpg",
          height: height * 0.6,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: height * 0.04,
        ),
        Text("TOP HEADLINES",
            style: GoogleFonts.anton(letterSpacing: .6, color: Colors.grey)),
        SizedBox(
          height: height * 0.04,
        ),
        const SpinKitChasingDots(
          color: Colors.blue,
          size: 50,
        )
      ],
    ));
  }
}
