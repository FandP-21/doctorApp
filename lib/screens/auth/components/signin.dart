import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/screens/auth/signup.dart';
import 'package:thcDoctorMobile/components/authPasswordInputTest.dart';
import 'package:thcDoctorMobile/components/authEmailInput.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:thcDoctorMobile/screens/dashboard/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInBody extends StatefulWidget {
  SignInBody({Key key, this.title, this.loginFn, this.loading})
      : super(key: key);
  final String title;
  final Function loginFn;
  final bool loading;

  @override
  _SignInBodyState createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
  }

  void preLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Map<String, dynamic> body = {
        'email': _email,
        'password': _password,
      };
      widget.loginFn(body);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: LoadingOverlay(
          child: SafeArea(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: new SingleChildScrollView(
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
                                                  builder: (_) => SignUp()),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              //    color: Color(0xffE7EEFF),
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
                                                  'SIGN UP',
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
                                HeaderText(title: 'Welcome Back,'),
                                SizedBox(height: sizer(false, 7, context)),
                                Text('Sign in',
                                    style: TextStyle(
                                        color: Color(0xff071232),
                                        fontSize: 28)),
                                SizedBox(height: sizer(false, 93, context)),
                                new Form(
                                  key: _formKey,
                                  autovalidate: _autoValidate,
                                  child: customForm(),
                                )
                              ]))))),
          isLoading: widget.loading,
        ));
  }

  Widget customForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
          child: AuthEmailInput(
              hintText: 'Email Address',
              onChanged: (text) {
                _email = text;
              }),
        ),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 30, context)),
          child: AuthPasswordInputTextTest(
              hintText: 'Password',
              onChanged: (text) {
                _password = text;
              }),
        ),
        ButtonBlue(
            onPressed: () {
              preLogin();
              // return Navigator.of(context).push(
              //   MaterialPageRoute(
              //       builder: (_) => Dashboard(title: 'Jesse', loading: false)),
              // );
            },
            title: 'LOG IN'),
      ],
    );
  }
}
