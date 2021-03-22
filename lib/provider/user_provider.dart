import 'package:flutter/widgets.dart';
import 'package:thcDoctorMobile/models/user_.dart';
import 'package:thcDoctorMobile/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User_ _user;
  AuthMethods _authMethods = AuthMethods();

  User_ get getUser => _user;

  Future<void> refreshUser() async {
    User_ user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
