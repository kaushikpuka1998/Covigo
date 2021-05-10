//@dart =2.9

import 'dart:convert';
import 'dart:io';

import 'package:Covigo/Model/responsive.dart';
import 'package:Covigo/Model/vaccine.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'mainpage.dart';

Map<String, dynamic> mapvaccine = new Map<String, dynamic>();
List lastvalue = [];

var check = false;

class Vaccinescreen extends StatefulWidget {
  @override
  _VaccinescreenState createState() => _VaccinescreenState();
}

class _VaccinescreenState extends State<Vaccinescreen> {
  TextEditingController pincodeController = new TextEditingController();
  TextEditingController datecontroller = new TextEditingController();
  onWillPop(context) async {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return false;
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  Checkstatus() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult res) {
      if (res == ConnectivityResult.wifi || res == ConnectivityResult.mobile) {
        Fluttertoast.showToast(msg: "Internet Connected");
        check = true;
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

  getData() async {
    lastvalue.clear();
    mapvaccine.clear();
    print("${pincodeController.text}+${datecontroller.text}");
    var url = Uri.parse(
      'https://www.cowin.gov.in/api/v2/appointment/sessions/public/calendarByPin?pincode=${pincodeController.text}&date=${datecontroller.text}',
    );
    var res = await http.get(url);
    print("HELLLLLLLLLLLLLo${res.statusCode}");

    if (res.statusCode == 200) {
      print(res.body);

      setState(() {
        mapvaccine = new Map<String, dynamic>.from(json.decode(res.body));
      });
    }
    print("VVVVVVVVVVVVVVVVVVVVVVVVVVVV${mapvaccine}");
    List abc = mapvaccine["centers"];
    print("TTTTTTTTTTTTTTTTTTTTTTTTTT${abc.length}");

    //print(abc[1]);
    if (abc != null) {
      for (int i = 0; i < abc.length; i++) {
        String name = abc[i]["name"];
        String address = abc[i]["address"];
        String state_name = abc[i]["state_name"];
        String district_name = abc[i]["district_name"];
        String fromtime = abc[i]["from"];
        String totime = abc[i]["to"];
        String fee_type = abc[i]["fee_type"];

        List newabc = abc[i]["sessions"];

        for (int j = 0; j < newabc.length; j++) {
          String date = newabc[j]["date"];
          int available_capacity = newabc[j]["available_capacity"];
          int min_age_limit = newabc[j]["min_age_limit"];
          String vaccine = newabc[j]["vaccine"];

          Vaccine v = new Vaccine(
              name,
              address,
              state_name,
              district_name,
              fromtime,
              totime,
              fee_type,
              date,
              available_capacity,
              min_age_limit,
              vaccine);

          lastvalue.add(v);

          print(lastvalue);
        }
      }
    }
    //print("New Sessions=========>${lastvalue.length}");
    /*print(
        "DETAILSSSSSSSSSSSSSSSSSSSSS=>${mapvaccine["centers"][1]["sessions"]}");*/

    return lastvalue;
  }

  @override
  Widget build(BuildContext context) {
    print("GTETTTTTTTTTTTTTTTTTTTTTTTTTTTT${lastvalue.length}");
    Checkstatus();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Vaccine Details",
            style:
                GoogleFonts.mcLaren(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          centerTitle: true,
        ),
        body: ((lastvalue.length == 0)
            ? Center(child: _searchbar())
            : Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return _listItem(index);
                  },
                  itemCount: lastvalue.length,
                ),
              )));
  }

  _searchbar() {
    return Container(
        child: Wrap(
      children: <Widget>[
        Container(
          width: Responsive.width(100, context),
          height: Responsive.width(60, context),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: Colors.green,
              style: BorderStyle.solid,
            ),
          ),
          margin: EdgeInsets.all(2),
          child: Column(
            children: [
              Title(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Search Vaccination Center Details by Pincode of your Area",
                      style: GoogleFonts.openSans(
                          fontSize: 10, fontWeight: FontWeight.w400),
                    ),
                  )),
              Container(
                color: Colors.green,
                child: TextField(
                  controller: pincodeController,
                  style: GoogleFonts.mcLaren(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Pincode",
                    hintStyle:
                        GoogleFonts.mcLaren(color: Colors.white, fontSize: 12),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                margin: EdgeInsets.only(bottom: 2),
              ),
              Container(
                color: Colors.green,
                child: TextField(
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                      hintText: "Select Date",
                      hintStyle: GoogleFonts.mcLaren(color: Colors.white),
                      icon: Icon(
                        Icons.date_range_outlined,
                        color: Colors.white,
                      ),
                      fillColor: Colors.white),
                  controller: datecontroller,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2030),
                    ).then((pickedDate) {
                      datecontroller.text = pickedDate == null
                          ? DateFormat('dd-MM-yyyy')
                              .format(DateTime.now())
                              .toString()
                          : DateFormat('dd-MM-yyyy')
                              .format(pickedDate)
                              .toString();
                    });
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (pincodeController.text == "") {
                      return showCupertinoDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: new Text(
                                  "Alert",
                                  style: TextStyle(color: Colors.red),
                                ),
                                content: new Text("Pincode is Missing"),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    child: Text("Close"),
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                  ),
                                ],
                              ));
                    } else if (datecontroller.text == "") {
                      return showCupertinoDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: new Text(
                                  "Dialog Title",
                                  style: TextStyle(color: Colors.red),
                                ),
                                content: new Text("Date is Missing"),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    child: Text("Close"),
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                  ),
                                ],
                              ));
                    } else if (pincodeController.text == "" &&
                        datecontroller.text != "") {
                      return showCupertinoDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: new Text(
                                  "Alert",
                                  style: TextStyle(color: Colors.red),
                                ),
                                content: new Text("Pincode is Missing"),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    child: Text("Close"),
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                  ),
                                ],
                              ));
                    } else {
                      getData();
                      print(
                          "hhhhhhgurighitjgiiiiiiiiiiiiiiotitjgbiojjjjjjjjjjjjjjjjjjjg");
                      datecontroller.clear();
                      pincodeController.clear();
                    }
                  },
                  child: Text("Press to get Information"))
            ],
          ),
        ),
      ],
    ));
  }

  _listItem(index) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.purple, Colors.red])),
            width: Responsive.width(100, context),
            height: Responsive.width(100, context),
            padding: new EdgeInsets.fromLTRB(5, 12, 5, 12),
            child: Card(
              shadowColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.black54,
              elevation: 5,
              child: Wrap(
                direction: Axis.horizontal,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "Vaccine Name:${lastvalue[index].vaccine}",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.mcLaren(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      softWrap: true,
                    ),
                    trailing: Text(
                        "Available_capacity:${lastvalue[index].available_cap}",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.mcLaren(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        softWrap: true),
                  ),
                  ListTile(
                    title: Text(
                        "Name:${lastvalue[index].name},${lastvalue[index].address}",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.mcLaren(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        softWrap: true),
                    trailing: Text("${lastvalue[index].district_name}",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.mcLaren(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        softWrap: true),
                  ),
                  ListTile(
                    title: Text("${lastvalue[index].state_name}",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.mcLaren(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        softWrap: true),
                    trailing: Text("From:${lastvalue[index].from_time}(24hrs)",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.mcLaren(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        softWrap: true),
                  ),
                  ListTile(
                    title: Text("Date:${lastvalue[index].date}",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.mcLaren(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        softWrap: true),
                    trailing: Text(
                      "To:${lastvalue[index].to_time}(24Hrs)",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.mcLaren(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("Vaccine Fee:${lastvalue[index].feetype}",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.mcLaren(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        softWrap: true),
                    trailing: Text("Minimum Age:${lastvalue[index].min_age}",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.mcLaren(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        softWrap: true),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
