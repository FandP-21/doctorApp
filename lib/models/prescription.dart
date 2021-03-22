import 'package:thcDoctorMobile/models/doctor.dart';
import 'package:thcDoctorMobile/models/patientInfo.dart';

class Prescription_ {
  int id;
  String dosage;
  String unit;
  String frequency;
  String noOfTablets;
  TreatmentCategory treatmentCategory;
  var doctor;
  var patient;
  List<dynamic> drugs;

  Prescription_(
      {this.id,
      this.dosage,
      this.unit,
      this.frequency,
      this.noOfTablets,
      this.treatmentCategory,
      this.doctor,
      this.patient,
      this.drugs});

  Prescription_.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    treatmentCategory = json['treatment_category'] != {}
        ? new TreatmentCategory.fromJson(json['treatment_category'])
        : null;
    dosage = json['dosage'];
    unit = json['unit'];
    frequency = json['frequency'];
    noOfTablets = json['no_of_tablets'];
    try {
      int a = json['doctor'] + 1;
      doctor = json['doctor'];
    } catch (e) {
      doctor =
          json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    }
    patient = json['patient'];
    drugs = json['drugs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.treatmentCategory != null) {
      data['treatment_category'] = this.treatmentCategory.toJson();
    }
    data['dosage'] = this.dosage;
    data['unit'] = this.unit;
    data['frequency'] = this.frequency;
    data['noOfTablets'] = this.noOfTablets;
    data['doctor'] = this.doctor;
    data['patient'] = this.patient;
    data['drugs'] = this.drugs;
    return data;
  }
}
