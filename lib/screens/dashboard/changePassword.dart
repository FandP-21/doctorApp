import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/components/centerLoader.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/authPasswordInput.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  ChangePassword({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController oldPassword = new TextEditingController();
  final TextEditingController newPassword = new TextEditingController();
  final TextEditingController newPasswordCheck = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<Null> changePassword() async {
    setState(() => loading = true);
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String mainId = Provider.of<UserModel>(context, listen: false).mainId;
    String token = Provider.of<UserModel>(context, listen: false).token;
    var response;
    Map<String, dynamic> body = {
      "pk": mainId,
      "old_password": oldPassword.text,
      "new_password": newPassword.text,
    };

    if (newPasswordCheck.text == newPassword.text) {
      try {
        response = await http.patch(url + 'change-password/',
            body: body,
            headers: {
              "Connection": 'keep-alive',
              "Authorization": "Bearer " + token
            });
        print(response.body);
        setState(() {
          loading = false;
        });
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text(jsonDecode(response.body)['message'])));
      } catch (e) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(e)));
      }
    } else {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text("Paswords do not match!")));
    }
  }

  @override
  void dispose() {
    newPassword.dispose();
    oldPassword.dispose();
    newPasswordCheck.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                    padding: EdgeInsets.only(
                        top: sizer(false, 50, context), left: 20, right: 20),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              BackButtonWhite(
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          HeaderText(title: 'Change Password'),
                          SizedBox(height: 38),
                          Expanded(
                            child: customForm(),
                          )
                        ])))));
  }

  Widget customForm() {
    return Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                  child: AuthPasswordInput(
                      noIcon: true,
                      controller: oldPassword,
                      hintText: 'Enter current password',
                      onChanged: (text) {}),
                ),
                SizedBox(height: 3),
                Container(
                  margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                  child: AuthPasswordInput(
                      noIcon: true,
                      controller: newPassword,
                      hintText: 'Enter new password',
                      onChanged: (text) {}),
                ),
                SizedBox(height: 3),
                Container(
                  margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                  child: AuthPasswordInput(
                      noIcon: true,
                      controller: newPasswordCheck,
                      hintText: 'Reenter new password',
                      onChanged: (text) {}),
                ),
              ],
            ),
            loading
                ? CenterLoader():  ButtonBlue(onPressed: changePassword, title: 'CHANGE PASSWORD'),
          ],
        ));
  }
}
