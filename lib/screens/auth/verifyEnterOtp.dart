// import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
// import 'package:page_transition/page_transition.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:thcDoctorMobile/components/headerText.dart';
// import 'components/verifyEnterOtp.dart';
// import 'addPhoto.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:provider/provider.dart';
// import 'package:thcDoctorMobile/provider/user.dart';
// import './components/registerSuccess.dart';
// import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

// class VerifyEnterOtp extends StatefulWidget {
//   VerifyEnterOtp({Key key, @required this.title, @required this.isLogin, this.id})
//       : super(key: key);
//   final String title;
//   final bool isLogin;
//   final String id;

//   @override
//   _VerifyEnterOtpState createState() => _VerifyEnterOtpState();
// }

// class _VerifyEnterOtpState extends State<VerifyEnterOtp> {
//   bool loading = false;
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
// int _start = 60;
//   Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//      startTimer();
//     // if (widget.isLogin) {
//     //   resendToken();
//     // }
//   }

//     @override
// void dispose() {
//   _timer.cancel();
//   super.dispose();
// }

//   void startTimer() {
//   const oneSec = const Duration(seconds: 1);
//   _timer = new Timer.periodic(
//     oneSec,
//     (Timer timer) => setState(
//       () {
//         if (_start < 1) {
//           timer.cancel();
//         } else {
//           _start = _start - 1;
//         }
//       },
//     ),
//   );
// }

//   Future<dynamic> resendToken() async {
//     setState(() {
//       loading = true;
//     });
//     String _baseUrl = "https://thc2020.herokuapp.com/";
//     var responseJson;
//     Response response;
//     Dio dio = new Dio();
//     Map<String, dynamic> body = {'pk': widget.id};
//     response = await dio
//         .post(
//       _baseUrl + "resend-token/",
//       data: body,
//       options: Options(
//           followRedirects: false,
//           validateStatus: (status) {
//             return status < 500;
//           },
//           headers: {
//             "Content-Type": "application/json",
//             "Connection": 'keep-alive'
//           }),
//     )
//         .catchError((e) {
//       setState(() {
//         loading = false;
//       });
//       print(e.response.data);
//       var message = '';
//       if (e.response.data['detail'] != null) {
//         message = e.response.data['detail'];
//       } else {
//         message = e.response.data.toString();
//       }
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text(message,
//             style: TextStyle(
//               fontSize: sizer(true,15.0,context),
//               color: Colors.white,
//             )),
//       ));
//     });
//     setState(() {
//       loading = false;
//     });
//     print(response);
//     responseJson = response.data;
//     if (response.statusCode != 200 || response.statusCode != 201) {
//       var message = '';
//       // if (response.data.message != null) {
//       //   message = response.data['message'];
//       // } else {
//       //   message = response.data.toString();
//       // }
//       // _scaffoldKey.currentState.showSnackBar(SnackBar(
//       //   content: Text(message,
//       //       style: TextStyle(
//       //         fontSize: sizer(true,15.0,context),
//       //         color: Colors.white,
//       //         //   fontWeight: FontWeight.w300,
//       //       )),
//       //   // duration: Duration(seconds: 3),
//       // ));
//     }
//     // setState((){
//     //  _start = 60;
//     // });
//     startTimer();
//     return print(widget.id);
//   }

//   Future<dynamic> verifyEmail(body) async {
//     setState(() {
//       loading = true;
//     });
//     String _baseUrl = "https://thc2020.herokuapp.com/";
//     var responseJson;
//     Response response;
//     Dio dio = new Dio();
//     response = await dio
//         .get(
//       _baseUrl + "email-verify/",
//       queryParameters: body,
//       options: Options(
//           followRedirects: false,
//           validateStatus: (status) {
//             return status < 500;
//           },
//           headers: {
//             "Content-Type": "application/json",
//             "Connection": 'keep-alive'
//           }),
//     )
//         .catchError((e) {
//       setState(() {
//         loading = false;
//       });
//       print(e.response.data);
//       var message = '';
//       if (e.response.data['error'] != null) {
//         message = e.response.data['error'];
//       } else {
//         message = e.response.data.toString();
//       }
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text(message,
//             style: TextStyle(
//               fontSize: sizer(true,15.0,context),
//               color: Colors.white,
//             )),
//       ));
//     });
//     setState(() {
//       loading = false;
//     });
//     responseJson = response.data;
//     if (response.statusCode != 200) {
//       var message = '';
//       if (response.data['error'] != null) {
//         message = response.data['error'];
//       } else {
//         message = response.data.toString();
//       }
//       _scaffoldKey.currentState.showSnackBar(SnackBar(
//         content: Text(message,
//             style: TextStyle(
//               fontSize: sizer(true,15.0,context),
//               color: Colors.white,
//               //   fontWeight: FontWeight.w300,
//             )),
//         // duration: Duration(seconds: 3),
//       ));
//     }else{

//           print(responseJson['data']);
//     Provider.of<UserModel>(context,listen: false).setId(responseJson['data']['doctor_id'].toString());
//     Provider.of<UserModel>(context,listen: false).setToken(responseJson['data']['access_token']);
//     Provider.of<UserModel>(context, listen: false).setName(responseJson['data']['first_name']);
//     return Navigator.of(context).push(
//       MaterialPageRoute(
//           builder: (_) => RegisterSuccess()),
//     );
//     }

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _scaffoldKey,
//         body: VerifyEnterOtpBody(
//             title: widget.title,
//             loading: loading,
//             verifyFn: verifyEmail,
//             resendToken: resendToken,
//             start: _start));
//   }
// }
