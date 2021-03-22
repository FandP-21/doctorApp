import 'dart:convert';
import 'package:thcDoctorMobile/components/centerLoader.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/searchTextInput.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/components/specializationSearchresult.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/screens/auth/addPhoto.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/provider/user.dart';

class Specializations extends StatefulWidget {
  @override
  _SpecializationsState createState() => _SpecializationsState();
}

class _SpecializationsState extends State<Specializations> {
  @override
  void initState() {
    super.initState();
    fetchSpecializations();
  }

  List<dynamic> _specializations = [];
  List<dynamic> _specialization = [];
  bool loading = false;
  bool itemsLoading = true;
  int areaOfSpecialization;

  Future<dynamic> fetchSpecializations() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;

    var response = await http.get(url + 'hospital-services/', headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    });
    setState(() => _specializations = jsonDecode(response.body));
    print(jsonDecode(response.body));
    fetchSpecialization();
  }

  Future setId(id) {
    setState(() => areaOfSpecialization = id);
  }

  Future<dynamic> fetchSpecialization() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;

    var response = await http.get(url + 'hospital-subservices/', headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    });
    setState(() => _specialization = jsonDecode(response.body));
    setState(() => itemsLoading = false);
    print(jsonDecode(response.body));
  }

  Future<dynamic> setSpecialization() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;
    String independentId =
        Provider.of<UserModel>(context, listen: false).independentId;
    setState(() => loading = true);
    try {
      var response = await http
          .patch(url + 'doctor/' + independentId.toString() + '/', body: {
        "area_of_specialization": areaOfSpecialization.toString(),
      }, headers: {
        "Connection": 'keep-alive',
        "Authorization": "Bearer " + token
      });
    } catch (e) {}

    var response =
        await http.patch(url + 'doctor/' + id.toString() + '/', body: {
      "area_of_specialization": areaOfSpecialization.toString(),
    }, headers: {
      "Connection": 'keep-alive',
      "Authorization": "Bearer " + token
    });
    print(jsonDecode(response.body));
    setState(() => loading = false);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPhoto()),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              padding: EdgeInsets.only(top: 50),
              child: Stack(alignment: Alignment.bottomCenter, children: [
                LoadingOverlay(
                    isLoading: loading,
                    child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                HeaderText(title: 'Specializations'),
                                SizedBox(height: sizer(false, 5, context)),
                                SubText(
                                    title:
                                        'Select your areas of specialization and sub-specialization',
                                    isCenter: false),
                                SizedBox(height: sizer(false, 35, context)),
                                SearchTextInput(
                                  hintText: "Search",
                                  onChanged: null,
                                ),
                                SizedBox(height: sizer(false, 10, context)),
                                Expanded(
                                    child: itemsLoading
                                        ? CenterLoader()
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: _specializations.length,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                SpecializationSearchResult(
                                                    mainId:
                                                        _specialization[index]
                                                            ['id'],
                                                    specialization:
                                                        _specialization,
                                                    callback: () => setId(
                                                        _specialization[index]
                                                            ['id']),
                                                    title:
                                                        _specializations[index]
                                                                ['name']
                                                            .toString()))),
                              ],
                            ))),
                Positioned(
                    bottom: 0,
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      margin: EdgeInsets.only(bottom: 20),
                      child: ButtonBlue(
                          title: "FINISH", onPressed: setSpecialization),
                    ))
              ]))),
    ));
  }
}
