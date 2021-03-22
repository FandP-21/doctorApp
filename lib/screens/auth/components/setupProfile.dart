import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/multiInput.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/screens/auth/components/registerProfileSuccess.dart';
import 'package:thcDoctorMobile/screens/auth/components/specializations.dart';
import 'package:thcDoctorMobile/screens/auth/registrationType.dart';
import 'package:thcDoctorMobile/components/authTextInput.dart';
import 'package:thcDoctorMobile/components/authUploadInput.dart';
import 'package:thcDoctorMobile/components/authPhoneInput.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:file_picker/file_picker.dart';

class SetupProfile extends StatefulWidget {
  SetupProfile(
      {Key key,
      this.title,
      @required this.passedPhoneNumber,
      @required this.independent,
      @required this.practice})
      : super(key: key);
  final String title;
  final String passedPhoneNumber;
  final bool independent;
  final bool practice;

  @override
  _SetupProfileState createState() => _SetupProfileState();
}

class _SetupProfileState extends State<SetupProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController phoneNo = new TextEditingController();
  final TextEditingController languages = new TextEditingController();
  final TextEditingController mdcnLicenseNumber = new TextEditingController();
  final TextEditingController bio = new TextEditingController();
  final TextEditingController location = new TextEditingController();
  bool homeService = false;
  bool loading = false;
  File medicalLicence;
  String fileName = 'Upload medical license';

  @override
  void initState() {
    super.initState();
  }

  Future<Null> updateProfile() async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String id = Provider.of<UserModel>(context, listen: false).id;
    String token = Provider.of<UserModel>(context, listen: false).token;

    setState(() => loading = true);
    var responseJson;
    Response response;
    Dio dio = new Dio();
    Map<dynamic, dynamic> body = {
      "phone_number": phoneNo.text,
      "languages": languages.text,
      "mdcn_license_number": mdcnLicenseNumber.text,
      "bio_info_on_specialization": bio.text,
      "location": location.text,
      // "mdcn_license": medicalLicence,
    };
    response = await dio.patch(
      url + "doctor/" + id.toString() + '/',
      data: body,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {
            "Connection": 'keep-alive',
            "Authorization": "Bearer " + token
          }),
    );
    setState(() {
      loading = false;
    });
    responseJson = response.data;
    if (response.statusCode != 200) {
      var message = '';
      if (response.data['details'] != null) {
        message = response.data['details'];
      } else {
        message = response.data.toString();
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(
              fontSize: sizer(true, 15.0, context),
              color: Colors.white,
            )),
      ));
    } else {
      return Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => Specializations()),
      );
    }
  }

  Future getPdfAndUpload() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
    );

    if (result != null) {
      setState(() {
        medicalLicence = File(result.files.single.path);
        fileName = '${result.files.single.path.split('/').last}';
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: LoadingOverlay(
          child: SafeArea(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: new SingleChildScrollView(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: sizer(false, 70, context),
                              left: 20,
                              bottom: 30,
                              right: 20),
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                HeaderText(title: 'Setup your profile'),
                                SizedBox(height: 5),
                                SubText(
                                  title:
                                      'Complete your personal details to setup a medical profile.',
                                  isCenter: false,
                                ),
                                SizedBox(height: sizer(false, 50, context)),
                                new Form(
                                  key: _formKey,
                                  autovalidate: _autoValidate,
                                  child: customForm(),
                                )
                              ]))))),
          isLoading: false,
        ));
  }

  Widget customForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 15, context)),
          child: AuthPhoneInput(
            hintText: 'Phone number',
            controller: phoneNo.text.isEmpty
                ? TextEditingController(text: widget.passedPhoneNumber)
                : phoneNo,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 15, context)),
          child: AuthUploadInput(
            hintText: fileName,
            onPressed: getPdfAndUpload,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: sizer(false, 15, context)),
          child: AuthPhoneInput(
            hintText: 'Medical license number',
            controller: mdcnLicenseNumber,
          ),
        ),
        Container(
            margin: EdgeInsets.only(bottom: sizer(false, 15, context)),
            child: AuthTextInput(
              hintText: 'Location',
              controller: location,
            )),
        Container(
            margin: EdgeInsets.only(bottom: sizer(false, 15, context)),
            child: AuthTextInput(
              hintText: 'Enter languages spoken',
              controller: languages,
            )),
        Container(
            margin: EdgeInsets.only(bottom: sizer(false, 15, context)),
            child: MultiInput(
              hintText: 'Add a bio',
              controller: bio,
              maxLines: 5,
              minLines: 5,
            )),
        CheckItem(
            title: "I'm available for home service",
            active: homeService,
            callback: (value) => setState(() => homeService = value)),
        SizedBox(height: sizer(false, 30, context)),
        ButtonBlue(onPressed: updateProfile, title: 'SUBMIT'),
      ],
    );
  }
}
