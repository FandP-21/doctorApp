class AllHmo {
  int id;
  User user;
  bool isActive;
  List<int> hospitals;
  List<int> diagnosticCenters;
  List<int> pharmacy;

  AllHmo(
      {this.id,
      this.user,
      this.isActive,
      this.hospitals,
      this.diagnosticCenters,
      this.pharmacy});

  AllHmo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    isActive = json['is_active'];
    hospitals = json['hospitals'].cast<int>();
    diagnosticCenters = json['diagnostic_centers'].cast<int>();
    pharmacy = json['pharmacy'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['is_active'] = this.isActive;
    data['hospitals'] = this.hospitals;
    data['diagnostic_centers'] = this.diagnosticCenters;
    data['pharmacy'] = this.pharmacy;
    return data;
  }
}

class User {
  String email;
  String username;

  User({this.email, this.username});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['username'] = this.username;
    return data;
  }
}
