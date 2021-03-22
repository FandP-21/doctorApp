import 'package:thcDoctorMobile/models/areaOfSpecialization.dart';
import 'package:thcDoctorMobile/models/doctor.dart';
import 'package:thcDoctorMobile/models/hmo.dart';
import 'package:thcDoctorMobile/models/hospital.dart';
import 'package:thcDoctorMobile/models/prescription.dart';
import 'package:thcDoctorMobile/models/vitals.dart';

class PatientInfo {
  int id;
  List<MedicalRecord> medicalRecord;
  List<Symptom> symptom;
  List<Diagnosis> diagnosis;
  List<Prescription_> prescription;
  List<Doctor> doctor;
  List<PatientHistory> patientHistory;
  List<Vitals> patientVital;
  List<PatientDocument> patientDocument;
  List<LabTesti> labTesti;
  List<HospitalNotes> hospitalNotes;
  List<HospitalLogs> hospitalLogs;
  List<Hospital> hospitals;
  User user;
  String patientType;
  int validity;
  String middleName;
  int age;
  int patientId;
  String gender;
  String occupation;
  String maritalStatus;
  String address;
  String dateOfBirth;
  String religion;
  String photo =
      'https://res.cloudinary.com/adminixtrator/image/upload/v1605277853/icons8-user-male-64.png';
  String registrationDate;
  bool isActive;
  String nextOfKinName;
  String status;
  String bmi;
  String tribe;
  String facebookUrl;
  String twitterUrl;
  String instagramUrl;
  String languages;
  String phoneNumber;
  String bloodGroup;
  String haemoglobinGenotype;
  String bloodSugar;
  String allergies;
  String hospital;
  String hmoSubscriptionNo;
  String hmoExpiryDate;
  String nextOfKinAddress;
  String nextOfKinEmailAddress;
  String nextOfKinPhoneNumber;
  String existingConditions;
  String ninNumber;
  String passportNumber;
  String driversLicense;
  String height;
  String weight;
  String bp;
  String bloodOxygen;
  String pulse;
  String temperature;
  String familyDiseaseHistory;
  String referralCode;
  // List<Null> laboratory;
  // List<AllHmo> hmo;

  PatientInfo(
      {this.id,
      this.medicalRecord,
      this.symptom,
      this.diagnosis,
      this.prescription,
      this.doctor,
      this.patientHistory,
      this.patientVital,
      this.patientDocument,
      this.labTesti,
      this.hospitalNotes,
      this.hospitalLogs,
      this.hospitals,
      this.user,
      this.patientType,
      this.validity,
      this.middleName,
      this.age,
      this.patientId,
      this.gender,
      this.occupation,
      this.maritalStatus,
      this.address,
      this.dateOfBirth,
      this.religion,
      this.registrationDate,
      this.isActive,
      nextOfKinName,
      status,
      bmi,
      tribe,
      facebookUrl,
      twitterUrl,
      instagramUrl,
      languages,
      phoneNumber,
      bloodGroup,
      haemoglobinGenotype,
      bloodSugar,
      allergies,
      hospital,
      hmoSubscriptionNo,
      hmoExpiryDate,
      nextOfKinAddress,
      nextOfKinEmailAddress,
      nextOfKinPhoneNumber,
      existingConditions,
      ninNumber,
      passportNumber,
      driversLicense,
      height,
      weight,
      bp,
      bloodOxygen,
      pulse,
      temperature,
      familyDiseaseHistory,
      referralCode});

  PatientInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['medical_record'] != null) {
      medicalRecord = new List<MedicalRecord>();
      json['medical_record'].forEach((v) {
        medicalRecord.add(new MedicalRecord.fromJson(v));
      });
    }
    if (json['symptom'] != null) {
      symptom = new List<Symptom>();
      json['symptom'].forEach((v) {
        symptom.add(new Symptom.fromJson(v));
      });
    }
    if (json['diagnosis'] != null) {
      diagnosis = new List<Diagnosis>();
      json['diagnosis'].forEach((v) {
        diagnosis.add(new Diagnosis.fromJson(v));
      });
    }
    if (json['prescription'] != null) {
      prescription = new List<Prescription_>();
      json['prescription'].forEach((v) {
        prescription.add(new Prescription_.fromJson(v));
      });
    }
    if (json['doctor'] != null) {
      doctor = new List<Doctor>();
      json['doctor'].forEach((v) {
        doctor.add(new Doctor.fromJson(v));
      });
    }
    if (json['patient_history'] != null) {
      patientHistory = new List<PatientHistory>();
      json['patient_history'].forEach((v) {
        patientHistory.add(new PatientHistory.fromJson(v));
      });
    }
    if (json['patient_vital'] != null) {
      patientVital = new List<Vitals>();
      json['patient_vital'].forEach((v) {
        patientVital.add(new Vitals.fromJson(v));
      });
    }
    if (json['patient_document'] != null) {
      patientDocument = new List<PatientDocument>();
      json['patient_document'].forEach((v) {
        patientDocument.add(new PatientDocument.fromJson(v));
      });
    }
    if (json['lab_testi'] != null) {
      labTesti = new List<LabTesti>();
      json['lab_testi'].forEach((v) {
        labTesti.add(new LabTesti.fromJson(v));
      });
    }
    if (json['hospital_notes'] != null) {
      hospitalNotes = new List<HospitalNotes>();
      json['hospital_notes'].forEach((v) {
        hospitalNotes.add(new HospitalNotes.fromJson(v));
      });
    }
    if (json['hospital_logs'] != null) {
      hospitalLogs = new List<HospitalLogs>();
      json['hospital_logs'].forEach((v) {
        hospitalLogs.add(new HospitalLogs.fromJson(v));
      });
    }
    if (json['hospitals'] != null) {
      hospitals = new List<Hospital>();
      json['hospitals'].forEach((v) {
        hospitals.add(new Hospital.fromJson(v));
      });
    }
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    patientType = json['patient_type'];
    validity = json['validity'];
    middleName = json['middle_name'];
    age = json['age'];
    patientId = json['patient_id'];
    gender = json['gender'];
    occupation = json['occupation'];
    maritalStatus = json['marital_status'];
    address = json['address'];
    dateOfBirth = json['date_of_birth'];
    religion = json['religion'];
    if (json['photo'] != null) {
      photo = 'https://thc2020.herokuapp.com' + json['photo'];
    }
    registrationDate = json['registration_date'] ?? '';
    isActive = json['is_active'] ?? '';
    nextOfKinName = json['next_of_kin_name'] ?? '';
    status = json['status'] ?? '';
    bmi = json['bmi'] ?? '';
    tribe = json['tribe'] ?? '';
    facebookUrl = json['facebook_url'] ?? '';
    twitterUrl = json['twitter_url'] ?? '';
    instagramUrl = json['instagram_url'] ?? '';
    languages = json['languages'] ?? '';
    phoneNumber = json['phone_number'] ?? '';
    bloodGroup = json['blood_group'] ?? '';
    haemoglobinGenotype = json['haemoglobin_genotype'] ?? '';
    bloodSugar = json['blood_sugar'] ?? '';
    allergies = json['allergies'] ?? '';
    hospital = json['hospital'] ?? '';
    hmoSubscriptionNo = json['hmo_subscription_no'] ?? '';
    hmoExpiryDate = json['hmo_expiry_date'] ?? '';
    nextOfKinAddress = json['next_of_kin_address'] ?? '';
    nextOfKinEmailAddress = json['next_of_kin_email_address'] ?? '';
    nextOfKinPhoneNumber = json['next_of_kin_phone_number'] ?? '';
    existingConditions = json['existing_conditions'] ?? '';
    ninNumber = json['nin_number'] ?? '';
    passportNumber = json['passport_number'] ?? '';
    driversLicense = json['drivers_license'] ?? '';
    height = json['height'];
    weight = json['weight'];
    bp = json['bp'] ?? 'N/A';
    bloodOxygen = json['blood_oxygen'] ?? 'N/A';
    pulse = json['pulse'] ?? 'N/A';
    temperature = json['temperature'] ?? 'N/A';
    familyDiseaseHistory = json['family_disease_history'] ?? '';
    referralCode = json['referral_code'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.medicalRecord != null) {
      data['medical_record'] =
          this.medicalRecord.map((v) => v.toJson()).toList();
    }
    if (this.symptom != null) {
      data['symptom'] = this.symptom.map((v) => v.toJson()).toList();
    }
    if (this.diagnosis != null) {
      data['diagnosis'] = this.diagnosis.map((v) => v.toJson()).toList();
    }
    if (this.prescription != null) {
      data['prescription'] = this.prescription.map((v) => v.toJson()).toList();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor.map((v) => v.toJson()).toList();
    }
    if (this.patientHistory != null) {
      data['patient_history'] =
          this.patientHistory.map((v) => v.toJson()).toList();
    }
    // if (this.patientVital != null) {
    //   data['patient_vital'] = this.patientVital.map((v) => v.toJson()).toList();
    // }
    if (this.patientDocument != null) {
      data['patient_document'] =
          this.patientDocument.map((v) => v.toJson()).toList();
    }
    if (this.labTesti != null) {
      data['lab_testi'] = this.labTesti.map((v) => v.toJson()).toList();
    }
    if (this.hospitalNotes != null) {
      data['hospital_notes'] =
          this.hospitalNotes.map((v) => v.toJson()).toList();
    }
    if (this.hospitalLogs != null) {
      data['hospital_logs'] = this.hospitalLogs.map((v) => v.toJson()).toList();
    }
    if (this.hospitals != null) {
      data['hospitals'] = this.hospitals.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['patient_type'] = this.patientType;
    data['validity'] = this.validity;
    data['middle_name'] = this.middleName;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['occupation'] = this.occupation;
    data['marital_status'] = this.maritalStatus;
    data['address'] = this.address;
    data['date_of_birth'] = this.dateOfBirth;
    data['religion'] = this.religion;
    data['registration_date'] = this.registrationDate;
    data['is_active'] = this.isActive;
    data['next_of_kin_name'] = this.nextOfKinName;
    data['status'] = this.status;
    data['bmi'] = this.bmi;
    data['tribe'] = this.tribe;
    data['facebook_url'] = this.facebookUrl;
    data['twitter_url'] = this.twitterUrl;
    data['instagram_url'] = this.instagramUrl;
    data['languages'] = this.languages;
    data['phone_number'] = this.phoneNumber;
    data['blood_group'] = this.bloodGroup;
    data['haemoglobin_genotype'] = this.haemoglobinGenotype;
    data['blood_sugar'] = this.bloodSugar;
    data['allergies'] = this.allergies;
    data['hospital'] = this.hospital;
    data['hmo_subscription_no'] = this.hmoSubscriptionNo;
    data['hmo_expiry_date'] = this.hmoExpiryDate;
    data['next_of_kin_address'] = this.nextOfKinAddress;
    data['next_of_kin_email_address'] = this.nextOfKinEmailAddress;
    data['next_of_kin_phone_number'] = this.nextOfKinPhoneNumber;
    data['existing_conditions'] = this.existingConditions;
    data['nin_number'] = this.ninNumber;
    data['passport_number'] = this.passportNumber;
    data['drivers_license'] = this.driversLicense;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['bp'] = this.bp;
    data['blood_oxygen'] = this.bloodOxygen;
    data['pulse'] = this.pulse;
    data['temperature'] = this.temperature;
    data['family_disease_history'] = this.familyDiseaseHistory;
    data['referral_code'] = this.referralCode;
    return data;
  }
}

