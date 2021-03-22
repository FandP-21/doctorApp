import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'doctor.dart';
import 'hospital.dart';
import 'patient.dart';
import 'areaOfSpecialization.dart';

class Appointment {
  int id;
  Patient patient;
  Doctor doctor;
  Hospital hospital;
  String location;
  String status;
  String sessionType;
  String preferredTime;
  String estimatedDuration;
  String description;
  bool callRecording;
  String date;
  String startTime;
  String endTime;
  int hmo;

  Appointment(
      {this.id,
      this.patient,
      this.doctor,
      this.hospital,
      this.location,
      this.status,
      this.sessionType,
      this.preferredTime,
      this.estimatedDuration,
      this.description,
      this.callRecording,
      this.date,
      this.startTime,
      this.endTime,
      this.hmo});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patient = json['patient'] != null && json['patient'] is! int
        ? new Patient.fromJson(json['patient'])
        : null;
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    hospital = json['hospital'] != null && json['hospital'] is! int
        ? new Hospital.fromJson(json['hospital'])
        : null;
    location = json['location'] ?? 'N/A';
    status = json['status'] ?? 'N/A';
    sessionType = json['session_type'] ?? "N/A";
    preferredTime = json['preferred_time'] ?? "N/A";
    estimatedDuration = json['estimated_duration'] ?? 'N/A';
    description = json['description'] ?? 'N/A';
    callRecording = json['call_recording'] ?? false;
    date = json['date'] ?? 'N/A';
    startTime = json['start_time'] ?? 'N/A';
    endTime = json['end_time'] ?? 'N/A';
    hmo = json['hmo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor.toJson();
    }
    if (this.hospital != null) {
      data['hospital'] = this.hospital.toJson();
    }
    data['location'] = this.location;
    data['status'] = this.status;
    data['session_type'] = this.sessionType;
    data['preferred_time'] = this.preferredTime;
    data['estimated_duration'] = this.estimatedDuration;
    data['description'] = this.description;
    data['call_recording'] = this.callRecording;
    data['date'] = this.date;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['hmo'] = this.hmo;
    return data;
  }
}
