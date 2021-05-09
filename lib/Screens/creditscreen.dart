import 'package:carousel_slider/carousel_slider.dart';
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
            padding: EdgeInsets.all(45),
            child: ListTile(
              title: Text(
                "Developed By Kaushik Ghosh",
                style: GoogleFonts.mcLaren(fontSize: 16, color: Colors.white),
              ),
              leading: Image.network(
                'https://media-exp1.licdn.com/dms/image/C5603AQFzMCiYz4xcfA/profile-displayphoto-shrink_800_800/0/1618677385568?e=1626307200&v=beta&t=XLNw_Pb7yf1uZ9rCpl5h_rlNG-lge4I20nPerdLUxvA',
              ),
            ),
          ),
          Container(
            height: 150,
            margin: EdgeInsets.all(45),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.teal, Colors.purple]),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(35),
            child: ListTile(
              title: Text(
                "Data Resourced By Novonil Deb",
                style: GoogleFonts.mcLaren(fontSize: 16, color: Colors.white),
              ),
              leading: Image.network(
                'https://lh3.googleusercontent.com/7lClguqfABm8827aAGcJgbF1YpikY7w1XtNpQV4nNZsgafIcjdqfV_Mp4xRcGUa4VsKK=s85',
              ),
            ),
          ),
          Text(
            "Version 1.0 Covigo",
            textAlign: TextAlign.center,
            style: GoogleFonts.mcLaren(color: Colors.black, fontSize: 16),
          )
        ],
      ),
    );
  }
}
