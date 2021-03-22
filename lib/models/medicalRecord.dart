class MedicalRecord {
  int id;
  String severity;
  String dateLogged;
  String activityDate;
  String doctorsNotes;
  int patient;
  int doctor;

  MedicalRecord(
      {this.id,
      this.severity,
      this.dateLogged,
      this.activityDate,
      this.doctorsNotes,
      this.patient,
      this.doctor});

  MedicalRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    severity = json['severity'];
    dateLogged = json['date_logged'];
    activityDate = json['activity_date'];
    doctorsNotes = json['doctors_notes'];
    patient = json['patient'];
    doctor = json['doctor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['severity'] = this.severity;
    data['date_logged'] = this.dateLogged;
    data['activity_date'] = this.activityDate;
    data['doctors_notes'] = this.doctorsNotes;
    data['patient'] = this.patient;
    data['doctor'] = this.doctor;
    return data;
  }
}
