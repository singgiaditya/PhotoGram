

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mtf_app/HomeScreen.dart';
import 'package:mtf_app/loginScreen.dart';
import 'package:mtf_app/shared_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final token = SharedPref.pref?.get("token");

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () {
          if (token == null) {
            Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
          }else{
            Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Ini Logo"),
      ),
    );
  }
}
