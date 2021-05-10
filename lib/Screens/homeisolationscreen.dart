//@dart =2.9

import 'package:Covigo/Model/apiforpdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeisolationScreen extends StatefulWidget {
  @override
  _HomeisolationScreenState createState() => _HomeisolationScreenState();
}

class _HomeisolationScreenState extends State<HomeisolationScreen> {
  String _localfile;

  @override
  void initState() {
    Apiservice.loadPDF().then((value) {
      setState(() {
        _localfile = value;
        print(_localfile);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          "Home Isolation Protocol",
          style: GoogleFonts.mcLaren(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: _localfile != null
          ? Container(
              child: PDFView(
                filePath: _localfile,
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
