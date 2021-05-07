//@dart = 2.9

import 'dart:convert';

import 'package:covigo/widgets/drawernavigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class OxygenScreen extends StatefulWidget {
  @override
  _OxygenScreenState createState() => _OxygenScreenState();
}

List data = new List();

class _OxygenScreenState extends State<OxygenScreen> {
  getOxygen() async {
    var res = await http.get(
        Uri.parse("http://192.168.0.104/doctor_details/oxy_details.php"),
        headers: {"Accept": "application/json"});

    var jsonbody = res.body;

    var jsondata = json.decode(jsonbody);

    setState(() {
      data = jsondata;
    });

    print(
        "hellllllllllllllllllllllllllllllllllllllllllllllllllllll${jsondata[1]}");

    return data;
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
    await Future.delayed(Duration(seconds: 2));
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
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return (data.length == 0)
                  ? Center(child: Text("Data Not Present"))
                  : Card(
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
                                String val = "tel:" + data[index]['Phone'];
                                customLaunch(val);
                              },
                              title: Text(
                                "🌐 ${data[index]['Place']}",
                                style: GoogleFonts.mcLaren(
                                    fontSize: 18, color: Colors.white),
                              ),
                              subtitle: Text(
                                "☎️ Phone:${data[index]['Phone']}",
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
            }),
        onRefresh: refreshlist,
      ),
    );
  }
}
