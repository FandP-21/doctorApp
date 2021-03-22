import 'patient.dart';
import 'doctor.dart';
import 'hospital.dart';

class Request {
  int id;
  Patient patient;
  Doctor doctor;
  Hospital hospital;
  String location;
  String status;
  String preferredTime;
  String estimatedDuration;
  String description;
  String notes;
  String dateRequested;
  bool callRecording;
  String endTime;
  String sessionType;
  String startTime;
  String date;

  Request(
      {this.id,
      this.patient,
      this.doctor,
      this.hospital,
      this.location,
      this.status,
      this.sessionType,
      this.startTime,
      this.date,
      this.endTime,
      this.preferredTime,
      this.estimatedDuration,
      this.description,
      this.notes,
      this.dateRequested,
      this.callRecording});

  Request.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    hospital = json['hospital'] != null
        ? new Hospital.fromJson(json['hospital'])
        : null;
    location = json['location'];
    status = json['status'];
    preferredTime = json['preferred_time'];
    estimatedDuration = json['estimated_duration'];
    description = json['description'];
    callRecording = json['call_recording'];
    sessionType = json['session_type'] ?? 'N/A';
    date = json['date'] ?? '';
    startTime = json['start_time'] ?? "N/A";
    endTime = json['end_time'] ?? "N/A";
    notes = json['notes'];
    dateRequested = json['date_requested'];
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
    data['preferred_time'] = this.preferredTime;
    data['estimated_duration'] = this.estimatedDuration;
    data['description'] = this.description;
    data['call_recording'] = this.callRecording;
    data['session_type'] = sessionType;
    data['date'] = DateTime.friday;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['notes'] = this.notes;
    data['date_requested'] = this.dateRequested;
    return data;
  }
}
