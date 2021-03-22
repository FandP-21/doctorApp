import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/components/centerLoader.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/moreButton.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/models/medications.dart';
import 'package:thcDoctorMobile/models/patientInfo.dart';

class MedicationDetails extends StatefulWidget {
  MedicationDetails({
    this.title,
    @required this.prescription,
  });
  final String title;
  final List<dynamic> prescription;

  @override
  _MedicationDetailsState createState() => _MedicationDetailsState();
}

class _MedicationDetailsState extends State<MedicationDetails> {
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: new SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: sizer(false, 50, context),
                  left: sizer(true, 20, context),
                  right: sizer(true, 20, context)),
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
                      SizedBox()
                    ],
                  ),
                  SizedBox(height: sizer(false, 15, context)),
                  HeaderText(title: widget.title),
                  SizedBox(height: sizer(false, 7, context)),
                  SizedBox(height: 18),
                  Text('Drugs',
                      style: TextStyle(
                          color: Color(0xff071232),
                          fontSize: sizer(true, 20, context))),
                  SizedBox(height: 10),
                  loading
                      ? CenterLoader()
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: widget.prescription.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  bottom: sizer(false, 19, context)),
                              child: Material(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  color: Color(0xffF3F4F8),
                                  child: DrugWidget(
                                    dosage: widget.prescription[index]
                                        ['dosage'],
                                    unit: widget.prescription[index]['unit'],
                                    title: widget.prescription[index]['name'] ??
                                        'Remdesiver',
                                    id: widget.prescription[index]['id'],
                                    frequency: widget.prescription[index]
                                        ['frequency'],
                                    noOfTablets: widget.prescription[index]
                                        ['no_of_tablets'],
                                  )),
                            );
                          },
                        ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DrugWidget extends StatefulWidget {
  final String title;
  final String dosage;
  final String frequency;
  final String unit;
  final int id;
  final Drugs pharmacyDrug;
  final String noOfTablets;
  DrugWidget(
      {@required this.title,
      @required this.unit,
      @required this.dosage,
      this.id,
      this.frequency,
      this.noOfTablets,
      this.pharmacyDrug});

  @override
  _DrugWidgetState createState() => _DrugWidgetState();
}

class _DrugWidgetState extends State<DrugWidget> {
  bool _open = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xffF3F4F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("${widget.title}  (${widget.dosage} ${widget.unit})",
                    style: TextStyle(
                        color: Color(0xff071232),
                        fontSize: sizer(true, 20, context))),
                ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      width: 36,
                      height: 36,
                      color: Color(0xffDFE8FC),
                      child: _open
                          ? Icon(Icons.expand_less,
                              size: 19, color: Color(0xff2254D3))
                          : Icon(Icons.expand_more,
                              size: 19, color: Color(0xff2254D3)),
                    )),
              ],
            ),
            _open ? SizedBox(height: 22) : Container(),
            _open
                ? Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: Color(0xffDFE8FC),
                    ),
                  )
                : Container(),
            _open ? SizedBox(height: 22) : Container(),
            _open
                ? Text(
                    'Dosage',
                    style: TextStyle(fontSize: 15, color: Color(0xff8E919C)),
                  )
                : Container(),
            _open
                ? Text(
                    "${widget.noOfTablets} spoons, 3 times ${widget.frequency} for 7 days",
                    style: TextStyle(
                        color: Color(0xff2254D3),
                        fontSize: sizer(true, 16.0, context)),
                  )
                : Container(),
          ],
        ),
      ),
      onTap: () {
        if (_open == true) {
          setState(() {
            _open = false;
          });
        } else {
          setState(() {
            _open = true;
          });
        }
        print(_open);
      },
    );
  }
}
