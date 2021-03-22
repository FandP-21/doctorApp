import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/components/authTextInput.dart';

class AddCard extends StatefulWidget {
  AddCard({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  @override
  void initState() {
    super.initState();
  }

  Future addCard() {
    Fluttertoast.showToast(msg: "Successful!");
    Future.delayed(Duration(seconds: 1), () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            BackButtonWhite(
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        HeaderText(title: 'Add card'),
                        SizedBox(height: 28),
                        Expanded(
                          child: customForm(),
                        )
                      ]),
                ))));
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
                  child: AuthTextInput(
                      hintText: 'Card Number', onChanged: (text) {}),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                            child: AuthTextInput(
                                hintText: 'MM/YY', onChanged: (text) {})),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: AuthTextInput(
                              hintText: 'CVV', onChanged: (text) {}),
                        )
                      ],
                    )),
              ],
            ),
            ButtonBlue(onPressed: addCard, title: 'ADD CARD'),
          ],
        ));
  }
}
