import 'package:community_material_icon/community_material_icon.dart';
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
              title: Text('Bed Availiviliy'),
              leading: Icon(
                Icons.bed,
                color: Colors.cyanAccent,
              ),
            ),
            ListTile(
              title: Text('Vaccine Details'),
              leading: Icon(
                FontAwesome.medkit,
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text('Oxygen Supply'),
              leading: Icon(
                CommunityMaterialIcons.gas_cylinder,
                color: Colors.purple,
              ),
            ),
            ListTile(
              title: Text('Home Isolation Protocols'),
              leading: Icon(
                Icons.room_preferences,
                color: Colors.deepPurpleAccent,
              ),
            ),
            ListTile(
              title: Text('Update On Covid-19'),
              leading: Icon(
                CommunityMaterialIcons.update,
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Covid Information'),
              leading: Icon(
                CommunityMaterialIcons.virus,
                color: Colors.black,
              ),
            ),
            ListTile(
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
