import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CovidInformationScreen extends StatefulWidget {
  @override
  _CovidInformationScreenState createState() => _CovidInformationScreenState();
}

class _CovidInformationScreenState extends State<CovidInformationScreen> {
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
          "Covid Information Page",
        ),
      ),
    );
  }
}