class MedicalRecord {
  int id;
  String severity;
  String date_logged;
  String activity_date;
  String doctors_notes;
  int patient;
  int doctor;

  MedicalRecord(
      {this.id,
      this.severity,
      this.date_logged,
      this.activity_date,
      this.doctors_notes,
      this.patient,
      this.doctor});

  MedicalRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    severity = json['severity'] ?? '';
    date_logged = json['date_logged'] ?? '';
    activity_date = json['activity_date'] ?? '';
    doctors_notes = json['doctors_notes'] ?? '';
    patient = json['patient'];
    doctor = json['doctor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['severity'] = this.severity;
    data['date_logged'] = this.date_logged;
    data['activity_date'] = this.activity_date;
    data['doctors_notes'] = this.doctors_notes;
    data['patient'] = this.patient;
    data['doctor'] = this.doctor;
    return data;
  }
}

class Symptom {
  int id;
  String category;
  String date_logged;
  String title;
  String doctors_notes;
  int patient;
  int doctor;

  Symptom(
      {this.id,
      this.category,
      this.date_logged,
      this.title,
      this.doctors_notes,
      this.patient,
      this.doctor});

  Symptom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] ?? '';
    date_logged = json['date_logged'] ?? '';
    title = json['title'] ?? '';
    doctors_notes = json['doctors_notes'] ?? '';
    patient = json['patient'];
    doctor = json['doctor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['date_logged'] = this.date_logged;
    data['title'] = this.title;
    data['doctors_notes'] = this.doctors_notes;
    data['patient'] = this.patient;
    data['doctor'] = this.doctor;
    return data;
  }
}

