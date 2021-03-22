import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/models/doctor.dart';
import 'package:thcDoctorMobile/components/skillsBox.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class GoToDoctorBox extends StatefulWidget {
  final Doctor doctor;
  final GestureTapCallback onPressed;
  GoToDoctorBox({Key key, @required this.onPressed, @required this.doctor})
      : super(key: key);
  @override
  _GoToDoctorBoxState createState() => _GoToDoctorBoxState();
}

class _GoToDoctorBoxState extends State<GoToDoctorBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
            color: Colors.transparent,
            //       color: Color(0xff245DE8),
            child: GestureDetector(
              onTap: widget.onPressed,
              child: Container(
                  margin: EdgeInsets.only(bottom: sizer(false, 15, context)),
                  padding: EdgeInsets.only(bottom: sizer(false, 18, context)),
                  decoration: BoxDecoration(
                      //      color: Color(0xffffffff),
                      //   borderRadius: BorderRadius.circular(10.0),
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xffF3F4F8), width: 0.8))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      widget.doctor.photo != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(widget.doctor.photo,
                                  fit: BoxFit.cover, width: 45, height: 45))
                          : Container(),
                      SizedBox(width: 15),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Dr. " + widget.doctor.user.name,
                              style: TextStyle(
                                  color: Color(0xff071232),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                  height: 30,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget
                                        .doctor.areaOfSpecialization.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            SkillsBox(
                                      title: widget.doctor
                                          .areaOfSpecialization[index].name,
                                    ),
                                  ))),
                          Text(widget.doctor.hospital.bio,
                              style: TextStyle(
                                  color: Color(0xff8E919C), fontSize: 14))
                        ],
                      )),
                      SizedBox(width: 15),
                      Material(
                        color: Color(0xffF3F4F8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xffF3F4F8),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                                child: Icon(Icons.arrow_forward,
                                    size: 17, color: Color(0xff091118))),
                          ),
                        ),
                      ),
                    ],
                  )),
            )));
  }
}
