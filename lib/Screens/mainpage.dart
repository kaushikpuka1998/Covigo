//@dart = 2.9

import 'dart:convert';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
Map<String, dynamic> mapnew = new Map<String, dynamic>();

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

@override
class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    getData();
    getanotherData();
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

  getanotherData() async {
    var url = Uri.parse(
        'https://api.apify.com/v2/key-value-stores/toDWvRj1JpTXiM8FF/records/LATEST?disableRedirect=true');
    var res = await http.get(url);
    //print(res.statusCode);
    if (res.statusCode == 200) {
      //print(res.body);

      setState(() {
        mapnew = new Map<String, dynamic>.from(json.decode(res.body));
      });
    }
    print("CHCCCCCCCCCCCCCCCCCCCCkkkkmapvalue::::::${mapnew["activeCases"]}");
    return mapnew;
  }

  TextEditingController districtController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  String state, district;
  String var1 = "", var2 = "", var3 = "", var4 = "";
  String tmpvar1 = "", tmpvar2 = "", tmpvar3 = "";
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
      body: ListView(children: [
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
            decoration: BoxDecoration(
              color: Colors.tealAccent,
              borderRadius: BorderRadius.circular(2),
            ),
            margin: EdgeInsets.all(2),
            child: TextField(
              controller: stateController,
              style: GoogleFonts.mcLaren(color: Colors.blueGrey),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter State Name",
                hintStyle: GoogleFonts.mcLaren(color: Colors.blue),
                suffixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
        ),
        Container(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.tealAccent,
              borderRadius: BorderRadius.circular(2),
            ),
            margin: EdgeInsets.all(2),
            child: TextField(
              controller: districtController,
              style: GoogleFonts.mcLaren(color: Colors.blueGrey),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter District Name",
                hintStyle: GoogleFonts.mcLaren(color: Colors.blue),
                suffixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
        ),
        Container(
            child: Column(
          children: [
            ElevatedButton(
              child: Text("Check Details"),
              onPressed: () {
                print("TAGGGGGGGGG=>${stateController.text}");
                state = stateController.text;
                district = districtController.text;
                print("TAGAggggggggggggg=>>>>${districtController.text}");
                var tmp1 =
                    map['${state}']['districtData']['${district}']['confirmed'];
                var tmp2 =
                    map['${state}']['districtData']['${district}']['active'];
                var tmp3 =
                    map['${state}']['districtData']['${district}']['recovered'];

                var tmp4 =
                    map['${state}']['districtData']['${district}']['deceased'];

                var tmp5 = map['${state}']['districtData']['${district}']
                    ["delta"]['confirmed'];
                var tmp6 = map['${state}']['districtData']['${district}']
                    ["delta"]['recovered'];
                var tmp7 = map['${state}']['districtData']['${district}']
                    ["delta"]['deceased'];
                var nullcheck = map['${state}']['districtData']['${district}'];

                if (nullcheck == null) {
                  Fluttertoast.showToast(msg: "State or District Name Problem");
                }
                print("gggggggggggggggggggggggggg=>${tmp1}");
                setState(() {
                  var1 = tmp1.toString();
                  var2 = tmp2.toString();
                  var3 = tmp3.toString();
                  var4 = tmp4.toString();
                  tmpvar1 = tmp5.toString();
                  tmpvar2 = tmp6.toString();
                  tmpvar3 = tmp7.toString();
                });

                print("TAGGGGGGGGGGGGGGGGGGG=>${var1},${var2}");
              },
            ),
          ],
        )),
        Container(
          child: Container(
            child: Text(
              "Total Reports of ${district == null ? 'India' : district}",
              style: GoogleFonts.mcLaren(color: Colors.black, fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 120,
                    width: 160,
                    alignment: Alignment.center,
                    color: Colors.red[100],
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "CONFIRMED\n${map['${state}'] == null ? mapnew["activeCasesNew"].toString() : var1}",
                      style: GoogleFonts.mcLaren(
                          fontWeight: FontWeight.w900, color: Colors.red),
                    ),
                    margin: EdgeInsets.only(right: 10),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 120,
                    width: 160,
                    alignment: Alignment.center,
                    color: Colors.blue[100],
                    child: Text(
                      "ACTIVE\n${map['${state}'] == null ? mapnew["activeCases"].toString() : var2}",
                      style: GoogleFonts.mcLaren(
                          fontWeight: FontWeight.w900, color: Colors.blue),
                    ),
                    margin: EdgeInsets.only(left: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 120,
                    width: 160,
                    alignment: Alignment.center,
                    color: Colors.green[100],
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "RECOVERED\n${map['${state}'] == null ? mapnew["recovered"].toString() : var3}",
                      style: GoogleFonts.mcLaren(
                          fontWeight: FontWeight.w900, color: Colors.green),
                    ),
                    margin: EdgeInsets.only(right: 10),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 120,
                    width: 160,
                    alignment: Alignment.center,
                    color: Colors.blueGrey[100],
                    child: Text(
                      "DEATH\n${map['${state}'] == null ? mapnew["deaths"].toString() : var4}",
                      style: GoogleFonts.mcLaren(
                          fontWeight: FontWeight.w900, color: Colors.blueGrey),
                    ),
                    margin: EdgeInsets.only(left: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: Text(
            "Prevention from COVID-19",
            style: GoogleFonts.mcLaren(fontSize: 16),
          ),
        ),
        Container(
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Image.network(
                    'https://media.istockphoto.com/vectors/medical-mask-icon-protection-against-viruses-and-diseases-transmitted-vector-id1201386847?k=6&m=1201386847&s=612x612&w=0&h=b1MbT15RYkPcnq79bWdoEhKqR3ggFo4wt4VDmzIkX2w=',
                    height: 120,
                    width: 120,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 5),
                child: Image.network(
                  "https://media.istockphoto.com/vectors/handwashing-illustration-vector-id1133178162?k=6&m=1133178162&s=612x612&w=0&h=Imb_K0MTXOpLs4lEMeG_B5sO2RK6exiYERZOI3ilmD0=",
                  height: 120,
                  width: 120,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Image.network(
                  "https://media.istockphoto.com/vectors/social-distancing-keep-the-1-meter-distance-in-public-to-protect-from-vector-id1213888133",
                  height: 120,
                  width: 120,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: Text(
            "Daily updates of ${tmpvar1 == "" ? 'India' : district}",
            style: GoogleFonts.mcLaren(fontSize: 16),
          ),
        ),
        Container(
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.orange, Colors.white])),
                child: ListTile(
                  title: Text(
                    "Infected",
                    style: GoogleFonts.mcLaren(color: Colors.white),
                  ),
                  trailing: Text(
                      "${tmpvar1 == "" ? mapnew["activeCasesNew"] : tmpvar1}"),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.green, Colors.white])),
                child: ListTile(
                  title: Text(
                    "Recovered",
                    style: GoogleFonts.mcLaren(color: Colors.white),
                  ),
                  trailing: Text(
                      "${tmpvar3 == "" ? mapnew["recoveredNew"].toString() : tmpvar3}"),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.red, Colors.white])),
                child: ListTile(
                  title: Text(
                    "Recovered",
                    style: GoogleFonts.mcLaren(color: Colors.white),
                  ),
                  trailing: Text(
                      "${tmpvar2 == "" ? mapnew["deathsNew"].toString() : tmpvar2}"),
                ),
              ),
              Text(
                "(*) Zero Means System Upgrade for Delta Change",
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        )
      ]),
    );
  }
}