class Diagnosis {
  int id;
  String dateLogged;
  String title;
  String generalDiagnosis;
  String investigationResult;
  String clinicalSummary;
  String doctorsNotes;
  int patient;
  int doctor;

  Diagnosis(
      {this.id,
      this.dateLogged,
      this.title,
      this.generalDiagnosis,
      this.investigationResult,
      this.clinicalSummary,
      this.doctorsNotes,
      this.patient,
      this.doctor});

  Diagnosis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateLogged = json['date_logged'] ?? '';
    title = json['title'] ?? '';
    generalDiagnosis = json['general_diagnosis'] ?? 'N/A';
    investigationResult = json['investigation_result'] ?? 'N/A';
    clinicalSummary = json['clinical_summary'] ?? 'N/A';
    doctorsNotes = json['doctors_notes'] ?? 'N/A';
    patient = json['patient'];
    doctor = json['doctor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_logged'] = this.dateLogged;
    data['title'] = this.title;
    data['general_diagnosis'] = this.generalDiagnosis;
    data['investigation_result'] = this.investigationResult;
    data['clinical_summary'] = this.clinicalSummary;
    data['doctors_notes'] = this.doctorsNotes;
    data['patient'] = this.patient;
    data['doctor'] = this.doctor;
    return data;
  }
}

class TreatmentCategory {
  int id;
  String name;

  TreatmentCategory({this.id, this.name});

  TreatmentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Drugs {
  int id;
  String name;
  String drugDivision;
  double price;
  int drugType;
  String dosage;
  String unit;
  String frequency;
  String noOfTablets;
  int patient;
  int drug;

  Drugs({this.id, this.name, this.drugDivision, this.price, this.drugType});

  Drugs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    drugDivision = json['drug_division'];
    price = json['price'];
    drugType = json['drug_type'];
    dosage = json['dosage'] ?? 'N/A';
    unit = json['unit'] ?? 'N/A';
    frequency = json['frequency'] ?? 'N/A';
    noOfTablets = json['no_of_tablets'] ?? 'N/A';
    patient = json['patient'];
    drug = json['drug'];
  }
}

class PatientHistory {
  int id;
  String severity;
  String notes;
  String date_logged;
  String date_last_modified;
  int patient;

  PatientHistory(
      {this.id,
      this.severity,
      this.notes,
      this.date_logged,
      this.date_last_modified,
      this.patient});

  PatientHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    severity = json['severity'] ?? '';
    notes = json['notes'] ?? '';
    date_logged = json['date_logged'] ?? '';
    date_last_modified = json['date_last_modified'] ?? '';
    patient = json['patient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['severity'] = this.severity;
    data['notes'] = this.notes;
    data['date_logged'] = this.date_logged;
    data['date_last_modified'] = this.date_last_modified;
    data['patient'] = this.patient;
    return data;
  }
}

class PatientDocument {
  int id;
  String name;
  String document;
  String date_logged;

  PatientDocument({this.id, this.name, this.document, this.date_logged});

  PatientDocument.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    document = json['document'];
    date_logged = json['date_logged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['document'] = this.document;
    data['date_logged'] = this.date_logged;
    return data;
  }
}

class LabTesti {
  int patient;
  int laboratory;
  TestName test_name;
  TreatmentCategory category;
  // List<TestResult> test_result;
  String test_result;

