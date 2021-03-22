import 'package:thcDoctorMobile/models/patient.dart';
import 'user.dart';

class Hospital {
  int id;
  User user;
  var rating;
  String officeAddress;
  String cacNumber;
  String annualPractisingLicense;
  String websiteUrl;
  String facebookUrl;
  String twitterUrl;
  String instagramUrl;
  String phoneNumber;
  bool isActive;
  String mondayFromHour;
  String mondayToHour;
  String tuesdayFromHour;
  String tuesdayToHour;
  String wednesdayFromHour;
  String wednesdayToHour;
  String thursdayFromHour;
  String thursdayToHour;
  String fridayFromHour;
  String fridayToHour;
  String saturdayFromHour;
  String saturdayToHour;
  String sundayFromHour;
  String sundayToHour;
  String bio;
  String emergencyLines;
  List<dynamic> patients;
  List<dynamic> areasOfSpecialization;
  List<dynamic> hospitalBranch;

  Hospital(
      {this.id,
      this.user,
      this.rating,
      this.officeAddress,
      this.cacNumber,
      this.annualPractisingLicense,
      this.websiteUrl,
      this.facebookUrl,
      this.twitterUrl,
      this.instagramUrl,
      this.phoneNumber,
      this.isActive,
      this.mondayFromHour,
      this.mondayToHour,
      this.tuesdayFromHour,
      this.tuesdayToHour,
      this.wednesdayFromHour,
      this.wednesdayToHour,
      this.thursdayFromHour,
      this.thursdayToHour,
      this.fridayFromHour,
      this.fridayToHour,
      this.saturdayFromHour,
      this.saturdayToHour,
      this.sundayFromHour,
      this.sundayToHour,
      this.bio,
      this.emergencyLines,
      this.patients,
      this.areasOfSpecialization,
      this.hospitalBranch});

  Hospital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != String ? new User.fromJson(json['user']) : String;
    rating = json['rating'];
    officeAddress = json['office_address'];
    cacNumber = json['cac_number'];
    annualPractisingLicense = json['annual_practising_license'];
    websiteUrl = json['website_url'];
    facebookUrl = json['facebookUrl'];
    twitterUrl = json['twitterUrl'];
    instagramUrl = json['instagram_url'];
    phoneNumber = json['phone_number'];
    isActive = json['is_active'];
    mondayFromHour = json['monday_from_hour'] ?? '';
    mondayToHour = json['monday_to_hour'] ?? '';
    tuesdayFromHour = json['tuesday_from_hour'] ?? '';
    tuesdayToHour = json['tuesday_to_hour'] ?? '';
    wednesdayFromHour = json['wednesday_from_hour'] ?? '';
    wednesdayToHour = json['wednesday_to_hour'] ?? '';
    thursdayFromHour = json['thursday_from_hour'] ?? '';
    thursdayToHour = json['thursday_to_hour'] ?? '';
    fridayFromHour = json['friday_from_hour'] ?? '';
    fridayToHour = json['friday_to_hour'] ?? '';
    saturdayFromHour = json['saturday_from_hour'] ?? '';
    saturdayToHour = json['saturday_to_hour'] ?? '';
    sundayFromHour = json['sunday_from_hour'] ?? '';
    sundayToHour = json['sunday_to_hour'] ?? '';
    bio = json['bio'] ?? '';
    emergencyLines = json['emergency_lines'];
    if (json['patients'] != []) {
      patients = json['patients'];
    } else {
      patients = [Patient()];
    }
    areasOfSpecialization = json['areas_of_specialization'];
    hospitalBranch = json['hospital_branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != String) {
      data['user'] = this.user.toJson();
    }
    data['rating'] = this.rating;
    data['office_address'] = this.officeAddress;
    data['cac_number'] = this.cacNumber;
    data['annual_practising_license'] = this.annualPractisingLicense;
    data['website_url'] = this.websiteUrl;
    data['facebookUrl'] = this.facebookUrl;
    data['twitterUrl'] = this.twitterUrl;
    data['instagram_url'] = this.instagramUrl;
    data['phone_number'] = this.phoneNumber;
    data['is_active'] = this.isActive;
    data['monday_from_hour'] = this.mondayFromHour;
    data['monday_to_hour'] = this.mondayToHour;
    data['tuesday_from_hour'] = this.tuesdayFromHour;
    data['tuesday_to_hour'] = this.tuesdayToHour;
    data['wednesday_from_hour'] = this.wednesdayFromHour;
    data['wednesday_to_hour'] = this.wednesdayToHour;
    data['thursday_from_hour'] = this.thursdayFromHour;
    data['thursday_to_hour'] = this.thursdayToHour;
    data['friday_from_hour'] = this.fridayFromHour;
    data['friday_to_hour'] = this.fridayToHour;
    data['saturday_from_hour'] = this.saturdayFromHour;
    data['saturday_to_hour'] = this.saturdayToHour;
    data['sunday_from_hour'] = this.sundayFromHour;
    data['sunday_to_hour'] = this.sundayToHour;
    data['bio'] = this.bio;
    data['emergency_lines'] = this.emergencyLines;
    data['patients'] = this.patients;
    data['areas_of_specialization'] = this.areasOfSpecialization;
    data['hospital_branch'] = this.hospitalBranch;
    return data;
  }
}
