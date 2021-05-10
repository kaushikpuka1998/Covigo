//@dart = 2.9

import 'dart:convert';
import 'package:Covigo/widgets/drawernavigation.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;

Map<String, dynamic> map = new Map<String, dynamic>();
Map<String, dynamic> mapnew = new Map<String, dynamic>();
Map<String, dynamic> dose = new Map<String, dynamic>();
int ln;
bool check = false;

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
    Checkstatus();
    getDose();
    super.initState();
  }

  onWillPop(context) async {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return false;
  }

  Checkstatus() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult res) {
      if (res == ConnectivityResult.wifi || res == ConnectivityResult.mobile) {
        Fluttertoast.showToast(msg: "Internet Connected");
        check = true;
        getData();
        getanotherData();
        getDose();
      } else {
        check = false;
        return showCupertinoDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: new Text(
                    "Information",
                    style: TextStyle(color: Colors.red),
                  ),
                  content: new Text("Internet Connectivity Lost"),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text("Close"),
                      onPressed: () => onWillPop(context),
                    ),
                  ],
                ));
      }
    });
  }

  getDose() async {
    var url = Uri.parse('https://api.covid19india.org/data.json');
    var res = await http.get(url);
    //print(res.statusCode);
    if (res.statusCode == 200) {
      //print(res.body);

      setState(() {
        dose = new Map<String, dynamic>.from(json.decode(res.body));
      });
      ln = dose["tested"].length;
      /*print(
          "CHCKKKKKKKKKKKKKKKKKKKKKIIIIIINNNNG${dose["tested"][ln - 1]["dailyrtpcrsamplescollectedicmrapplication"]}");*/
    }
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
    //print("CHCCCCCCCCCCCCCCCCCCCCkkkkmapvalue::::::${mapnew["activeCases"]}");
    return mapnew;
  }

  TextEditingController districtController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  String state, district;
  String var1 = "", var2 = "", var3 = "", var4 = "";
  String tmpvar1 = "", tmpvar2 = "", tmpvar3 = "";
  var tmp5, tmp6, tmp7;
  @override
  Widget build(BuildContext context) {
    print("TAG+++++++++++++++++++++++${map}");
    Checkstatus();
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
      body: (check == false)
          ? Center(
              child: Column(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(75)),
                    child: Image.asset(
                      "images/load2.gif",
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Text(
                    "Loading",
                    style:
                        GoogleFonts.mcLaren(fontSize: 30, color: Colors.green),
                  )
                ],
              ),
            )
          : ListView(children: [
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
                    child: DropDownField(
                      controller: stateController,
                      hintText: "Select State...",
                      hintStyle: GoogleFonts.mcLaren(color: Colors.white),
                      itemsVisibleInDropdown: 2,
                      enabled: true,
                      items: states,
                      onValueChanged: (value) {
                        setState(
                          () {
                            stateController.text = value;
                          },
                        );
                      },
                    )),
              ),
              Container(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.tealAccent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    margin: EdgeInsets.all(2),
                    child: DropDownField(
                      controller: districtController,
                      hintText: "Select District...",
                      hintStyle: GoogleFonts.mcLaren(color: Colors.white),
                      itemsVisibleInDropdown: 3,
                      enabled: true,
                      items: districts,
                      setter: (value) {
                        setState(() {
                          districtController.text = value;
                        });
                      },
                    )),
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

                      if (state == "" && district == "") {
                        getanotherData();
                      }
                      print("TAGAggggggggggggg=>>>>${districtController.text}");
                      var tmp1 = map['${state}']['districtData']['${district}']
                          ['confirmed'];
                      var tmp2 = map['${state}']['districtData']['${district}']
                          ['active'];
                      var tmp3 = map['${state}']['districtData']['${district}']
                          ['recovered'];

                      var tmp4 = map['${state}']['districtData']['${district}']
                          ['deceased'];

                      tmp5 = map['${state}']['districtData']['${district}']
                          ["delta"]['confirmed'];
                      tmp6 = map['${state}']['districtData']['${district}']
                          ["delta"]['recovered'];
                      tmp7 = map['${state}']['districtData']['${district}']
                          ["delta"]['deceased'];
                      var nullcheck =
                          map['${state}']['districtData']['${district}'];

                      if (nullcheck == null) {
                        Fluttertoast.showToast(
                            msg: "State or District Name Problem");
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
                    "Total Reports of ${map['${state}'] == null ? 'India' : district}",
                    style:
                        GoogleFonts.mcLaren(color: Colors.black, fontSize: 24),
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red[100],
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "CONFIRMED\n${map['${state}'] == null ? "--" : var1}",
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue[100],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "ACTIVE\n${map['${state}'] == null ? mapnew["activeCases"].toString() : var2}",
                            style: GoogleFonts.mcLaren(
                                fontWeight: FontWeight.w900,
                                color: Colors.blue),
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green[100],
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "RECOVERED\n${map['${state}'] == null ? mapnew["recovered"].toString() : var3}",
                            style: GoogleFonts.mcLaren(
                                fontWeight: FontWeight.w900,
                                color: Colors.green),
                          ),
                          margin: EdgeInsets.only(right: 10),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 120,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueGrey[100],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "DEATH\n${map['${state}'] == null ? mapnew["deaths"].toString() : var4}",
                            style: GoogleFonts.mcLaren(
                                fontWeight: FontWeight.w900,
                                color: Colors.blueGrey),
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
                          check == true
                              ? "https://media.istockphoto.com/vectors/medical-mask-icon-protection-against-viruses-and-diseases-transmitted-vector-id1201386847?k=6&m=1201386847&s=612x612&w=0&h=b1MbT15RYkPcnq79bWdoEhKqR3ggFo4wt4VDmzIkX2w="
                              : "",
                          height: 120,
                          width: 120,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 5),
                        child: Image.network(
                          check == true
                              ? "https://media.istockphoto.com/vectors/handwashing-illustration-vector-id1133178162?k=6&m=1133178162&s=612x612&w=0&h=Imb_K0MTXOpLs4lEMeG_B5sO2RK6exiYERZOI3ilmD0="
                              : "",
                          height: 120,
                          width: 120,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 5),
                        child: Image.network(
                          check == true
                              ? "https://media.istockphoto.com/vectors/social-distancing-keep-the-1-meter-distance-in-public-to-protect-from-vector-id1213888133"
                              : "",
                          height: 120,
                          width: 120,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Daily updates of ${district == "" || tmpvar1 == "" ? 'India' : district}",
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
                          gradient: LinearGradient(
                              colors: [Colors.orange, Colors.white])),
                      child: ListTile(
                        title: Text(
                          "Infected",
                          style: GoogleFonts.mcLaren(color: Colors.white),
                        ),
                        trailing: Text(
                            "${district == "" || tmpvar1 == "" ? mapnew["activeCasesNew"] : tmpvar1}"),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.red, Colors.white])),
                      child: ListTile(
                        title: Text(
                          "Death",
                          style: GoogleFonts.mcLaren(color: Colors.white),
                        ),
                        trailing: Text(
                            "${district == "" || tmpvar3 == "" ? mapnew["recoveredNew"].toString() : tmpvar3}"),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.green, Colors.white])),
                      child: ListTile(
                        title: Text(
                          "Recovered",
                          style: GoogleFonts.mcLaren(color: Colors.white),
                        ),
                        trailing: Text(
                            "${district == "" || tmpvar2 == "" ? mapnew["deathsNew"].toString() : tmpvar2}"),
                      ),
                    ),
                    Text(
                      "(*) Zero Means System Upgrade for Delta Change\n State Data Updated by https://covid19india.org\nin afternoon everyday",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: new Align(
                          alignment: Alignment.centerLeft,
                          child: new Text(
                            "Vaccination Daily Report of India",
                            style: GoogleFonts.mcLaren(fontSize: 16),
                          )),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 4, bottom: 20),
                              child: Neumorphic(
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  alignment: Alignment(0, 0),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.red, width: 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20)),
                                  ),
                                  child: Text(
                                    "Age\n45-60\n1st Dose:\n${(ln == null) ? "" : dose["tested"][ln - 1]["over45years1stdose"] == "" ? dose["tested"][ln - 2]["over45years1stdose"] : dose["tested"][ln - 1]["over45years1stdose"]}",
                                    style: GoogleFonts.mcLaren(
                                        fontSize: 12, color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 4, bottom: 20),
                              child: Neumorphic(
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  alignment: Alignment(0, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.blue, width: 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20)),
                                  ),
                                  child: Text(
                                    "Age\n45 - 60\n2nd Dose:\n${(ln != null) ? dose["tested"][ln - 1]["over45years2nddose"] == "" ? dose["tested"][ln - 2]["over45years2nddose"] : dose["tested"][ln - 1]["over45years2nddose"] : ""}",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.mcLaren(
                                        fontSize: 12, color: Colors.blue),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 4, bottom: 20),
                              child: Neumorphic(
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  alignment: Alignment(0, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.purple, width: 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20)),
                                  ),
                                  child: Text(
                                    "Age\nAfter 60\n1st Dose:\n${(ln != null) ? dose["tested"][ln - 1]["over60years1stdose"] == "" ? dose["tested"][ln - 2]["over60years1stdose"] : dose["tested"][ln - 1]["over60years1stdose"] : ""}",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.mcLaren(
                                        fontSize: 12, color: Colors.purple),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 4, bottom: 20, right: 4),
                              child: Neumorphic(
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  alignment: Alignment(0, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.green, width: 1),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20)),
                                  ),
                                  child: Text(
                                    "Age\nAfter 60\n2nd Dose:\n${(ln != null) ? dose["tested"][ln - 1]["over60years2nddose"] == "" ? dose["tested"][ln - 2]["over60years2nddose"] : dose["tested"][ln - 1]["over60years2nddose"] : ""}",
                                    style: GoogleFonts.mcLaren(
                                        fontSize: 12, color: Colors.green),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: PieChart(
                              dataMap: {
                                "Front Line Worker 1st Dose": double.parse((ln ==
                                        null)
                                    ? "0"
                                    : dose["tested"][ln - 1][
                                                "frontlineworkersvaccinated1stdose"] ==
                                            ""
                                        ? dose["tested"][ln - 2][
                                            "frontlineworkersvaccinated1stdose"]
                                        : dose["tested"][ln - 1][
                                            "frontlineworkersvaccinated1stdose"]),
                                "Front Line Worker 2nd Dose": double.parse((ln ==
                                        null)
                                    ? "0"
                                    : dose["tested"][ln - 1][
                                                "frontlineworkersvaccinated2nddose"] ==
                                            ""
                                        ? dose["tested"][ln - 2][
                                            "frontlineworkersvaccinated2nddose"]
                                        : dose["tested"][ln - 1][
                                            "frontlineworkersvaccinated2nddose"]),
                                "Health Worker 1st Dose": double.parse((ln ==
                                        null)
                                    ? "0"
                                    : dose["tested"][ln - 1][
                                                "healthcareworkersvaccinated1stdose"] ==
                                            ""
                                        ? dose["tested"][ln - 2][
                                            "healthcareworkersvaccinated1stdose"]
                                        : dose["tested"][ln - 1][
                                            "healthcareworkersvaccinated1stdose"]),
                                "Health Worker 2nd Dose": double.parse((ln ==
                                        null)
                                    ? "0"
                                    : dose["tested"][ln - 1][
                                                "healthcareworkersvaccinated2nddose"] ==
                                            ""
                                        ? dose["tested"][ln - 2][
                                            "healthcareworkersvaccinated2nddose"]
                                        : dose["tested"][ln - 1][
                                            "healthcareworkersvaccinated2nddose"]),
                                "Age 45-60 1st Dose": double.parse((ln == null)
                                    ? "0"
                                    : dose["tested"][ln - 1]
                                                ["over45years1stdose"] ==
                                            ""
                                        ? dose["tested"][ln - 2]
                                            ["over45years1stdose"]
                                        : dose["tested"][ln - 1]
                                            ["over45years1stdose"]),
                                "Age 45-60 2nd Dose": double.parse((ln == null)
                                    ? "0"
                                    : dose["tested"][ln - 1]
                                                ["over45years2nddose"] ==
                                            ""
                                        ? dose["tested"][ln - 2]
                                            ["over45years2nddose"]
                                        : dose["tested"][ln - 1]
                                            ["over45years2nddose"]),
                                "Age 60 Above 1st Dose": double.parse(
                                    (ln == null)
                                        ? "0"
                                        : dose["tested"][ln - 1]
                                                    ["over60years1stdose"] ==
                                                ""
                                            ? dose["tested"][ln - 2]
                                                ["over60years1stdose"]
                                            : dose["tested"][ln - 1]
                                                ["over60years1stdose"]),
                                "Age 60 Above 2nd Dose": double.parse(
                                    (ln == null)
                                        ? "0"
                                        : dose["tested"][ln - 1]
                                                    ["over60years2nddose"] ==
                                                ""
                                            ? dose["tested"][ln - 2]
                                                ["over60years2nddose"]
                                            : dose["tested"][ln - 1]
                                                ["over60years2nddose"])
                              },
                              chartValuesOptions: ChartValuesOptions(
                                  chartValueStyle: TextStyle(
                                      fontSize: 8, color: Colors.black),
                                  showChartValueBackground: false,
                                  showChartValuesInPercentage: true),
                            ),
                          ),
                          Text(
                              "Updated On ${(ln != null) && dose["tested"][ln - 1]["over60years2nddose"] != "" ? dose["tested"][ln - 1]["updatetimestamp"] == "" ? dose["tested"][ln - 2]["updatetimestamp"] : dose["tested"][ln - 1]["updatetimestamp"] : ""}")
                        ],
                      ),
                    )
                  ],
                ),
              )
            ]),
    );
  }

  List<String> states = [
    "Assam",
    "Arunachal Pradesh",
    "Andhra Pradesh",
    "Andaman and Nicobar Islands",
    "Bihar",
    "Chandigarh",
    "Chhattisgarh",
    "Delhi",
    "Dadra and Nagar Haveli and Daman and Diu",
    "Gujarat",
    "Goa",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Kerala",
    "Karnataka",
    "Lakshadweep",
    "Ladakh",
    "Mizoram",
    "Madhya Pradesh",
    "Manipur",
    "Meghalaya",
    "Maharashtra",
    "Nagaland",
    "Odisha",
    "Puducherry",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tripura",
    "Tamil Nadu",
    "Telangana",
    "Uttarakhand",
    "Uttar Pradesh",
    "West Bengal",
  ];
  List<String> districts = [
    "Nicobars",
    "North and Middle Andaman",
    "South Andaman",
    "Anantapur",
    "Chittoor",
    "East Godavari",
    "Guntur",
    "Krishna",
    "Kurnool",
    "Prakasam",
    "S.P.S. Nellore",
    "Srikakulam",
    "Visakhapatnam",
    "Vizianagaram",
    "West Godavari",
    "Y.S.R. Kadapa",
    "Anjaw",
    "Changlang",
    "East Kameng",
    "East Siang",
    "Kamle",
    "Kra Daadi",
    "Kurung Kumey",
    "Lepa Rada",
    "Lohit",
    "Longding",
    "Lower Dibang Valley",
    "Lower Siang",
    "Lower Subansiri",
    "Namsai",
    "Pakke Kessang",
    "Papum Pare",
    "Shi Yomi",
    "Siang",
    "Tawang",
    "Tirap",
    "Upper Dibang Valley",
    "Upper Siang",
    "Upper Subansiri",
    "West Kameng",
    "West Siang",
    "Baksa",
    "Barpeta",
    "Biswanath",
    "Bongaigaon",
    "Cachar",
    "Charaideo",
    "Chirang",
    "Darrang",
    "Dhemaji",
    "Dhubri",
    "Dibrugarh",
    "Dima Hasao",
    "Goalpara",
    "Golaghat",
    "Hailakandi",
    "Hojai",
    "Jorhat",
    "Kamrup",
    "Kamrup Metropolitan",
    "Karbi Anglong",
    "Karimganj",
    "Kokrajhar",
    "Lakhimpur",
    "Majuli",
    "Morigaon",
    "Nagaon",
    "Nalbari",
    "Other State",
    "Sivasagar",
    "Sonitpur",
    "South Salmara Mankachar",
    "Tinsukia",
    "Udalguri",
    "West Karbi Anglong",
    "Araria",
    "Arwal",
    "Aurangabad",
    "Banka",
    "Begusarai",
    "Bhagalpur",
    "Bhojpur",
    "Buxar",
    "Darbhanga",
    "East Champaran",
    "Gaya",
    "Gopalganj",
    "Jamui",
    "Jehanabad",
    "Kaimur",
    "Katihar",
    "Khagaria",
    "Kishanganj",
    "Lakhisarai",
    "Madhepura",
    "Madhubani",
    "Munger",
    "Muzaffarpur",
    "Nalanda",
    "Nawada",
    "Patna",
    "Purnia",
    "Rohtas",
    "Saharsa",
    "Samastipur",
    "Saran",
    "Sheikhpura",
    "Sheohar",
    "Sitamarhi",
    "Siwan",
    "Supaul",
    "Vaishali",
    "West Champaran",
    "Chandigarh",
    "Balod",
    "Baloda Bazar",
    "Balrampur",
    "Bametara",
    "Bastar",
    "Bijapur",
    "Bilaspur",
    "Dakshin Bastar Dantewada",
    "Dhamtari",
    "Durg",
    "Gariaband",
    "Janjgir Champa",
    "Jashpur",
    "Kabeerdham",
    "Kondagaon",
    "Korba",
    "Koriya",
    "Mahasamund",
    "Mungeli",
    "Narayanpur",
    "Raigarh",
    "Raipur",
    "Rajnandgaon",
    "Sukma",
    "Surajpur",
    "Surguja",
    "Uttar Bastar Kanker",
    "Gaurela Pendra Marwahi",
    "Central Delhi",
    "East Delhi",
    "New Delhi",
    "North Delhi",
    "North East Delhi",
    "North West Delhi",
    "Shahdara",
    "South Delhi",
    "South East Delhi",
    "South West Delhi",
    "West Delhi",
    "Dadra and Nagar Haveli",
    "Daman",
    "Diu",
    "North Goa",
    "South Goa",
    "Ahmedabad",
    "Amreli",
    "Anand",
    "Aravalli",
    "Banaskantha",
    "Bharuch",
    "Bhavnagar",
    "Botad",
    "Chhota Udaipur",
    "Dahod",
    "Dang",
    "Devbhumi Dwarka",
    "Gandhinagar",
    "Gir Somnath",
    "Jamnagar",
    "Junagadh",
    "Kheda",
    "Kutch",
    "Mahisagar",
    "Mehsana",
    "Morbi",
    "Narmada",
    "Navsari",
    "Panchmahal",
    "Patan",
    "Porbandar",
    "Rajkot",
    "Sabarkantha",
    "Surat",
    "Surendranagar",
    "Tapi",
    "Vadodara",
    "Valsad",
    "Bilaspur",
    "Chamba",
    "Hamirpur",
    "Kangra",
    "Kinnaur",
    "Kullu",
    "Lahaul and Spiti",
    "Mandi",
    "Shimla",
    "Sirmaur",
    "Solan",
    "Una",
    "Ambala",
    "Bhiwani",
    "Charkhi Dadri",
    "Faridabad",
    "Fatehabad",
    "Gurugram",
    "Hisar",
    "Jhajjar",
    "Jind",
    "Kaithal",
    "Karnal",
    "Kurukshetra",
    "Mahendragarh",
    "Nuh",
    "Palwal",
    "Panchkula",
    "Panipat",
    "Rewari",
    "Rohtak",
    "Sirsa",
    "Sonipat",
    "Yamunanagar",
    "Bokaro",
    "Chatra",
    "Deoghar",
    "Dhanbad",
    "Dumka",
    "East Singhbhum",
    "Garhwa",
    "Giridih",
    "Godda",
    "Gumla",
    "Hazaribagh",
    "Jamtara",
    "Khunti",
    "Koderma",
    "Latehar",
    "Lohardaga",
    "Pakur",
    "Palamu",
    "Ramgarh",
    "Ranchi",
    "Sahibganj",
    "Saraikela-Kharsawan",
    "Simdega",
    "West Singhbhum",
    "Anantnag",
    "Bandipora",
    "Baramulla",
    "Budgam",
    "Doda",
    "Ganderbal",
    "Jammu",
    "Kathua",
    "Kishtwar",
    "Kulgam",
    "Kupwara",
    "Mirpur",
    "Muzaffarabad",
    "Pulwama",
    "Punch",
    "Rajouri",
    "Ramban",
    "Reasi",
    "Samba",
    "Shopiyan",
    "Srinagar",
    "Udhampur",
    "Bagalkote",
    "Ballari",
    "Belagavi",
    "Bengaluru Rural",
    "Bengaluru Urban",
    "Bidar",
    "Chamarajanagara",
    "Chikkaballapura",
    "Chikkamagaluru",
    "Chitradurga",
    "Dakshina Kannada",
    "Davanagere",
    "Dharwad",
    "Gadag",
    "Hassan",
    "Haveri",
    "Kalaburagi",
    "Kodagu",
    "Kolar",
    "Koppal",
    "Mandya",
    "Mysuru",
    "Raichur",
    "Ramanagara",
    "Shivamogga",
    "Tumakuru",
    "Udupi",
    "Uttara Kannada",
    "Vijayapura",
    "Yadgir",
    "Alappuzha",
    "Ernakulam",
    "Idukki",
    "Kannur",
    "Kasaragod",
    "Kollam",
    "Kottayam",
    "Kozhikode",
    "Malappuram",
    "Palakkad",
    "Pathanamthitta",
    "Thiruvananthapuram",
    "Thrissur",
    "Wayanad",
    "Kargil",
    "Leh",
    "Lakshadweep",
    "Ahmednagar",
    "Akola",
    "Amravati",
    "Aurangabad",
    "Beed",
    "Bhandara",
    "Buldhana",
    "Chandrapur",
    "Dhule",
    "Gadchiroli",
    "Gondia",
    "Hingoli",
    "Jalgaon",
    "Jalna",
    "Kolhapur",
    "Latur",
    "Mumbai",
    "Mumbai Suburban",
    "Nagpur",
    "Nanded",
    "Nandurbar",
    "Nashik",
    "Osmanabad",
    "Palghar",
    "Parbhani",
    "Pune",
    "Raigad",
    "Ratnagiri",
    "Sangli",
    "Satara",
    "Sindhudurg",
    "Solapur",
    "Thane",
    "Wardha",
    "Washim",
    "Yavatmal",
    "East Garo Hills",
    "East Jaintia Hills",
    "East Khasi Hills",
    "North Garo Hills",
    "Ribhoi",
    "South Garo Hills",
    "South West Garo Hills",
    "South West Khasi Hills",
    "West Garo Hills",
    "West Jaintia Hills",
    "West Khasi Hills",
    "Bishnupur",
    "Chandel",
    "Churachandpur",
    "Imphal East",
    "Imphal West",
    "Jiribam",
    "Kakching",
    "Kamjong",
    "Kangpokpi",
    "Noney",
    "Pherzawl",
    "Senapati",
    "Tamenglong",
    "Tengnoupal",
    "Thoubal",
    "Ukhrul",
    "Agar Malwa",
    "Alirajpur",
    "Anuppur",
    "Ashoknagar",
    "Balaghat",
    "Barwani",
    "Betul",
    "Bhind",
    "Bhopal",
    "Burhanpur",
    "Chhatarpur",
    "Chhindwara",
    "Damoh",
    "Datia",
    "Dewas",
    "Dhar",
    "Dindori",
    "Guna",
    "Gwalior",
    "Harda",
    "Hoshangabad",
    "Indore",
    "Jabalpur",
    "Jhabua",
    "Katni",
    "Khandwa",
    "Khargone",
    "Mandla",
    "Mandsaur",
    "Morena",
    "Narsinghpur",
    "Neemuch",
    "Niwari",
    "Other Region",
    "Panna",
    "Raisen",
    "Rajgarh",
    "Ratlam",
    "Rewa",
    "Sagar",
    "Satna",
    "Sehore",
    "Seoni",
    "Shahdol",
    "Shajapur",
    "Sheopur",
    "Shivpuri",
    "Sidhi",
    "Singrauli",
    "Tikamgarh",
    "Ujjain",
    "Umaria",
    "Vidisha",
    "Aizawl",
    "Champhai",
    "Hnahthial",
    "Khawzawl",
    "Kolasib",
    "Lawngtlai",
    "Lunglei",
    "Mamit",
    "Saiha",
    "Saitual",
    "Serchhip",
    "Dimapur",
    "Kiphire",
    "Kohima",
    "Longleng",
    "Mokokchung",
    "Mon",
    "Peren",
    "Phek",
    "Tuensang",
    "Wokha",
    "Zunheboto",
    "Angul",
    "Balangir",
    "Balasore",
    "Bargarh",
    "Bhadrak",
    "Boudh",
    "Cuttack",
    "Deogarh",
    "Dhenkanal",
    "Gajapati",
    "Ganjam",
    "Jagatsinghpur",
    "Jajpur",
    "Jharsuguda",
    "Kalahandi",
    "Kandhamal",
    "Kendrapara",
    "Kendujhar",
    "Khordha",
    "Koraput",
    "Malkangiri",
    "Mayurbhanj",
    "Nabarangapur",
    "Nayagarh",
    "Nuapada",
    "Puri",
    "Rayagada",
    "Sambalpur",
    "Subarnapur",
    "Sundargarh",
    "Amritsar",
    "Barnala",
    "Bathinda",
    "Faridkot",
    "Fatehgarh Sahib",
    "Fazilka",
    "Ferozepur",
    "Gurdaspur",
    "Hoshiarpur",
    "Jalandhar",
    "Kapurthala",
    "Ludhiana",
    "Mansa",
    "Moga",
    "Pathankot",
    "Patiala",
    "Rupnagar",
    "S.A.S. Nagar",
    "Sangrur",
    "Shahid Bhagat Singh Nagar",
    "Sri Muktsar Sahib",
    "Tarn Taran",
    "Karaikal",
    "Mahe",
    "Puducherry",
    "Yanam",
    "Ajmer",
    "Alwar",
    "Banswara",
    "Baran",
    "Barmer",
    "Bharatpur",
    "Bhilwara",
    "Bikaner",
    "Bundi",
    "Chittorgarh",
    "Churu",
    "Dausa",
    "Dholpur",
    "Dungarpur",
    "Ganganagar",
    "Hanumangarh",
    "Jaipur",
    "Jaisalmer",
    "Jalore",
    "Jhalawar",
    "Jhunjhunu",
    "Jodhpur",
    "Karauli",
    "Kota",
    "Nagaur",
    "Pali",
    "Pratapgarh",
    "Rajsamand",
    "Sawai Madhopur",
    "Sikar",
    "Sirohi",
    "Tonk",
    "Udaipur",
    "East Sikkim",
    "North Sikkim",
    "South Sikkim",
    "West Sikkim",
    "Adilabad",
    "Bhadradri Kothagudem",
    "Hyderabad",
    "Jagtial",
    "Jangaon",
    "Jayashankar Bhupalapally",
    "Jogulamba Gadwal",
    "Kamareddy",
    "Karimnagar",
    "Khammam",
    "Komaram Bheem",
    "Mahabubabad",
    "Mahabubnagar",
    "Mancherial",
    "Medak",
    "Medchal Malkajgiri",
    "Mulugu",
    "Nagarkurnool",
    "Nalgonda",
    "Narayanpet",
    "Nirmal",
    "Nizamabad",
    "Peddapalli",
    "Rajanna Sircilla",
    "Ranga Reddy",
    "Sangareddy",
    "Siddipet",
    "Suryapet",
    "Vikarabad",
    "Wanaparthy",
    "Warangal Rural",
    "Warangal Urban",
    "Yadadri Bhuvanagiri",
    "Ariyalur",
    "Chengalpattu",
    "Chennai",
    "Coimbatore",
    "Cuddalore",
    "Dharmapuri",
    "Dindigul",
    "Erode",
    "Kallakurichi",
    "Kancheepuram",
    "Kanyakumari",
    "Karur",
    "Krishnagiri",
    "Madurai",
    "Nagapattinam",
    "Namakkal",
    "Nilgiris",
    "Perambalur",
    "Pudukkottai",
    "Ramanathapuram",
    "Ranipet",
    "Salem",
    "Sivaganga",
    "Tenkasi",
    "Thanjavur",
    "Theni",
    "Thiruvallur",
    "Thiruvarur",
    "Thoothukkudi",
    "Tiruchirappalli",
    "Tirunelveli",
    "Tirupathur",
    "Tiruppur",
    "Tiruvannamalai",
    "Vellore",
    "Viluppuram",
    "Virudhunagar",
    "Dhalai",
    "Gomati",
    "Khowai",
    "North Tripura",
    "Sipahijala",
    "South Tripura",
    "Unokoti",
    "West Tripura",
    "Agra",
    "Aligarh",
    "Ambedkar Nagar",
    "Amethi",
    "Amroha",
    "Auraiya",
    "Ayodhya",
    "Azamgarh",
    "Baghpat",
    "Bahraich",
    "Ballia",
    "Balrampur",
    "Banda",
    "Barabanki",
    "Bareilly",
    "Basti",
    "Bhadohi",
    "Bijnor",
    "Budaun",
    "Bulandshahr",
    "Chandauli",
    "Chitrakoot",
    "Deoria",
    "Etah",
    "Etawah",
    "Farrukhabad",
    "Fatehpur",
    "Firozabad",
    "Gautam Buddha Nagar",
    "Ghaziabad",
    "Ghazipur",
    "Gonda",
    "Gorakhpur",
    "Hamirpur",
    "Hapur",
    "Hardoi",
    "Hathras",
    "Jalaun",
    "Jaunpur",
    "Jhansi",
    "Kannauj",
    "Kanpur Dehat",
    "Kanpur Nagar",
    "Kasganj",
    "Kaushambi",
    "Kushinagar",
    "Lakhimpur Kheri",
    "Lalitpur",
    "Lucknow",
    "Maharajganj",
    "Mahoba",
    "Mainpuri",
    "Mathura",
    "Mau",
    "Meerut",
    "Mirzapur",
    "Moradabad",
    "Muzaffarnagar",
    "Pilibhit",
    "Pratapgarh",
    "Prayagraj",
    "Rae Bareli",
    "Rampur",
    "Saharanpur",
    "Sambhal",
    "Sant Kabir Nagar",
    "Shahjahanpur",
    "Shamli",
    "Shrawasti",
    "Siddharthnagar",
    "Sitapur",
    "Sonbhadra",
    "Sultanpur",
    "Unnao",
    "Varanasi",
    "Almora",
    "Bageshwar",
    "Chamoli",
    "Champawat",
    "Dehradun",
    "Haridwar",
    "Nainital",
    "Pauri Garhwal",
    "Pithoragarh",
    "Rudraprayag",
    "Tehri Garhwal",
    "Udham Singh Nagar",
    "Uttarkashi",
    "Alipurduar",
    "Bankura",
    "Birbhum",
    "Cooch Behar",
    "Dakshin Dinajpur",
    "Darjeeling",
    "Hooghly",
    "Howrah",
    "Jalpaiguri",
    "Jhargram",
    "Kalimpong",
    "Kolkata",
    "Malda",
    "Murshidabad",
    "Nadia",
    "North 24 Parganas",
    "Paschim Bardhaman",
    "Paschim Medinipur",
    "Purba Bardhaman",
    "Purba Medinipur",
    "Purulia",
    "South 24 Parganas",
    "Uttar Dinajpur"
  ];
}
