import 'package:community_material_icon/community_material_icon.dart';
import 'package:covigo/Screens/bedscreen.dart';
import 'package:covigo/Screens/oxygenscreen.dart';
import 'package:covigo/Screens/vaccinescreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Covigo"),
              accountEmail: Text("Version 1.0"),
              decoration: BoxDecoration(color: Colors.green),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'bedpage');
              },
              title: Text('Bed Availiviliy'),
              leading: Icon(
                Icons.bed,
                color: Colors.cyanAccent,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'vaccinepage');
              },
              title: Text('Vaccine Details'),
              leading: Icon(
                FontAwesome.medkit,
                color: Colors.green,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'oxygenpage');
              },
              title: Text('Oxygen Supply'),
              leading: Icon(
                CommunityMaterialIcons.gas_cylinder,
                color: Colors.purple,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'homeisolationpage');
              },
              title: Text('Home Isolation Protocols'),
              leading: Icon(
                Icons.room_preferences,
                color: Colors.deepPurpleAccent,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'updateoncovidpage');
              },
              title: Text('Update On Covid-19'),
              leading: Icon(
                CommunityMaterialIcons.update,
                color: Colors.blue,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'covidinformationpage');
              },
              title: Text('Covid Information'),
              leading: Icon(
                CommunityMaterialIcons.virus,
                color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'contactpage');
              },
              title: Text('Contact'),
              leading: Icon(
                CommunityMaterialIcons.contacts,
                color: Colors.deepOrange,
              ),
            ),
            ListTile(
              title: Text('Rate'),
              leading: Icon(
                Icons.star_border,
                color: Colors.teal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
