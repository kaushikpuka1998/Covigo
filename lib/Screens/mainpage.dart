//@dart = 2.9

import 'dart:convert';
import '';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:covigo/widgets/drawernavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

Map<String, dynamic> map = new Map<String, dynamic>();

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

@override
class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var url =
        Uri.parse('https://api.covid19india.org/state_district_wise.json');
    var res = await http.get(url);
    //print(res.statusCode);
    if (res.statusCode == 200) {
      //print(res.body);

      setState(() {
        map = new Map<String, dynamic>.from(json.decode(res.body));
      });
    }

    return map;
  }

  @override
  Widget build(BuildContext context) {
    print("TAG+++++++++++++++++++++++${map}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Covigo",
          style:
              GoogleFonts.sacramento(fontSize: 35, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      drawer: DrawerNavigation(),
      body: ListView(
        children: [
          SizedBox(
            height: 200.0,
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Carousel(
                  dotSize: 5,
                  dotSpacing: 10,
                  dotColor: Colors.green,
                  indicatorBgPadding: 3.0,
                  images: [
                    NetworkImage(
                        'https://images.newindianexpress.com/uploads/user/imagelibrary/2020/5/16/w900X450/COVID-19_Test_PTI_.jpg'),
                    NetworkImage(
                        'https://assets.telegraphindia.com/telegraph/2021/Apr/1619046987_1607722911_nbmch.jpg'),
                    NetworkImage(
                        'https://i.ytimg.com/vi/odWF_LNydAA/maxresdefault.jpg'),
                    NetworkImage(
                        'https://snworksceo.imgix.net/azw/919e9800-aeed-4b07-9549-c2c5ac5e756f.sized-1000x1000.jpg?w=1000'),
                    NetworkImage(
                        'https://www.orangutanapplause.com/wp-content/uploads/2021/01/covid-rule_3.jpg'),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Container(
              child: Text(
                "Daily Reports",
                style: GoogleFonts.mcLaren(color: Colors.black, fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 120,
                    width: 160,
                    alignment: Alignment.center,
                    color: Colors.red[100],
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "CONFIRMED\n${map['West Bengal'] == null ? '' : map['West Bengal']['districtData']['Jalpaiguri']['delta']['confirmed']}",
                      style: GoogleFonts.mcLaren(
                          fontWeight: FontWeight.w900, color: Colors.red),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Container(
                    height: 120,
                    width: 160,
                    alignment: Alignment.center,
                    color: Colors.blue[100],
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "ACTIVE\n${map['West Bengal'] == null ? '' : map['West Bengal']['districtData']['Jalpaiguri']['active']}",
                      style: GoogleFonts.mcLaren(
                          fontWeight: FontWeight.w900, color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 120,
                    width: 160,
                    alignment: Alignment.center,
                    color: Colors.green[100],
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "RECOVERED\n${map['West Bengal'] == null ? '' : map['West Bengal']['districtData']['Jalpaiguri']['delta']['recovered']}",
                      style: GoogleFonts.mcLaren(
                          fontWeight: FontWeight.w900, color: Colors.green),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Container(
                    height: 120,
                    width: 160,
                    alignment: Alignment.center,
                    color: Colors.blueGrey[100],
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "DEATH\n${map['West Bengal'] == null ? '' : map['West Bengal']['districtData']['Jalpaiguri']['delta']['deceased']}",
                      style: GoogleFonts.mcLaren(
                          fontWeight: FontWeight.w900, color: Colors.blueGrey),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
