//@dart = 2.9

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

List data = new List();

class _ContactScreenState extends State<ContactScreen> {
  getContact() async {
    var res = await http.get(
        Uri.parse("http://192.168.0.104/doctor_details/conection.php"),
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
          style: GoogleFonts.mcLaren(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return (data.length == 0)
                ? Center(child: Text("Data Not Present"))
                : Card(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.deepOrange),
                              shape: BoxShape.rectangle,
                              gradient: LinearGradient(
                                  colors: [Colors.deepOrange, Colors.white]),
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(15),
                          child: ListTile(
                            onTap: () {
                              String val = "tel:" + data[index]['Phone'];
                              customLaunch(val);
                            },
                            title: Text(
                              "👨‍⚕️ ${data[index]['Name']}",
                              style: GoogleFonts.mcLaren(
                                  fontSize: 18, color: Colors.white),
                            ),
                            subtitle: Text(
                              "📞  Phone:${data[index]['Phone']}\n🌐  Region:${data[index]['Region']}",
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
    );
  }
}
