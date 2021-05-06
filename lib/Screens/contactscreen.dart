import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

List data = [];

class _ContactScreenState extends State<ContactScreen> {
  Future getContact() async {
    var res = await http.get(
        Uri.parse("http://192.168.0.103/doctor_details/conection.php"),
        headers: {"Accept": "application/json"});

    var jsonbody = res.body;

    var jsondata = json.decode(jsonbody);

    setState(() {
      data = jsondata;
    });

    print(jsondata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Covigo",
            style: GoogleFonts.sacramento(
                fontSize: 35, fontWeight: FontWeight.w800),
          ),
          centerTitle: true,
        ),
        body: (data.isEmpty)
            ? Center(
                child: Text(
                  "Contact Page",
                ),
              )
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: data[index]["Name"],
                  );
                }));
  }

  @override
  void initState() {
    getContact();
    super.initState();
  }
}
