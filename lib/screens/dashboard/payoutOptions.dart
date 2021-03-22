import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/skillsBox.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/screens/dashboard/index.dart';

class PayoutOptions extends StatefulWidget {
  PayoutOptions({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PayoutOptionsState createState() => _PayoutOptionsState();
}

class _PayoutOptionsState extends State<PayoutOptions> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: new SingleChildScrollView(
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
                        SizedBox(height: 15),
                        HeaderText(title: 'Payout options'),
                        SizedBox(height: 12),
                        SubText(
                            isCenter: false,
                            title: 'Manage your payout settings.'),
                        SizedBox(height: 38),
                        textfield('BVN','00000000000', TextInputType.phone),
                        textfield('bank name', 'BANK', TextInputType.text),
                        textfield('account no', '000000000', TextInputType.phone),
                        textfield('account name', 'John Doe', TextInputType.text),
                        SizedBox(height: 70),
                        ButtonBlue(
                          title: 'SAVE OPTIONS',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => Dashboard(loading: false)),
                            );
                          },
                        )
                      ]),
                )))));
  }

  Widget textfield(suffix, hintText, keyboard) {
    return Container(
        margin: EdgeInsets.only(bottom: 19),
        child: TextFormField(
          onSaved: (text) {},
          style: TextStyle(
              color: Color(0xff071232),
              fontWeight: FontWeight.w500,
              fontSize: sizer(true, 16, context)),
          cursorColor: Color(0xff245DE8),
          keyboardType: keyboard,
          decoration: InputDecoration(
            suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[SkillsBox(title: suffix)]),
            contentPadding: EdgeInsets.all(20.0),
            fillColor: Color(0xffF3F4F8),
              hintText: hintText,
            hintStyle: TextStyle(color: Color(0xff828A95), fontSize: 16),
            errorMaxLines: 5,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1.5,
                color: Color(0xff245DE8),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
          ),
          validator: (val) {
            if (val.length == 0) {
              return "Password is required";
            }
          },
        ));
  }
}
