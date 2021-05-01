import 'package:covigo/widgets/drawernavigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Covigo",
          style:
              GoogleFonts.sacramento(fontSize: 35, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      drawer: DrawerNavigation(),
    );
  }
}
