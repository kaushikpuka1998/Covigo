//@dart = 2.9

import 'dart:convert';

import 'package:covigo/Model/oxygen.dart';
import 'package:covigo/widgets/drawernavigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class OxygenScreen extends StatefulWidget {
  @override
  _OxygenScreenState createState() => _OxygenScreenState();
}

class _OxygenScreenState extends State<OxygenScreen> {
  Future<List<Oxygen>> getOxygen() async {
    var res = await http.get(
      Uri.parse("http://192.168.0.104/doctor_details/oxy_details.php"),
    );
    print(res.body);
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
    getOxygen();
    super.initState();
  }

  Future<Null> refreshlist() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      getOxygen();
    });
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
      body: RefreshIndicator(
        child: Center(
            child: Container(
          child: FutureBuilder(
            future: getOxygen(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, index) {
                      Oxygen oxy = snapshot.data[index];
                      return Card(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.purple),
                                  shape: BoxShape.rectangle,
                                  gradient: LinearGradient(
                                      colors: [Colors.purple, Colors.white]),
                                  borderRadius: BorderRadius.circular(15)),
                              padding: EdgeInsets.all(15),
                              child: ListTile(
                                onTap: () {
                                  String val = "tel:" + oxy.phone;
                                  customLaunch(val);
                                },
                                title: Text(
                                  "🌐 ${oxy.place}",
                                  style: GoogleFonts.mcLaren(
                                      fontSize: 18, color: Colors.white),
                                ),
                                subtitle: Text(
                                  "☎️ Phone:${oxy.phone}",
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
            },
          ),
        )),
        onRefresh: refreshlist,
      ),
    );
  }
}
