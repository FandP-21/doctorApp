import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/searchTextInput.dart';
import 'package:thcDoctorMobile/helpers/store.dart';

class MedicalGuide extends StatefulWidget {
  @override
  _MedicalGuideState createState() => _MedicalGuideState();
}

class _MedicalGuideState extends State<MedicalGuide> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: null,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:  CrossAxisAlignment.center,
                  children: [
                    BackButtonWhite(onPressed: () => {}),
                    SizedBox(),
                  ],
                ),
                SizedBox(height: 25),
                HeaderText(title: "Medical Guide"),
                SizedBox(height: 15),
                SearchTextInput(hintText: 'Search for anything'),
              ],
            ),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.29,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "HOSPITALS",
                        style: TextStyle(
                          color: white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.29,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "DIAGNOSTICS",
                        style: TextStyle(
                          color: white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.29,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "PHARMACIES",
                        style: TextStyle(
                          color: white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    ));
  }
}
