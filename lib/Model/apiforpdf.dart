import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Apiservice {
  static final String url =
      "https://www.mohfw.gov.in/pdf/RevisedGuidelineshomeisolation4.pdf";

  static Future<String> loadPDF() async {
    var data = await http.get(Uri.parse(url));

    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/homeisolation.pdf");
    file.writeAsBytes(data.bodyBytes, flush: true);

    return file.path;
  }
}
