class HospitalService {
  int id;
  List<String> hospitalSubServices;
  String name;

  HospitalService({this.id, this.hospitalSubServices, this.name});

  HospitalService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalSubServices = json['hospital_sub_services'].cast<String>();
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hospital_sub_services'] = this.hospitalSubServices;
    data['name'] = this.name;
    return data;
  }
}
