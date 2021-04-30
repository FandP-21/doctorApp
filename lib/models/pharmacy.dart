class Pharmacy {
  int id=0;
  User user;
  List<PharmacyBranch> pharmacyBranch;
  List<SpecialDrugs> specialDrugs;
  List<PharmacyDrug> pharmacyDrug;
  int rating;
  String officeAddress;
  String cacNumber;
  String photo;
  String phoneNumber;
  bool isActive;
  bool isSetup;
  String bio;
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

  Pharmacy(
      {this.id,
      this.user,
      this.pharmacyBranch,
      this.specialDrugs,
      this.pharmacyDrug,
      this.rating,
      this.officeAddress,
      this.cacNumber,
      this.phoneNumber,
      this.isActive,
      this.isSetup,
      this.bio,
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

  Pharmacy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['pharmacy_branch'] != null) {
      pharmacyBranch = new List<PharmacyBranch>();
      json['pharmacy_branch'].forEach((v) {
        pharmacyBranch.add(new PharmacyBranch.fromJson(v));
      });
    }
    if (json['special_drugs'] != null) {
      specialDrugs = new List<SpecialDrugs>();
      json['special_drugs'].forEach((v) {
        specialDrugs.add(new SpecialDrugs.fromJson(v));
      });
    }
    if (json['pharmacy_drug'] != null) {
      pharmacyDrug = new List<PharmacyDrug>();
      json['pharmacy_drug'].forEach((v) {
        pharmacyDrug.add(new PharmacyDrug.fromJson(v));
      });
    }
    rating = json['rating'] ?? 'N/A';
    officeAddress = json['office_address'] ?? 'N/A';
    cacNumber = json['cac_number'] ?? 'N/A';
    photo = 'https://thc2020.herokuapp.com' + json['photo'] ?? '';
    phoneNumber = json['phone_number'] ?? 'N/A';
    isActive = json['is_active'];
    isSetup = json['is_setup'];
    bio = json['bio'] ?? 'N/A';
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.pharmacyBranch != null) {
      data['pharmacy_branch'] =
          this.pharmacyBranch.map((v) => v.toJson()).toList();
    }
    if (this.specialDrugs != null) {
      data['special_drugs'] = this.specialDrugs.map((v) => v.toJson()).toList();
    }
    if (this.pharmacyDrug != null) {
      data['pharmacy_drug'] = this.pharmacyDrug.map((v) => v.toJson()).toList();
    }
    data['rating'] = this.rating;
    data['office_address'] = this.officeAddress;
    data['cac_number'] = this.cacNumber;
    data['photo'] = this.photo;
    data['phone_number'] = this.phoneNumber;
    data['is_active'] = this.isActive;
    data['is_setup'] = this.isSetup;
    data['bio'] = this.bio;
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

class User {
  String email;
  String username;
  String firstName;
  String lastName;

  User({this.email, this.username, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class PharmacyBranch {
  int id;
  String branchAddress;
  String emergencyPhoneNumber;

  PharmacyBranch({this.id, this.branchAddress, this.emergencyPhoneNumber});

  PharmacyBranch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchAddress = json['branch_address'];
    emergencyPhoneNumber = json['emergency_phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_address'] = this.branchAddress;
    data['emergency_phone_number'] = this.emergencyPhoneNumber;
    return data;
  }
}

class SpecialDrugs {
  int id;
  Category category;
  String name;

  SpecialDrugs({this.id, this.category, this.name});

  SpecialDrugs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['name'] = this.name;
    return data;
  }
}

class Category {
  int id;
  String name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
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

class PharmacyDrug {
  int id;
  String name;
  String drugDivision;
  double price;
  int drugType;

  PharmacyDrug(
      {this.id, this.name, this.drugDivision, this.price, this.drugType});

  PharmacyDrug.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    drugDivision = json['drug_division'];
    price = json['price'];
    drugType = json['drug_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['drug_division'] = this.drugDivision;
    data['price'] = this.price;
    data['drug_type'] = this.drugType;
    return data;
  }
}
