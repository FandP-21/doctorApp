import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/centerLoader.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/moreButton.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/components/searchTextInput.dart';
import 'package:thcDoctorMobile/models/pharmacy.dart';
import 'package:thcDoctorMobile/provider/user.dart';

class Pharmacydatascreen extends StatefulWidget {
  Pharmacydatascreen({Key key, this.title, this.drugs, this.drugIds})
      : super(key: key);
  final String title;
  final List drugs, drugIds;

  @override
  _PharmacydatascreenState createState() => _PharmacydatascreenState();
}

class _PharmacydatascreenState extends State<Pharmacydatascreen> {
  List<Map> pharmacy = [];
  bool loading = true;
  TextEditingController controller = new TextEditingController();
  List<dynamic> _drugNames = [];
  @override
  void initState() {
    super.initState();
    _drugNames = widget.drugs;
    print(widget.drugIds);
    this._searchDrugs();
  }

  Future<Null> _searchDrugs() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;

    // for (int i = 0; i < widget.drugIds.length; i++) {
      http.Response response = await http.get(
        url + "pharmacy",
        headers: {
          "Connection": 'keep-alive',
          "Authorization": "Bearer " + token
        },
      );
      if (response.body != '[]')
        setState(() {
          pharmacy.add(jsonDecode(response.body)[0]);
          loading = false;
        });
    // }
    setState(() => loading = false);
  }

  Future<dynamic> _searchDrug() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
  }

  searchItems() {
    String _combined = '';
    for (int i = 0; i < _drugNames.length; i++) {
      if (_combined != '')
        _combined = _combined + "; " + _drugNames[i];
      else
        _combined = _combined + _drugNames[i];
    }
    return _combined;
  }

  @override
  void dispose() {
    super.dispose();
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
                              onPressed: () => Navigator.pop(context),
                            ),
                            MoreButton(onPressed: () {})
                          ],
                        ),
                        SizedBox(height: sizer(false, 15, context)),
                        HeaderText(title: 'Pharmacy'),
                        SizedBox(height: 35),
                        SearchTextInput(
                          action: _searchDrug,
                          hintText: 'Search for a Pharmacy',
                          textController: widget.drugs == null
                              ? controller
                              : TextEditingController(text: searchItems()),
                          onChanged: (text) {},
                        ),
                        SizedBox(height: sizer(false, 20, context)),
                        loading
                            ? SubText(title: '', isCenter: false)
                            : pharmacy.length == 0
                                ? SubText(title: '', isCenter: false)
                                : SubText(
                                    title:
                                        'This pharmacy is available at the following places',
                                    isCenter: false),
                        SizedBox(height: 23),
                        loading
                            ? CenterLoader()
                            : pharmacy.length == 0
                                ? Container(
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: SubText(
                                        title:
                                            'No pharmacy found under this drug',
                                        isCenter: true))
                                : ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: pharmacy.length,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      return Container(
                                          margin: EdgeInsets.only(
                                              bottom:
                                                  sizer(false, 19, context)),
                                          child: Material(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                                // side: BorderSide(color: Colors.red)
                                              ),
                                              color: Color(0xffF3F4F8),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    // Navigator.of(context).push(
                                                    //     MaterialPageRoute(
                                                    //         builder: (_) =>
                                                    //             DrugDetails(
                                                    //               title: '',
                                                    //               pharmacy: Pharmacy
                                                    //                   .fromJson(
                                                    //                 pharmacy[
                                                    //                         index]
                                                    //                     [
                                                    //                     'pharmacy'],
                                                    //               ),
                                                    //               drug: pharmacy[
                                                    //                       index]
                                                    //                   ['drug'],
                                                    //             )));
                                                  },
                                                  child: pharmacyPanel(PharmacyWidget(
                                                      title: Pharmacy.fromJson(
                                                              pharmacy[index]
                                                                  ['pharmacy'])
                                                          .user
                                                          .username,
                                                      location:
                                                          Pharmacy.fromJson(pharmacy[index]['pharmacy'])
                                                              .officeAddress,
                                                      amount: pharmacy[index]
                                                          ['price'],
                                                      pharmacy: Pharmacy.fromJson(
                                                          pharmacy[index]
                                                              ['pharmacy']))))));
                                    })
                      ]),
                )))));
  }

  Widget pharmacyPanel(PharmacyWidget pharmacy) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xffF3F4F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(27.5),
              child: Image.asset('assets/images/pharmacyIcon.png',
                  width: 55, height: 55, fit: BoxFit.contain)),
          SizedBox(width: 10),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(pharmacy.title,
                  style: TextStyle(
                      color: Color(0xff071232),
                      fontSize: sizer(true, 16.0, context))),
              Text(pharmacy.location,
                  style: TextStyle(
                      color: Color(0xff8E919C),
                      fontSize: sizer(true, 16.0, context))),
            ],
          )),
          Spacer(),
          Container(
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 14.6),
              decoration: BoxDecoration(
                color: Color(0xffDFE8FC),
                borderRadius: BorderRadius.circular(14.6),
              ),
              child: Center(
                child: Text(pharmacy.amount.toString(),
                    style: TextStyle(
                        color: Color(0xff2254D3),
                        fontSize: sizer(true, 14, context))),
              ))
        ],
      ),
    );
  }
}

class PharmacyWidget {
  String title;
  String location;
  double amount;
  Pharmacy pharmacy;
  PharmacyWidget(
      {@required this.title,
      @required this.location,
      @required this.amount,
      this.pharmacy});
}
