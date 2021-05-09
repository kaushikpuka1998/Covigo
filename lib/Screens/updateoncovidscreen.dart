//@dart =2.9

import 'dart:convert';

import 'package:covigo/Model/plasma.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateoncovidScreen extends StatefulWidget {
  @override
  _UpdateoncovidScreenState createState() => _UpdateoncovidScreenState();
}

class _UpdateoncovidScreenState extends State<UpdateoncovidScreen> {
  List<Plasma> _plasmadata = List<Plasma>();
  List<Plasma> _searchedplasmadata = List<Plasma>();
  Future<List<Plasma>> getPlasma() async {
    var res = await http.get(
      Uri.parse("http://192.168.0.104/doctor_details/plasma.php"),
    );
    print(res.body);

    if (res.statusCode == 200) {
      var notesJson = json.decode(res.body);
      for (var notejson in notesJson) {
        _plasmadata.add(Plasma.fromMap(notejson));
      }
    }
    return plasmaFromMap(res.body);
  }

  @override
  void initState() {
    getPlasma().then((value) {
      setState(() {
        _plasmadata.clear();
        _plasmadata.addAll(value);
        _searchedplasmadata = _plasmadata;
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

  Future<Null> refreshlist() async {
    await Future.delayed(Duration(seconds: 1));
    _plasmadata.clear();
    setState(() {
      getPlasma();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Blood Bank/Plasma Details",
          style: GoogleFonts.mcLaren(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: RefreshIndicator(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return index == 0 ? _searchbar() : _listitem(index - 1);
            },
            itemCount: _searchedplasmadata.length + 1,
          ),
          onRefresh: refreshlist,
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
            _searchedplasmadata = _plasmadata.where((plasmaeach) {
              var oxydistrict = plasmaeach.hospital.toLowerCase();
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
                gradient: LinearGradient(colors: [Colors.blue, Colors.white]),
                borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.all(15),
            child: ListTile(
              onTap: () {
                String val = "tel:" + _searchedplasmadata[index].phone;
                customLaunch(val);
              },
              title: Text(
                "🏥 ${_searchedplasmadata[index].hospital}",
                style: GoogleFonts.mcLaren(fontSize: 18, color: Colors.white),
              ),
              subtitle: Text(
                "☎️ Phone:${_searchedplasmadata[index].phone}",
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
