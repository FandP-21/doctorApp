import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/screens/auth/signup.dart';
import 'components/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/screens/dashboard/index.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String verificationId;
  String smsOTP;
  bool isLoading = false;
  bool isLoggedIn = false;
  User currentUser;

  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> loginFn(body) async {
    setState(() {
      _loading = true;
    });
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
      setState(() {
        _loading = false;
      });
      // print(e.response.data);
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
    setState(() {
      _loading = false;
    });
    responseJson = response.data;
    if (response.statusCode != 200) {
      var message = '';
      if (response.data['detail'] != null) {
        message = response.data['detail'];
      } else if (response.data['message'] == 'Email is not verified') {
        message = response.data['message'];
        // print(response.data['id']);
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //       builder: (_) => VerifyBody(
        //           isLogin: true,)),
        // );
      } else {
        message = response.data.toString();
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            )),
      ));
    } else {
      if (responseJson['patient_id'] == null &&
          responseJson['doctor_id'] != null) {
        await Provider.of<UserModel>(context, listen: false)
            .setId(responseJson['doctor_id'].toString());
        await Provider.of<UserModel>(context, listen: false)
            .setMainId(responseJson['id'].toString());
        await Provider.of<UserModel>(context, listen: false)
            .setToken(responseJson['access_token']);
        await Provider.of<UserModel>(context, listen: false)
            .setName(responseJson['first_name']);
        await prefs.setString("first_name", responseJson['first_name']);

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
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //       builder: (_) => Dashboard(
          //         loading: false,
          //       )),
          // );
        }
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Invalid credentials',
              style: TextStyle(
                fontSize: sizer(true, 15.0, context),
                color: Colors.white,
                //   fontWeight: FontWeight.w300,
              )),
          // duration: Duration(seconds: 3),
        ));
      }
    }
  }

  Future<Null> handleSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    this.setState(() {
      isLoading = true;
    });

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
      // Check is already sign up
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        // Update data to server if new user
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
      Fluttertoast.showToast(msg: "Sign in success");
      this.setState(() {
        isLoading = false;
      });
      return Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) => Dashboard(
                  loading: false,
                )),
      );
    } else {
      Fluttertoast.showToast(msg: "Sign in fail");
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
        body: SignInBody(
          loading: _loading,
          loginFn: loginFn,
        ));
  }
}
