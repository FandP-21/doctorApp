import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:thcDoctorMobile/components/emptyData.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/searchTextInput.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/models/hospital.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'chooseFacility.dart';

class FacilityIndex extends StatefulWidget {
  FacilityIndex({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FacilityIndexState createState() => _FacilityIndexState();
}

class _FacilityIndexState extends State<FacilityIndex> {
  TextEditingController controller = new TextEditingController();
  bool hospitalsLoading = false;
  List<dynamic> newHospitals = [];

  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchHospitals();
    }
  }

  Future fetchHospitals() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    setState(() => hospitalsLoading = true);

    var response = await http.get(url + 'hospital/', headers: {
      "Content-Type": "application/json",
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    });
    setState(() => hospitalsLoading = false);
    print(response.body);
    setState(() => newHospitals = jsonDecode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoadingOverlay(
            child: SafeArea(
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
                              height: 5,
                            ),
                            SubText(
                                isCenter: false,
                                title:
                                    'Book a facility at a hospital for use.'),
                            SizedBox(height: 45),
                            Text(
                              'Select a hospital',
                              style: TextStyle(
                                  color: Color(0xff245DE8), fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            // SearchTextInput(
                            //   action: _searchDrug,
                            //   hintText: 'Search',
                            //   textController: widget.drugs == null
                            //       ? controller
                            //       : TextEditingController(text: searchItems()),
                            //   onChanged: (text) {},
                            // )
                            SearchTextInput(hintText: 'Search'),
                            SizedBox(height: 5),
                            Expanded(
                              child: newHospitals.length > 0
                                  ? ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: newHospitals.length,
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        return hospital(Hospital.fromJson(
                                            newHospitals[index]));
                                      })
                                  : hospitalsLoading
                                      ? SizedBox()
                                      : Padding(
                                          padding: EdgeInsets.only(top: 80),
                                          child: EmptyData(
                                              title: 'No hospitals available',
                                              isButton: false)),
                            )
                          ]),
                    ))),
            isLoading: hospitalsLoading));
  }

  Widget hospital(Hospital hospital) {
    return Material(
        color: Colors.white,
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) =>
                      ChooseFacility(hospital: hospital)));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color(0xffF3F4F8), width: 0.8))),
              child: Text(hospital.user.username,
                  style: TextStyle(color: Color(0xff071232), fontSize: 16)),
            )));
  }
}
