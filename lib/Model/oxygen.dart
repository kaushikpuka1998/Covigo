//@dart = 2.9

import 'dart:convert';

List<Oxygen> OxygenFromMap(String str) =>
    List<Oxygen>.from(json.decode(str).map((x) => Oxygen.fromMap(x)));

String OxygenToMap(List<Oxygen> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Oxygen {
  Oxygen({
    this.place,
    this.phone,
  });

  String place;
  String phone;

  factory Oxygen.fromMap(Map<String, dynamic> json) => Oxygen(
        place: json["Place"],
        phone: json["Phone"],
      );

  Map<String, dynamic> toMap() => {
        "Place": place,
        "Phone": phone,
      };
}
