import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/skillsBox.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'bookFacility.dart';

class ChooseFacility extends StatefulWidget {
  ChooseFacility({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ChooseFacilityState createState() => _ChooseFacilityState();
}

class _ChooseFacilityState extends State<ChooseFacility> {
  bool value = false;
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
                        HeaderText(title: 'Rent a facility'),
                        SizedBox(
                          height: 8,
                        ),
                        SubText(
                            isCenter: false,
                            title: 'Book a facility at a hospital for use.'),
                        SizedBox(height: 45),
                        Text(
                          'Choose a facility to rent at ${widget.title}',
                          style:
                              TextStyle(color: Color(0xff245DE8), fontSize: 16),
                        ),
                        SizedBox(height: 23),
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 6,
                              itemBuilder: (BuildContext context, int index) =>
                                  CheckListTile(title: "Operating theater")),
                        ),
                        SizedBox(height: 20),
                        ButtonBlue(
                          title: 'SEND BOOKING REQUEST',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => BookFacility()));
                          },
                        ),
                        SizedBox(height: 20),
                      ]),
                ))));
  }
}

class CheckListTile extends StatefulWidget {
  CheckListTile({@required this.title});
  final String title;

  @override
  _CheckListTileState createState() => _CheckListTileState();
}

class _CheckListTileState extends State<CheckListTile> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color(0xffF3F4F8), width: 0.8))),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    if (value == false)
                      setState(() => value = true);
                    else
                      setState(() => value = false);
                  },
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                        color: value ? blue : Color.fromRGBO(223, 232, 252, 1),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.all(10),
                    child: Checkbox(
                      onChanged: (val) => {},
                      value: value,
                      activeColor: blue,
                      checkColor: Colors.white,
                    ),
                  )),
              SizedBox(width: sizer(true, 17, context)),
              Text(widget.title,
                  style: TextStyle(
                      color: Color(0xff071232),
                      fontSize: sizer(true, 16.0, context))),
              Spacer(),
              SizedBox(width: 82.8),
              SkillsBox(title: 'NGN 1,500',
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              borderRadius: BorderRadius.circular(20),
              )
            ]));
  }
}
