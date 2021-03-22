import 'package:thcDoctorMobile/models/doctor.dart';
import 'package:thcDoctorMobile/models/patient.dart';

class Note {
  int id;
  Doctor doctor;
  String referralNotes;
  String doctorNotes;
  String dischargeInstructions;
  String dateLogged;
  String dateLastModified;
  int laboratory;
  int patient;
  int hospital;

  Note(
      {this.id,
      this.doctor,
      this.referralNotes,
      this.doctorNotes,
      this.dischargeInstructions,
      this.dateLogged,
      this.dateLastModified,
      this.laboratory,
      this.patient,
      this.hospital});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    referralNotes = json['referral_notes'] ?? 'N/A';
    doctorNotes = json['doctor_notes'] ?? 'N/A';
    dischargeInstructions = json['discharge_instructions'] ?? 'N/A';
    dateLogged = json['date_logged'] ?? 'N/A';
    dateLastModified = json['date_last_modified'] ?? 'N/A';
    laboratory = json['laboratory'];
    hospital = json['hospital'];
  }
}
