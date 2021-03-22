import 'diseaseSpeciality.dart';

import 'areaOfSpecialization.dart';
import 'user.dart';
import 'hospital.dart';

class Doctor {
  int id;
  List<dynamic> session;
  List<AreaOfSpecialization> areaOfSpecialization;
  List<DiseaseSpeciality> diseaseSpeciality;
  User user;
  Hospital hospital;
  String status;
  var rating;
  var numberOfRatings;
  int age;
  String photo =
      'https://res.cloudinary.com/adminixtrator/image/upload/v1605277853/icons8-user-male-64.png';
  String languages;
  String facebookUrl;
  String twitterUrl;
  String instagramUrl;
  String phoneNumber;
  String mdcnLicenseNumber;
  bool isActive;
  int yearsInSpecialization;
  String bioInfoOnSpecialization;
  double rate;
  String location;
  String mondayFromHour;
  String mondayToHour;
  String firebaseId;
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

  Doctor(
      {this.id,
      this.session,
      this.areaOfSpecialization,
      this.diseaseSpeciality,
      this.user,
      this.hospital,
      this.status,
      this.rating,
      this.numberOfRatings,
      this.photo,
      this.age,
      this.languages,
      this.facebookUrl,
      this.twitterUrl,
      this.instagramUrl,
      this.phoneNumber,
      this.mdcnLicenseNumber,
      this.isActive,
      this.yearsInSpecialization,
      this.bioInfoOnSpecialization,
      this.rate,
      this.firebaseId,
      this.location,
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
      this.sundayToHour});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    session = json['session'];
    if (json['area_of_specialization'] != []) {
      areaOfSpecialization = new List<AreaOfSpecialization>();
      json['area_of_specialization'].forEach((v) {
        areaOfSpecialization.add(new AreaOfSpecialization.fromJson(v));
      });
    } else {
      areaOfSpecialization = [AreaOfSpecialization(id: 1, name: "NONE")];
    }
    if (json['diseases_speciality'] != []) {
      diseaseSpeciality = new List<DiseaseSpeciality>();
      json['area_of_specialization'].forEach((v) {
        diseaseSpeciality.add(new DiseaseSpeciality.fromJson(v));
      });
    } else {
      diseaseSpeciality = [DiseaseSpeciality(id: 1, name: "NONE")];
    }
    age = json['age'];
    user =
        json['user'] is! int && json['user'] != null && json['user'] != String
            ? new User.fromJson(json['user'])
            : null;
    hospital = json['hospital'] != null && json['hospital'] != {}
        ? new Hospital.fromJson(json['hospital'])
        : Hospital(
            bio: '',
          );
    status = json['status'];
    rating = json['rating'];
    numberOfRatings = json['number_of_ratings'];
    if (json['photo'] != null && json['photo'] != '') {
      photo = 'https://thc2020.herokuapp.com' + json['photo'];
    } else {
      json['photo'] = '';
    }
    languages = json['languages'];
    facebookUrl = json['facebook_url'];
    twitterUrl = json['twitter_url'];
    instagramUrl = json['instagram_url'];
    phoneNumber = json['phone_number'];
    mdcnLicenseNumber = json['mdcn_license_number'];
    isActive = json['is_active'];
    yearsInSpecialization = json['years_in_specialization'];
    bioInfoOnSpecialization = json['bio_info_on_specialization'];
    rate = json['rate'];
    firebaseId = json['firebase_id'];
    location = json['location'];
    mondayFromHour = json['monday_from_hour'];
    mondayToHour = json['monday_to_hour'];
    tuesdayFromHour = json['tuesday_from_hour'];
    tuesdayToHour = json['tuesday_to_hour'];
    wednesdayFromHour = json['wednesday_from_hour'];
    wednesdayToHour = json['wednesday_to_hour'];
    thursdayFromHour = json['thursday_from_hour'];
    thursdayToHour = json['thursday_to_hour'];
    fridayFromHour = json['friday_from_hour'];
    fridayToHour = json['friday_to_hour'];
    saturdayFromHour = json['saturday_from_hour'];
    saturdayToHour = json['saturday_to_hour'];
    sundayFromHour = json['sunday_from_hour'];
    sundayToHour = json['sunday_to_hour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['session'] = this.session;
    if (this.areaOfSpecialization != String) {
      data['area_of_specialization'] =
          this.areaOfSpecialization.map((v) => v.toJson()).toList();
    }
    if (this.diseaseSpeciality != String) {
      data['diseases_speciality'] =
          this.diseaseSpeciality.map((v) => v.toJson()).toList();
    }
    if (this.user != String) {
      data['user'] = this.user.toJson();
    }
    if (this.hospital != String) {
      data['hospital'] = this.hospital.toJson();
    }
    data['status'] = this.status;
    data['rating'] = this.rating;
    data['numberOfRating'] = this.rate;
    data['photo'] = this.photo;
    data['languages'] = this.languages;
    data['facebook_url'] = this.facebookUrl;
    data['twitter_url'] = this.twitterUrl;
    data['instagram_url'] = this.instagramUrl;
    data['phone_number'] = this.phoneNumber;
    data['mdcn_license_number'] = this.mdcnLicenseNumber;
    data['is_active'] = this.isActive;
    data['years_in_specialization'] = this.yearsInSpecialization;
    data['bio_info_on_specialization'] = this.bioInfoOnSpecialization;
    data['rate'] = this.rate;
    data['location'] = this.location;
    data['firebase_id'] = this.firebaseId;
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
    return data;
  }
}
