

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:password_generator/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushNamed(MyHomePage.tag);
  }

  @override
  Widget build(BuildContext context) {
  return new Scaffold(        
    body: new Center(
      child: new Image.asset('images/flutterwithlogo.png'),      
    ),
  );
  }
}