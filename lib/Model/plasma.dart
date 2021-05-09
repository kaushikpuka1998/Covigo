// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);
//@dart =2.9

import 'dart:convert';

List<Plasma> plasmaFromMap(String str) =>
    List<Plasma>.from(json.decode(str).map((x) => Plasma.fromMap(x)));

String plasmaToMap(List<Plasma> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Plasma {
  Plasma({
    this.hospital,
    this.phone,
  });

  String hospital;
  String phone;

  factory Plasma.fromMap(Map<String, dynamic> json) => Plasma(
        hospital: json["hospital"],
        phone: json["Phone"],
      );

  Map<String, dynamic> toMap() => {
        "hospital": hospital,
        "Phone": phone,
      };
}
