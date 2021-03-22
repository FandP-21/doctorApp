import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/helpers/store.dart';

class QuestionTextInput extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  const QuestionTextInput({
    Key key,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: TextFormField(
            onSaved: onChanged,
            style: TextStyle(
                color: Color(0xff071232),
                fontWeight: FontWeight.w500,
                fontSize: sizer(true, 16.0, context)),
            cursorColor: Color(0xff245DE8),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              fillColor: Color(0xffF3F4F8),
              hintText: hintText,
              hintStyle: TextStyle(
                  color: Color(0xff828A95),
                  fontSize: sizer(true, 16.0, context)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(10.0),
                  topLeft: const Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                  width: 1.5,
                  color: Color(0xff245DE8),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(10.0),
                  topLeft: const Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
            ),
            validator: (val) {
              if (val.length == 0) {
                return hintText + " is required";
              } else {
                return null;
              }
            },
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 48,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.only(
                bottomRight: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
              ),
              color: darkBlue,
            ),
            child: Center(
              child: Icon(Icons.send, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
