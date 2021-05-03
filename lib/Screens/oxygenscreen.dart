import 'package:covigo/widgets/drawernavigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OxygenScreen extends StatefulWidget {
  @override
  _OxygenScreenState createState() => _OxygenScreenState();
}

class _OxygenScreenState extends State<OxygenScreen> {
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
      body: Center(
        child: Text(
          "Oxygen Page",
        ),
      ),
    );
  }
}
