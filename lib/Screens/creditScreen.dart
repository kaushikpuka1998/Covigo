import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreditScreen extends StatefulWidget {
  @override
  _CreditScreenState createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Credits",
          style: GoogleFonts.mcLaren(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            margin: EdgeInsets.all(45),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.teal, Colors.purple]),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(15),
            child: ListTile(
              title: Text(
                "Developed By Kaushik Ghosh",
                textAlign: TextAlign.center,
                style: GoogleFonts.mcLaren(fontSize: 16, color: Colors.white),
              ),
              subtitle: Text(
                "Student Of Coochbehar Government Engineering College",
                textAlign: TextAlign.center,
                style: GoogleFonts.mcLaren(
                    fontSize: 10, color: Colors.orangeAccent),
              ),
              leading: Image.network(
                'https://fooddataapi.s3.ap-south-1.amazonaws.com/kaushik.jpg',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(45),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.teal, Colors.purple]),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(15),
            child: ListTile(
              title: Text(
                "Data Resourced By Novonil Deb",
                textAlign: TextAlign.center,
                style: GoogleFonts.mcLaren(fontSize: 16, color: Colors.white),
              ),
              subtitle: Text(
                "Student Of North Bengal Medical College and Hospital",
                textAlign: TextAlign.center,
                style: GoogleFonts.mcLaren(
                    fontSize: 10, color: Colors.orangeAccent),
              ),
              leading: Image.network(
                'https://fooddataapi.s3.ap-south-1.amazonaws.com/Novonil.jpeg',
              ),
            ),
          ),
          Text(
            "Version 1.0.0 Covigo",
            textAlign: TextAlign.center,
            style: GoogleFonts.mcLaren(color: Colors.black, fontSize: 16),
          )
        ],
      ),
    );
  }
}
