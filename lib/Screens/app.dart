//@dart = 2.9

import 'dart:convert';

import 'package:covigo/Screens/bedscreen.dart';
import 'package:covigo/Screens/contactscreen.dart';
import 'package:covigo/Screens/covidinformationscreen.dart';
import 'package:covigo/Screens/homeisolationscreen.dart';
import 'package:covigo/Screens/mainpage.dart';
import 'package:covigo/Screens/oxygenscreen.dart';
import 'package:covigo/Screens/updateoncovidscreen.dart';
import 'package:covigo/Screens/vaccinescreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'mainpage',
      routes: {
        'mainpage': (context) => MainPage(),
        'bedpage': (context) => BedScreen(),
        'vaccinepage': (context) => Vaccinescreen(),
        'oxygenpage': (context) => OxygenScreen(),
        'homeisolationpage': (context) => HomeisolationScreen(),
        'updateoncovidpage': (context) => UpdateoncovidScreen(),
        'covidinformationpage': (context) => CovidInformationScreen(),
        'contactpage': (context) => ContactScreen(),
      },
    );
  }
}
