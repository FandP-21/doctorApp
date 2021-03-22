import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/borderedCheckbox.dart';

class Specialization extends StatefulWidget {
  Specialization(
      {Key key,
      @required this.speciality,
      @required this.specialization,
      @required this.mainId})
      : super(key: key);
  final String speciality;
  final int mainId;
  final List<dynamic> specialization;

  @override
  _SpecializationState createState() => _SpecializationState();
}

class _SpecializationState extends State<Specialization> {
  List<dynamic> specialization = [];
  @override
  void initState() {
    super.initState();
    setOrder();
  }

  setOrder() {
    for (int i = 0; i < widget.specialization.length; i++) {
      if (widget.specialization[i]['hospital_service'] == widget.mainId) {
        setState(() => (specialization.add(widget.specialization[i])));
      }
    }
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                HeaderText(title: widget.speciality),
                SizedBox(height: sizer(false, 5, context)),
                SubText(
                    title: 'Select your sub-specializations', isCenter: false),
                SizedBox(height: sizer(false, 5, context)),
                Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: specialization.length,
                        itemBuilder: (BuildContext context, int index) =>
                            BorderedCheckbox(
                                placeholder: specialization[index]['name']))),
                SizedBox(height: 20),
              ],
            )),
        ),
        bottomNavigationBar: Container(
          height: 60,
          padding: EdgeInsets.only(left: 20, right: 20),
          margin: EdgeInsets.only(bottom: 20),
          child: ButtonBlue(
              onPressed: () {
                Navigator.of(context).pop();
              },
              title: 'CONFIRM'),
        ),
      ),
    );
  }
}
