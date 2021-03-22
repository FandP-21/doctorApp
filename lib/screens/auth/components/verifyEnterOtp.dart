import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import '../registrationType.dart';
import './resendCodeTimer.dart';
import 'package:thcDoctorMobile/components/authTextInput.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/screens/auth/components/registerSuccess.dart';

class VerifyEnterOtpBody extends StatefulWidget {
  VerifyEnterOtpBody(
      {Key key,
      @required this.otp,
      @required this.resendToken,
      @required this.start})
      : super(key: key);
  final String otp;
  final Function resendToken;
  final int start;

  @override
  _VerifyEnterOtpBodyState createState() => _VerifyEnterOtpBodyState();
}

class _VerifyEnterOtpBodyState extends State<VerifyEnterOtpBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String otp;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    if (widget.otp != '' || widget.otp != null) {
      setState(() {
        otp = widget.otp;
      });
    }
  }

  void preVerify() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      verifyOtp();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  verifyOtp() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.otp,
        smsCode: otp,
      );
      final User user = await _auth
          .signInWithCredential(credential)
          .then((UserCredential result) {
        return result.user;
      });
      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => RegistrationType()),
      );
      //  Navigator.of(context).pushReplacementNamed('/homepage');
    } catch (e) {
      handleError(e);
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            'Invalid Code',
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          elevation: 0.0,
        ));
        break;
      default:
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            error.message,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          elevation: 0.0,
        ));

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(
                    top: sizer(false, 100, context), left: 20, right: 20),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/brownHand.png',
                            width: 28,
                            height: 28,
                          ),
                          Spacer(
                            flex: 1,
                          )
                        ],
                      ),
                      SizedBox(height: sizer(false, 7, context)),
                      HeaderText(title: 'Hi ' + ','),
                      SizedBox(height: sizer(false, 7, context)),
                      Text('Please verify your account',
                          style: TextStyle(
                              color: Color(0xff071232), fontSize: 28)),
                      SizedBox(height: sizer(false, 41, context)),
                      SubText(
                        title:
                            'Enter the 6-digit OTP code sent to your phone number to verify your account',
                        isCenter: false,
                      ),
                      SizedBox(height: sizer(false, 96, context)),
                      new Form(
                        key: _formKey,
                        autovalidate: _autoValidate,
                        child: customForm(),
                      )
                    ]))));
  }

  Widget customForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 15, context)),
          child: AuthTextInput(
              hintText: 'Enter OTP',
              onChanged: (text) {
                otp = text;
              }),
        ),
        ResendCodeTimer(
            loading: false,
            resendToken: widget.resendToken,
            start: widget.start),
        SizedBox(height: sizer(false, 229, context)),
        ButtonBlue(
            onPressed: () {
              //   preVerify();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => RegisterSuccess()),
              );
            },
            title: 'VERIFY ACCOUNT'),
      ],
    );
  }
}
