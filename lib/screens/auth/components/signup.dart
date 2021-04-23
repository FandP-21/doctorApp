import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/authTextInput.dart';
import 'package:thcDoctorMobile/components/authPasswordInput.dart';
import 'package:thcDoctorMobile/components/authEmailInput.dart';
import 'package:thcDoctorMobile/components/authPhoneInput.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcDoctorMobile/screens/auth/components/verify.dart';
import 'package:thcDoctorMobile/screens/auth/components/verifyEnterOtp.dart';
import 'package:thcDoctorMobile/screens/auth/registrationType.dart';
import 'package:thcDoctorMobile/screens/auth/signin.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/models/hospitalService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thcDoctorMobile/screens/auth/signup.dart';
import 'package:http/http.dart' as http;

class SignUpBody extends StatefulWidget {
  SignUpBody({Key key, this.title, @required this.initialItems})
      : super(key: key);
  final String title;
  final List<HospitalService> initialItems;

  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final TextEditingController firstName = new TextEditingController();
  final TextEditingController lastName = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController phoneNo = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController username = new TextEditingController();
  List<HospitalService> chosenItems;
  bool loading = false;
  File medicalLicence;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String verificationId;
  bool isLoggedIn = false;
  User currentUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void createUser() {
    Map<String, dynamic> body = {
      'user': {
        'email': email.text,
        'password': password.text,
        'first_name': firstName.text,
        'last_name': lastName.text,
        'username': firstName.text
      },
      "mdcn_license_number": 000000000000000000,
      "languages": null,
      "location": null,
      "bio_info_on_specialization": null,
      "area_of_specialization": [],
      "mdcn_license": null
    };
    registerFn(body);
  }

  Future<dynamic> registerFn(body) async {
    setState(() => loading = true);
    String _baseUrl = "https://thc2020.herokuapp.com/";
    var responseJson;
    Response response;
    Dio dio = new Dio();

    response = await dio.post(
      _baseUrl + "doctor/",
      data: body,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {
            "Content-Type": "application/json",
            "Connection": 'keep-alive'
          }),
    );
    responseJson = response.data;
    if (response.statusCode != 201) {
      print(response.statusCode);
      print(response.data);
      var message = '';
      if (response.data['user']['email'] != null) {
        message = response.data['user']['email'][0];
      } else {
        message = response.data.toString();
      }
      setState(() => loading = false);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            )),
      ));
    } else {
      Map<String, dynamic> body = {
        "email": email.text,
        "password": password.text,
      };
      loginFn(body);
    }
  }

  Future<dynamic> loginFn(body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _baseUrl = "https://thc2020.herokuapp.com/";
    var responseJson;
    Response response;
    Dio dio = new Dio();

    response = await dio
        .post(
      _baseUrl + "login/",
      data: body,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {
            "Content-Type": "application/json",
            "Connection": 'keep-alive'
          }),
    )
        .catchError((e) {
      setState(() => loading = false);
      var message = '';
      if (e.response.data['detail'] != null) {
        message = e.response.data['detail'];
      } else {
        message = e.response.data.toString();
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            )),
      ));
    });
    responseJson = response.data;
    if (response.statusCode != 200) {
      var message = '';
      if (response.data['detail'] != null) {
        message = response.data['detail'];
      } else if (response.data['message'] == 'Email is not verified') {
        message = response.data['message'];
      } else {
        message = response.data.toString();
      }
      setState(() => loading = false);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            )),
      ));
    } else {
      await prefs.setString('fnamee', firstName.text);
      await prefs.setString('lnamee', lastName.text);
      await prefs.setString('emaill', email.text);
      await prefs.setString('unamee', firstName.text);
      await prefs.setString('phonee', phoneNo.text);
      await prefs.setString('password', password.text);

      if (responseJson['patient_id'] == null &&
          responseJson['doctor_id'] != null) {
        Provider.of<UserModel>(context, listen: false)
            .setId(responseJson['doctor_id'].toString());
        Provider.of<UserModel>(context, listen: false)
            .setMainId(responseJson['id'].toString());
        Provider.of<UserModel>(context, listen: false)
            .setToken(responseJson['access_token']);
        Provider.of<UserModel>(context, listen: false)
            .setName(responseJson['first_name']);
        Provider.of<UserModel>(context, listen: false)
            .setHospitalId(responseJson['hospital_id'].toString());
        var authResponse = await http.get(
            "https://thc2020.herokuapp.com/doctor/${responseJson['doctor_id'].toString()}/",
            headers: {
              "Connection": 'keep-alive',
              "Authorization": "Bearer " + responseJson['access_token']
            });
        Provider.of<UserModel>(context, listen: false)
            .setDoctor(authResponse.body);

        print(responseJson);
        if (responseJson['access_token'] == null) {
          return Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => SignUp()),
          );
        } else {
          Fluttertoast.showToast(msg: "Verifying google account");
          this.handleSignIn();
        }
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Invalid credentials',
              style: TextStyle(
                fontSize: sizer(true, 15.0, context),
                color: Colors.white,
              )),
        ));
      }
    }
  }

  Future<Null> handleSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    this.setState(() => loading = true);

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    User firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;
    String id = Provider.of<UserModel>(context, listen: false).id;
    String token = Provider.of<UserModel>(context, listen: false).token;

    if (firebaseUser != null) {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .set({
          'nickname': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoURL,
          'id': firebaseUser.uid,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          'chattingWith': null,
        });

        // Write data to local
        currentUser = firebaseUser;
        await prefs.setString('firebaseId', currentUser.uid);
        await http.patch("https://thc2020.herokuapp.com/doctor/$id/", headers: {
          "Connection": 'keep-alive',
          "Authorization": "Bearer " + token
        }, body: {
          "firebase_id": currentUser.uid
        });
        print("UID: " + currentUser.uid);
      } else {
        // Write data to local
        await prefs.setString('firebaseId', documents[0].data()['id']);
        await http.patch("https://thc2020.herokuapp.com/doctor/$id/", headers: {
          "Connection": 'keep-alive',
          "Authorization": "Bearer " + token
        }, body: {
          "firebase_id": documents[0].data()['id']
        });
        print("Document: " + documents[0].data()['id']);
      }
      Fluttertoast.showToast(msg: "Account sync success");
      setState(() => loading = false);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => VerifyBody()));
