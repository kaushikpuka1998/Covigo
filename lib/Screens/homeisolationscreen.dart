import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeisolationScreen extends StatefulWidget {
  @override
  _HomeisolationScreenState createState() => _HomeisolationScreenState();
}

class _HomeisolationScreenState extends State<HomeisolationScreen> {
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
          "Home Isolation Page",
        ),
      ),
    );
  }
}
