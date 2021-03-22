import 'medicalRecord.dart';
import 'symptom.dart';
import 'doctor.dart';
import 'user.dart';
import 'diagnosis.dart';
import 'prescription.dart';

class Patient {
  int id;
  List<MedicalRecord> medicalRecord;
  List<Symptom> symptom;
  List<Diagnosis> diagnosis;
  List<Prescription_> prescription;
  List<Doctor> doctor;
  User user;
  String patientType;
  int validity;
  String status;
  String middleName;
  int age;
  String firebaseId;
  String gender;
  String occupation;
  String maritalStatus;
  String address;
  String bmi;
  String dateOfBirth;
  String religion;
  String photo =
      'https://res.cloudinary.com/adminixtrator/image/upload/v1605277853/icons8-user-male-64.png';
  String tribe;
  String registrationDate;
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
  bool isActive;
  String hmoSubscriptionNo;
  String hmoExpiryDate;
  String nextOfKinName;
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
  List<dynamic> laboratory;
  List<dynamic> hmo;

  Patient(
      {this.id,
      this.medicalRecord,
      this.symptom,
      this.diagnosis,
      this.prescription,
      this.doctor,
      this.user,
      this.patientType,
      this.validity,
      this.status,
      this.middleName,
      this.age,
      this.firebaseId,
      this.gender,
      this.occupation,
      this.maritalStatus,
      this.address,
      this.bmi,
      this.dateOfBirth,
      this.religion,
      this.photo,
      this.tribe,
      this.registrationDate,
      this.facebookUrl,
      this.twitterUrl,
      this.instagramUrl,
      this.languages,
      this.phoneNumber,
      this.bloodGroup,
      this.haemoglobinGenotype,
      this.bloodSugar,
      this.allergies,
      this.hospital,
      this.isActive,
      this.hmoSubscriptionNo,
      this.hmoExpiryDate,
      this.nextOfKinName,
      this.nextOfKinAddress,
      this.nextOfKinEmailAddress,
      this.nextOfKinPhoneNumber,
      this.existingConditions,
      this.ninNumber,
      this.passportNumber,
      this.driversLicense,
      this.height,
      this.weight,
      this.bp,
      this.bloodOxygen,
      this.pulse,
      this.temperature,
      this.familyDiseaseHistory,
      this.referralCode,
      this.laboratory,
      this.hmo});

  Patient.fromJson(Map<String, dynamic> json) {
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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    firebaseId = json['firebase_id'];
    patientType = json['patient_type'];
    validity = json['validity'];
    status = json['status'];
    middleName = json['middle_name'];
    age = json['age'];
    gender = json['gender'];
    occupation = json['occupation'];
    maritalStatus = json['marital_status'];
    address = json['address'];
    bmi = json['bmi'];
    dateOfBirth = json['date_of_birth'];
    religion = json['religion'];
    if (json['photo'] != null && json['photo'] != '') {
      photo = 'https://thc2020.herokuapp.com' + json['photo'];
    } else {
      json['photo'] = '';
    }
    tribe = json['tribe'];
    registrationDate = json['registration_date'];
    facebookUrl = json['facebook_url'];
    twitterUrl = json['twitter_url'];
    instagramUrl = json['instagram_url'];
    languages = json['languages'];
    phoneNumber = json['phone_number'];
    bloodGroup = json['blood_group'];
    haemoglobinGenotype = json['haemoglobin_genotype'];
    bloodSugar = json['blood_sugar'];
    allergies = json['allergies'];
    hospital = json['hospital'];
    isActive = json['is_active'];
    hmoSubscriptionNo = json['hmo_subscription_no'];
    hmoExpiryDate = json['hmo_expiry_date'];
    nextOfKinName = json['next_of_kin_name'];
    nextOfKinAddress = json['next_of_kin_address'];
    nextOfKinEmailAddress = json['next_of_kin_email_address'];
    nextOfKinPhoneNumber = json['next_of_kin_phone_number'];
    existingConditions = json['existing_conditions'];
    ninNumber = json['nin_number'];
    passportNumber = json['passport_number'];
    driversLicense = json['drivers_license'];
    height = json['height'] ?? "N/A ";
    weight = json['weight'] ?? "N/A ";
    bp = json['bp'];
    bloodOxygen = json['blood_oxygen'];
    pulse = json['pulse'];
    temperature = json['temperature'];
    familyDiseaseHistory = json['family_disease_history'];
    referralCode = json['referral_code'];
    laboratory = null;
    hmo = null;
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
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['patient_type'] = this.patientType;
    data['validity'] = this.validity;
    data['status'] = this.status;
    data['middle_name'] = this.middleName;
    data['age'] = this.age;
    data['firebase_id'] = this.firebaseId;
    data['gender'] = this.gender;
    data['occupation'] = this.occupation;
    data['marital_status'] = this.maritalStatus;
    data['address'] = this.address;
    data['bmi'] = this.bmi;
    data['date_of_birth'] = this.dateOfBirth;
    data['religion'] = this.religion;
    data['photo'] = this.photo;
    data['tribe'] = this.tribe;
    data['registration_date'] = this.registrationDate;
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
    data['is_active'] = this.isActive;
    data['hmo_subscription_no'] = this.hmoSubscriptionNo;
    data['hmo_expiry_date'] = this.hmoExpiryDate;
    data['next_of_kin_name'] = this.nextOfKinName;
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
    data['laboratory'] = this.laboratory;
    data['hmo'] = this.hmo;

    return data;
  }
}
