//@dart =2.9

import 'dart:convert';

import 'package:covigo/Model/responsive.dart';
import 'package:covigo/Model/vaccine.dart';
import 'package:covigo/widgets/drawernavigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:covigo/Model/vaccine.dart';
import 'mainpage.dart';

Map<String, dynamic> mapvaccine = new Map<String, dynamic>();
List lastvalue = [];

class Vaccinescreen extends StatefulWidget {
  @override
  _VaccinescreenState createState() => _VaccinescreenState();
}

class _VaccinescreenState extends State<Vaccinescreen> {
  TextEditingController pincodeController = new TextEditingController();
  TextEditingController datecontroller = new TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    lastvalue.clear();
    var url = Uri.parse(
        'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByPin?pincode=${pincodeController.text}&date=${datecontroller.text}');
    var res = await http.get(url);
    //print(res.statusCode);
    if (res.statusCode == 200) {
      //print(res.body);

      setState(() {
        mapvaccine = new Map<String, dynamic>.from(json.decode(res.body));
      });
    }
    print(mapvaccine);
    List abc = mapvaccine["centers"];
    //print("TTTTTTTTTTTTTTTTTTTTTTTTTT${abc}");
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Covigo",
            style: GoogleFonts.sacramento(
                fontSize: 35, fontWeight: FontWeight.w800),
          ),
          centerTitle: true,
        ),
        body: (mapvaccine == null)
            ? Center(
                child: Center(
                  child: Text(
                    "Server Error",
                    style: GoogleFonts.mcLaren(fontSize: 25, color: Colors.red),
                  ),
                ),
              )
            : ((lastvalue.length == 0)
                ? _searchbar()
                : Container(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return (index == 0) ? _searchbar() : _listItem(index);
                      },
                      itemCount: lastvalue.length,
                    ),
                  )));
  }

  _searchbar() {
    return Container(
        child: Container(
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
                  "Search Vaccination Center Details by Pincode of your Area and Desired Date",
                  style: GoogleFonts.openSans(
                      fontSize: 10, fontWeight: FontWeight.w400),
                ),
              )),
          TextField(
            controller: pincodeController,
            style: GoogleFonts.mcLaren(color: Colors.blueGrey),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter Pincode",
              hintStyle: GoogleFonts.mcLaren(color: Colors.blue, fontSize: 12),
              suffixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.all(10),
            ),
          ),
          TextField(
            cursorColor: Colors.green,
            decoration: InputDecoration(
              hintText: "Select Date",
              icon: Icon(Icons.date_range_outlined),
            ),
            controller: datecontroller,
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2021),
                lastDate: DateTime(2030),
              ).then((pickedDate) {
                datecontroller.text = pickedDate == null
                    ? DateFormat('dd-MM-yyyy').format(DateTime.now()).toString()
                    : DateFormat('dd-MM-yyyy').format(pickedDate).toString();
              });
            },
          ),
          ElevatedButton(
              onPressed: () {
                getData();
                datecontroller.clear();
                pincodeController.clear();
              },
              child: Text("Press to get Information"))
        ],
      ),
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
              color: Colors.cyanAccent,
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
                    title: Text("Address:${lastvalue[index].address}",
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
