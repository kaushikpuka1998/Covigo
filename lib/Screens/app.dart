//@dart = 2.9

import 'dart:convert';

import 'package:Covigo/Screens/updateoncovidscreen.dart';
import 'package:Covigo/Screens/vaccinescreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'bedscreen.dart';
import 'contactscreen.dart';
import 'covidinformationscreen.dart';
import 'creditScreen.dart';
import 'homeisolationscreen.dart';
import 'mainpage.dart';
import 'oxygenscreen.dart';

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
        'creditpage': (context) => CreditScreen(),
      },
    );
  }
}
