// To parse this JSON data, do
//
//     final facilityData = facilityDataFromJson(jsonString);

import 'dart:convert';

List<FacilityData> facilityDataFromJson(String str) => List<FacilityData>.from(
    json.decode(str).map((x) => FacilityData.fromJson(x)));

String facilityDataToJson(List<FacilityData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FacilityData {
  int id;
  String facilityName;
  String pricePerHour;
  int hospital;

  FacilityData({
    this.id,
    this.facilityName,
    this.pricePerHour,
    this.hospital,
  });

  FacilityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    facilityName = json['facility_name'];
    pricePerHour = json['price_per_hour'];
    hospital = json['hospital'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['facility_name'] = this.facilityName;
    data['price_per_hour'] = this.pricePerHour;
    data['hospital'] = this.hospital;
    return data;
  }
}
