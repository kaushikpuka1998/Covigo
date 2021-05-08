//@dart = 2.9

import 'dart:convert';

import 'package:covigo/Model/doctor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  Future<List<Doctor>> getContact() async {
    var res = await http.get(
      Uri.parse("http://192.168.0.104/doctor_details/conection.php"),
    );
    print(res.body);
    return DoctorFromMap(res.body);
  }

  @override
  void initState() {
    super.initState();
    getContact();
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
            style:
                GoogleFonts.mcLaren(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          centerTitle: true,
        ),
        body: Center(
            child: FutureBuilder(
                future: getContact(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, index) {
                          Doctor doc = snapshot.data[index];
                          return Card(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.deepOrange),
                                      shape: BoxShape.rectangle,
                                      gradient: LinearGradient(colors: [
                                        Colors.deepOrange,
                                        Colors.white
                                      ]),
                                      borderRadius: BorderRadius.circular(15)),
                                  padding: EdgeInsets.all(15),
                                  child: ListTile(
                                    onTap: () {
                                      String val = "tel:" + doc.phone;
                                      customLaunch(val);
                                    },
                                    title: Text(
                                      "👨‍⚕️ ${doc.name}",
                                      style: GoogleFonts.mcLaren(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      "📞  Phone:${doc.phone}\n🌐  Region:${doc.region}",
                                      style: GoogleFonts.mcLaren(
                                          fontSize: 14, color: Colors.white),
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
                        });
                  }
                  return CircularProgressIndicator();
                })));
  }
}
