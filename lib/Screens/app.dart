import 'package:covigo/Screens/mainpage.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'mainpage',
      routes: {
        'mainpage': (context) => MainPage(),
      },
    );
  }
}
