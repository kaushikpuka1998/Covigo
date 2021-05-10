//@dart =2.9

import 'dart:convert';

List<Doctor> DoctorFromMap(String str) =>
    List<Doctor>.from(json.decode(str).map((x) => Doctor.fromMap(x)));

String DoctorToMap(List<Doctor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Doctor {
  Doctor({
    this.name,
    this.phone,
    this.region,
  });

  String name;
  dynamic phone;
  String region;

  factory Doctor.fromMap(Map<String, dynamic> json) => Doctor(
        name: json["Name"],
        phone: json["Phone"],
        region: json["Region"],
      );

  Map<String, dynamic> toMap() => {
        "Name": name,
        "Phone": phone,
        "Region": region,
      };
}
