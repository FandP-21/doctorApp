import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/subText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/buttonBlack.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:dio/dio.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import './components/registerProfileSuccess.dart';
import 'package:dio/dio.dart';

class AddPhoto extends StatefulWidget {
  AddPhoto({
    Key key,
  }) : super(key: key);

  @override
  _AddPhotoState createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  File _image;
  final picker = ImagePicker();
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  Future getImage(bool camera) async {
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String id = Provider.of<UserModel>(context, listen: false).id;
    String independentId =
        Provider.of<UserModel>(context, listen: false).independentId;
    String token = Provider.of<UserModel>(context, listen: false).token;
    print(id);
    var pickedFile;
    if (camera) {
      pickedFile = await picker.getImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = File(pickedFile.path);
      loading = true;
    });
    String path = pickedFile.path;
    String filename = _image.path.split('/').last;
    Dio dio = new Dio();
    Response response;
    Fluttertoast.showToast(msg: "Uploading photo, please wait");
    FormData data = FormData.fromMap({
      "photo": await MultipartFile.fromFile(
        path,
        filename: filename,
      ),
    });
    // try {
    //   response = await dio.post("doctor/" + independentId.toString() + '/',
    //       data: data);
    //   print(response.data);
    // } catch (e) {}
    // response = await dio.post("doctor/" + id.toString() + '/', data: data);
    // print(response.data);
    setState(() => loading = false);
    Fluttertoast.showToast(msg: "Successful!");
    Future.delayed(
        Duration(seconds: 3),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterProfileSuccess(),
            ),
            (Route<dynamic> route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: LoadingOverlay(
                isLoading: loading,
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
                                Image.asset('assets/images/file.png',
                                    width: 20, height: 20, fit: BoxFit.contain),
                              ],
                            ),
                            SizedBox(height: 15),
                            HeaderText(title: 'One Last Step'),
                            SubText(
                              title:
                                  'Upload a picture to personalize your account and boost your profile visibility',
                              isCenter: false,
                            ),
                            SizedBox(height: 35),
                            Container(
                              width: sizer(true, 361, context),
                              height: sizer(false, 385, context),
                              decoration: BoxDecoration(
                                  color: Color(0xffF3F4F8),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: _image == null
                                      ? Icon(Icons.image,
                                          color: Color(0xffDFE8FC), size: 75)
                                      : Image.file(_image,
                                          fit: BoxFit.contain)),
                            ),
                            SizedBox(height: 37),
                            ButtonBlue(
                                onPressed: () {
                                  getImage(true);
                                },
                                title: 'TAKE A PICTURE'),
                            SizedBox(height: 10),
                            ButtonBlack(
                                onPressed: () {
                                  getImage(false);
                                },
                                title: 'CHOOSE FROM FILES'),
                          ]),
                    ))))));
  }
}
