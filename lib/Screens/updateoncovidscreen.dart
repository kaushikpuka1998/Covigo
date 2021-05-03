import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateoncovidScreen extends StatefulWidget {
  @override
  _UpdateoncovidScreenState createState() => _UpdateoncovidScreenState();
}

class _UpdateoncovidScreenState extends State<UpdateoncovidScreen> {
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
          "Update On Covid Screen Page",
        ),
      ),
    );
  }
}
