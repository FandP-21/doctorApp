import 'package:thcDoctorMobile/models/doctor.dart';
import 'package:thcDoctorMobile/models/patient.dart';
import 'package:thcDoctorMobile/models/patientInfo.dart';

class Medications {
  int id;
  Patient patient;
  var doctor;
  List<Drugs> drugSets;
  String name;
  String dateLogged;

  Medications(
      {this.id,
      this.name,
      this.dateLogged,
      this.patient,
      this.doctor,
      this.drugSets});

  Medications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? 'N/A';
    patient = json['patient'] != null && json['patient'] is! int
        ? new Patient.fromJson(json['patient'])
        : null;
    try {
      var a = json['doctor'] + 1;
      doctor = json['doctor'];
    } catch (e) {
      doctor =
          json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    }
    dateLogged = json['date_logged'] ?? 'N/A';
    if (json['drug_sets'] != null) {
      drugSets = new List<Drugs>();
      json['drug_sets'].forEach((v) {
        drugSets.add(new Drugs.fromJson(v));
      });
    }
  }
}
