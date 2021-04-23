import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends ChangeNotifier {
  String _id = '';
  String _independentId = '';
  String _independentMainId = '';
  String _mainId = '';
  String _token = '';
  String _baseUrl = "https://thc2020.herokuapp.com/";
  String _name = '';
  String _lname = '';
  String _deviceToken = '';
  String _mobileNumber = '';
  bool _offline;
  bool _ratesVisible;
  String _doctor = '';
  String _hospitalid = '';

  UserModel() {
    getData();
  }

  get hospitalid => _hospitalid;

  get id => _id;

  get independentId => _independentId;

  get independentMainId => _independentMainId;

  get mainId => _mainId;

  get token => _token;

  get baseUrl => _baseUrl;

  get name => _name;

  get lname => _lname;

  get deviceToken => _deviceToken;

  get mobileNumber => _mobileNumber;

  get offline => _offline;

  get ratesVisible => _ratesVisible;

  get doctor => _doctor;

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = (prefs.getString('id') ?? '');
    String independentId = (prefs.getString('independentId') ?? '');
    String independentMainId = (prefs.getString('independentMainId') ?? '');
    String mainId = (prefs.getString('main_id') ?? '');
    String token = (prefs.getString('token') ?? '');
    String name = (prefs.getString('name') ?? '');
    String deviceToken = (prefs.getString('deviceToken') ?? '');
    String mobileNumber = (prefs.getString('mobileNumber') ?? '');
    String lname = (prefs.getString('Lname') ?? "");
    bool offline = prefs.getBool("offline") ?? false;
    bool ratesVisible = prefs.getBool("ratesVisible") ?? true;
    String doctor = prefs.getString('doctor') ?? '';
    String hospitalId = prefs.getString('hospital_id') ?? '';

    _id = id;
    _independentId = independentId;
    _independentMainId = independentMainId;
    _mainId = mainId;
    _token = token;
    _name = name;
    _deviceToken = deviceToken;
    _mobileNumber = mobileNumber;
    _lname = lname;
    _offline = offline;
    _ratesVisible = ratesVisible;
    _doctor = doctor;
    _hospitalid = hospitalId;
    notifyListeners();
  }

  Future<bool> setDeviceToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _deviceToken = value;
    notifyListeners();
    return prefs.setString('deviceToken', value);
  }

  Future<bool> setId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = value;
    notifyListeners();
    return prefs.setString('id', value);
  }

  Future<bool> setIndependentId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _independentId = value;
    notifyListeners();
    return prefs.setString('independentId', value);
  }

  Future<bool> setMobileNumber(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _mobileNumber = value;
    notifyListeners();
    return prefs.setString('moibileNumber', value);
  }

  Future<bool> setMainId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _mainId = value;
    notifyListeners();
    return prefs.setString('main_id', value);
  }
  Future<bool> setHospitalId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _hospitalid = value;
    notifyListeners();
    return prefs.setString('hospital_id', value);
  }
  Future<bool> setIndependentMainId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _independentMainId = value;
    notifyListeners();
    return prefs.setString('independentMainId', value);
  }

  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = value;
    notifyListeners();
    return prefs.setString('token', value);
  }

  Future<bool> setName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = value;
    notifyListeners();
    return prefs.setString('name', value);
  }

  Future<bool> setLName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _lname = value;
    notifyListeners();
    return prefs.setString('Lname', value);
  }

  Future<bool> setOffline(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _offline = value;
    notifyListeners();
    return prefs.setBool('offline', value);
  }

  Future<bool> setRatesVisible(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _ratesVisible = value;
    notifyListeners();
    return prefs.setBool('ratesVisible', value);
  }

  Future<bool> setDoctor(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _doctor = value;
    notifyListeners();
    return prefs.setString('doctor', value);
  }
}
