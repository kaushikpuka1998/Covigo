import 'package:covigo/widgets/drawernavigation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BedScreen extends StatefulWidget {
  @override
  _BedScreenState createState() => _BedScreenState();
}

class _BedScreenState extends State<BedScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        child: WebView(
          initialUrl:
              "https://excise.wb.gov.in/CHMS/Public/Page/CHMS_Public_Hospital_Bed_Availability.aspx",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