  LabTesti(
      {this.patient,
      this.laboratory,
      this.test_name,
      this.category,
      this.test_result});

  LabTesti.fromJson(Map<String, dynamic> json) {
    patient = json['patient'];
    laboratory = json['laboratory'];
    test_name = json['test_name'] != {} && json['test_name'] != null
        ? new TestName.fromJson(json['test_name'])
        : null;
    category = json['category'] != {} && json['category'] != null
        ? new TreatmentCategory.fromJson(json['category'])
        : null;
    test_result = json['test_result'];
    // if (json['test_result'] != null && json['test_result'] != []) {
    //   test_result = new List<TestResult>();
    //   json['test_result'].forEach((v) {
    //     test_result.add(new TestResult.fromJson(v));
    //   });
    // } else {
    //   test_result = [TestResult(id: 1, name: "N/A", value: "None")];
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient'] = this.patient;
    data['laboratory'] = this.laboratory;
    if (this.test_name != null) {
      data['test_name'] = this.test_name.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    // if (this.test_result != null) {
    //   data['test_result'] = this.test_result.map((v) => v.toJson()).toList();
    // }
    data['test_result'] = this.test_result;

    return data;
  }
}

class TestName {
  int id;
  String name;
  int service;

  TestName({this.id, this.name, this.service});

  TestName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['service'] = this.service;
    return data;
  }
}

class TestResult {
  int id;
  String name;
  String value;

  TestResult({this.id, this.name, this.value});

  TestResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class HospitalNotes {
  int id;
  String referral_notes;
  String doctor_notes;
  String discharge_instructions;
  String date_logged;
  String date_last_modified;
  int hospital;
  Doctor doctor;
  int patient;

  HospitalNotes(
      {this.id,
      this.referral_notes,
      this.doctor_notes,
      this.discharge_instructions,
      this.date_logged,
      this.date_last_modified,
      this.hospital,
      this.doctor,
      this.patient});

  HospitalNotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referral_notes = json['referral_notes'] ?? '';
    doctor_notes = json['doctor_notes'] ?? '';
    discharge_instructions = json['discharge_instructions'] ?? '';
    date_logged = json['date_logged'] ?? '';
    date_last_modified = json['date_last_modified'] ?? '';
    hospital = json['hospital'] ?? '';
    doctor = Doctor.fromJson(json['doctor']);
    patient = json['patient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['referral_notes'] = this.referral_notes;
    data['doctor_notes'] = this.doctor_notes;
    data['discharge_instructions'] = this.discharge_instructions;
    data['date_logged'] = this.date_logged;
    data['date_last_modified'] = this.date_last_modified;
    data['hospital'] = this.hospital;
    data['doctor'] = this.doctor;
    data['patient'] = this.patient;
    return data;
  }
}

class HospitalLogs {
  int id;
  String call_logs;
  String photos;
  String date_logged;
  String date_last_modified;
  int hospital;
  int doctor;
  int patient;

  HospitalLogs(
      {this.id,
      this.call_logs,
      this.photos,
      this.date_logged,
      this.date_last_modified,
      this.hospital,
      this.doctor,
      this.patient});

  HospitalLogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    call_logs = json['call_logs'] ?? '';
    photos = json['photos'] ?? '';
    date_logged = json['date_logged'] ?? '';
    date_last_modified = json['date_last_modified'] ?? '';
    hospital = json['hospital'] ?? '';
    doctor = json['doctor'];
    patient = json['patient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['call_logs'] = this.call_logs;
    data['photos'] = this.photos;
    data['date_logged'] = this.date_logged;
    data['date_last_modified'] = this.date_last_modified;
    data['hospital'] = this.hospital;
    data['doctor'] = this.doctor;
    data['patient'] = this.patient;
    return data;
  }
}

class User {
  String email;
  String username;
  String password;
  String first_name;
  String last_name;
  int id;
  String get name => first_name + ' ' + last_name;

  User(
      {this.email,
      this.username,
      this.password,
      this.first_name,
      this.last_name,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    password = json['password'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    data['first_name'] = this.first_name;
    data['last_name'] = this.last_name;
    data['id'] = this.id;
    return data;
  }
}
