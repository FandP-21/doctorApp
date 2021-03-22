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
