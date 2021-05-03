import 'package:covigo/widgets/drawernavigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Vaccinescreen extends StatefulWidget {
  @override
  _VaccinescreenState createState() => _VaccinescreenState();
}

class _VaccinescreenState extends State<Vaccinescreen> {
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
          "Vaccine Page",
        ),
      ),
    );
  }
}
