class Symptom {
  int id;
  String dateLogged;
  String title;
  String doctorsNotes;
  int patient;
  int doctor;

  Symptom(
      {this.id,
      this.dateLogged,
      this.title,
      this.doctorsNotes,
      this.patient,
      this.doctor});

  Symptom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateLogged = json['date_logged'];
    title = json['title'];
    doctorsNotes = json['doctors_notes'];
    patient = json['patient'];
    doctor = json['doctor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_logged'] = this.dateLogged;
    data['title'] = this.title;
    data['doctors_notes'] = this.doctorsNotes;
    data['patient'] = this.patient;
    data['doctor'] = this.doctor;
    return data;
  }
}
