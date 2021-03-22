class Diagnosis {
  int id;
  String dosage;
  String unit;
  String frequency;
  String noOfTablets;
  int doctor;
  int patient;
  List<int> drugs;

  Diagnosis(
      {this.id,
      this.dosage,
      this.unit,
      this.frequency,
      this.noOfTablets,
      this.doctor,
      this.patient,
      this.drugs});

  Diagnosis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dosage = json['dosage'];
    unit = json['unit'];
    frequency = json['frequency'];
    noOfTablets = json['no_of_tablets'];
    doctor = json['doctor'];
    patient = json['patient'];
    drugs = json['drugs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dosage'] = this.dosage;
    data['unit'] = this.unit;
    data['frequency'] = this.frequency;
    data['no_of_tablets'] = this.noOfTablets;
    data['doctor'] = this.doctor;
    data['patient'] = this.patient;
    data['drugs'] = this.drugs;
    return data;
  }
}
