//@dart = 2.9

import 'dart:convert';

import 'package:Covigo/Model/oxygen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class OxygenScreen extends StatefulWidget {
  @override
  _OxygenScreenState createState() => _OxygenScreenState();
}

class _OxygenScreenState extends State<OxygenScreen> {
  List<Oxygen> _oxydata = List<Oxygen>();
  List<Oxygen> _searchedoxydata = List<Oxygen>();
  Future<List<Oxygen>> getOxygen() async {
    var res = await http.get(
      Uri.parse("https://fooddataapi.s3.ap-south-1.amazonaws.com/oxygen.json"),
    );
    print(res.body);

    if (res.statusCode == 200) {
      var notesJson = json.decode(res.body);
      for (var notejson in notesJson) {
        _oxydata.add(Oxygen.fromMap(notejson));
      }
    }
    return OxygenFromMap(res.body);
  }

  Future<void> customLaunch(String s) async {
    if (await canLaunch(s)) {
      await launch(s);
    } else {
      print("Could Not Possible $s");
    }
  }

  @override
  void initState() {
    getOxygen().then((value) {
      setState(() {
        _oxydata.clear();
        _oxydata.addAll(value);
        _searchedoxydata = _oxydata;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "Oxygen Suppliers",
          style: GoogleFonts.mcLaren(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: (_oxydata.length != 0)
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return index == 0 ? _searchbar() : _listitem(index - 1);
                },
                itemCount: _searchedoxydata.length + 1,
              )
            : Container(
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
      child: TextField(
        decoration:
            InputDecoration(hintText: "Search by District or Area Name"),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _searchedoxydata = _oxydata.where((oxyeach) {
              var oxydistrict = oxyeach.place.toLowerCase();
              return oxydistrict.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listitem(index) {
    return Card(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.purple),
                shape: BoxShape.rectangle,
                gradient: LinearGradient(colors: [Colors.purple, Colors.white]),
                borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.all(15),
            child: ListTile(
              onTap: () {
                String val = "tel:" + _searchedoxydata[index].phone.toString();
                customLaunch(val);
              },
              title: Text(
                "???? ${_searchedoxydata[index].place}",
                style: GoogleFonts.mcLaren(fontSize: 18, color: Colors.white),
              ),
              subtitle: Text(
                "?????? Phone:${_searchedoxydata[index].phone.toString()}",
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
