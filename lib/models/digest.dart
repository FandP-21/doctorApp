import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';

class DigestData {
  String title;
  String image;
  String subText;
  String author;
  DigestData(
      {@required this.title,
      @required this.author,
      @required this.image,
      @required this.subText});
}
