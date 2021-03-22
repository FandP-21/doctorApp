import 'package:flutter/cupertino.dart';

class Vitals {
  int id;
  String severity;
  String bp;
  String bmi;
  String pulse;
  String bloodOxygen;
  String temperature;
  String height;
  String weight;
  String dateLogged;
  bool selfRecord;
  String dateLastModified;
  int patient;

  Vitals(
      {this.id,
      this.severity,
      this.bp,
      this.bmi,
      this.pulse,
      this.bloodOxygen,
      this.temperature,
      this.height,
      this.weight,
      this.dateLogged,
      this.selfRecord,
      this.dateLastModified,
      this.patient});
  Vitals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    severity = json['severity'] ?? 'N/A';
    bp = json['severity'] ?? 'N/A';
    bmi = json['bmi'] ?? 'N/A';
    pulse = json['pulse'] ?? 'N/A';
    bloodOxygen = json['blood_oxygen'] ?? 'N/A';
    temperature = json['temperature'] ?? 'N/A';
    height = json['height'] ?? 'N/A';
    weight = json['weight'] ?? 'N/A';
    dateLogged = json['date_logged'] ?? 'N/A';
    selfRecord = json['self_record'];
    dateLastModified = json['date_last_modified'];
    patient = json['patient'];
  }
}
