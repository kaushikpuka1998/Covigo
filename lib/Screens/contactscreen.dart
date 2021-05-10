//@dart = 2.9

import 'dart:convert';

import 'package:Covigo/Model/doctor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Doctor> _docdata = new List();
  List<Doctor> _searcheddocdata = new List();
  Future<List<Doctor>> getContact() async {
    var res = await http.get(
      Uri.parse("https://fooddataapi.s3.ap-south-1.amazonaws.com/docto.json"),
    );
    print(res.body);

    if (res.statusCode == 200) {
      var notesJson = json.decode(res.body);
      for (var notejson in notesJson) {
        _docdata.add(Doctor.fromMap(notejson));
      }
    }
    return DoctorFromMap(res.body);
  }

  @override
  void initState() {
    getContact().then((value) {
      setState(() {
        _docdata.clear();
        _docdata.addAll(value);
        _searcheddocdata = _docdata;
      });
    });
    super.initState();
  }

  Future<void> customLaunch(String s) async {
    if (await canLaunch(s)) {
      await launch(s);
    } else {
      print("Could Not Possible $s");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          "Doctor Details",
          style: GoogleFonts.mcLaren(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: (_docdata.length != 0)
          ? Center(
              child: ListView.builder(
              itemBuilder: (context, index) {
                return index == 0 ? _searchbar() : _listitem(index - 1);
              },
              itemCount: _searcheddocdata.length + 1,
            ))
          : Center(
              child: Container(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text(
                      "Loading",
                      style: GoogleFonts.mcLaren(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  _searchbar() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration:
              InputDecoration(hintText: "Search by District or Area Name"),
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              _searcheddocdata = _docdata.where((doceach) {
                var docdistrict = doceach.region.toLowerCase();
                return docdistrict.contains(text);
              }).toList();
            });
          },
        ),
      ),
    );
  }

  _listitem(index) {
    return Card(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.deepOrange),
                shape: BoxShape.rectangle,
                gradient:
                    LinearGradient(colors: [Colors.deepOrange, Colors.white]),
                borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.all(15),
            child: ListTile(
              onTap: () {
                String val = "tel:" + _searcheddocdata[index].phone.toString();
                customLaunch(val);
              },
              title: Text(
                "👨‍⚕️ ${_searcheddocdata[index].name}",
                style: GoogleFonts.mcLaren(fontSize: 18, color: Colors.white),
              ),
              subtitle: Text(
                "📞  Phone:${_searcheddocdata[index].phone}\n🌐  Region:${_searcheddocdata[index].region}",
                style: GoogleFonts.mcLaren(fontSize: 14, color: Colors.white),
              ),
              trailing: Icon(
                Icons.phone_forwarded,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