/*      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => RegistrationType(
                  passedEmail: email.text,
                  passedPassword: password.text,
                  passedFirstName: firstName.text,
                  passedLastName: lastName.text,
                  passedUsername: firstName.text,
                  passedPhoneNumber: phoneNo.text)));*/
    } else {
      Fluttertoast.showToast(msg: "Account sync fail");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: LoadingOverlay(
          child: SafeArea(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: sizer(false, 100, context),
                              left: 20,
                              right: 20),
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/brownHand.png',
                                      width: 28,
                                      height: 28,
                                    ),
                                    Material(
                                        color: Color(0xffE7EEFF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          // side: BorderSide(color: Colors.red)
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) => SignIn()),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              //     color: Color(0xffE7EEFF),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'LOGIN',
                                                  style: TextStyle(
                                                      color: Color(0xff245DE8),
                                                      fontSize: sizer(
                                                          true, 14.0, context),
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                SizedBox(width: 10),
                                                Container(
                                                  width: 14,
                                                  height: 14,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff245DE8),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.keyboard_arrow_right,
                                                    size: 10.0,
                                                    color: Colors.white,
                                                  )),
                                                )
                                              ],
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                                SizedBox(height: sizer(false, 7, context)),
                                HeaderText(title: 'Welcome,'),
                                SizedBox(height: sizer(false, 7, context)),
                                Text('Create an account',
                                    style: TextStyle(
                                        color: Color(0xff071232),
                                        fontSize: 28)),
                                SizedBox(height: sizer(false, 50, context)),
                                new Form(
                                    key: _formKey,
                                    autovalidate: _autoValidate,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              240,
                                      child: customForm(),
                                    ))
                              ]))))),
          isLoading: loading,
        ));
  }

  Widget customForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                        child: AuthTextInput(
                            hintText: 'First Name', controller: firstName)),
                    SizedBox(width: 16.0),
                    Expanded(
                        child: AuthTextInput(
                            hintText: 'Last Name', controller: lastName)),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                child: AuthEmailInput(
                    hintText: 'Email Address', controller: email)),
            Container(
                margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                child: AuthPhoneInput(
                    hintText: 'Phone number', controller: phoneNo)),
            Container(
                margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                child: AuthPasswordInput(
                    hintText: 'Create a Password', controller: password)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonBlue(onPressed: createUser, title: 'SUBMIT'),
            SizedBox(height: sizer(false, 30, context)),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'By signing up you agree to our ',
                style: TextStyle(color: Color(0xff828A95), fontSize: 14),
                children: <TextSpan>[
                  TextSpan(
                      text: 'terms of service ',
                      style: TextStyle(color: Color(0xff245de8))),
                  TextSpan(text: '& '),
                  TextSpan(
                      text: 'privacy policy ',
                      style: TextStyle(color: Color(0xff245de8)))
                ],
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ],
    );
  }
}
