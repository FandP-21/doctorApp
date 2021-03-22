import 'package:thcDoctorMobile/models/patient.dart';

class PrescriptionRequest {
  int id;
  Patient patient;
  String description;
  String medicationName;
  String strength;
  String quantity;
  String date;
  String request;
  int doctor;
  int hospital;

  PrescriptionRequest(
      {this.id,
      this.patient,
      this.description,
      this.medicationName,
      this.strength,
      this.quantity,
      this.date,
      this.request,
      this.doctor,
      this.hospital});

  PrescriptionRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patient = json['patient'] != null && json['patient'] is! int
        ? new Patient.fromJson(json['patient'])
        : null;
    description = json['description'] ?? 'N/A';
    medicationName = json['medication_name'] ?? 'N/A';
    strength = json['strength'] ?? 'N/A';
    quantity = json['quantity'] ?? 'N/A';
    date = json['date'] ?? 'N/A';
    request = json['request'] ?? 'N/A';
    doctor = json['doctor'];
    hospital = json['hospital'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    data['description'] = this.description;
    data['medicationName'] = this.medicationName;
    data['strength'] = this.strength;
    data['quantity'] = this.quantity;
    data['date'] = this.date;
    data['request'] = this.request;
    data['doctor'] = this.doctor;
    data['hospital'] = this.hospital;
    return data;
  }
}
