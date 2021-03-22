import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Color white = Colors.white;
Color green = Color.fromRGBO(40, 204, 86, 1);
Color sameGreen = Color.fromRGBO(34, 211, 137, 1);
Color darkBlue = Color.fromRGBO(7, 18, 50, 1);
Color black = Colors.black;
Color blue = Color.fromRGBO(36, 93, 232, 1);
Color textGrey = Color.fromRGBO(134, 134, 151, 1);
Color inputGrey = Color.fromRGBO(130, 138, 149, 1);
Color backgroundGrey = Color.fromRGBO(243, 244, 248, 1);
Color orange = Color.fromRGBO(255, 153, 79, 1);
Color lightOrange = Color.fromRGBO(255, 151, 44, 1);
Color purple = Color.fromRGBO(186, 98, 254, 1);
Color red = Color.fromRGBO(255, 111, 79, 1);

double pixel10 = 10;
double pixel12 = 12;
double pixel14 = 14;
double pixel16 = 16;
double pixel18 = 18;
double pixel20 = 20;
double pixel22 = 22;
double pixel24 = 24;
double pixel26 = 26;
double pixel28 = 28;
double pixel30 = 30;
double pixel32 = 32;
double pixel34 = 34;
double pixel36 = 36;
double pixel38 = 38;
double pixel40 = 40;

FontWeight normal = FontWeight.w400;
FontWeight moderate = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

vertical(double height, bool mediaQuery, [context]) {
  return mediaQuery
      ? SizedBox(
          height: MediaQuery.of(context).size.height * (height / 100),
        )
      : SizedBox(
          height: height,
        );
}

horizontal(double width, bool mediaQuery, [context]) {
  return mediaQuery
      ? SizedBox(
          width: MediaQuery.of(context).size.width * (width / 100),
        )
      : SizedBox(
          width: width,
        );
}

height(double height, bool mediaQuery, [context]) {
  return mediaQuery
      ? MediaQuery.of(context).size.height * (height / 100)
      : height;
}

width(double width, bool mediaQuery, [context]) {
  return mediaQuery ? MediaQuery.of(context).size.width * (width / 100) : width;
}
