import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class AuthSelectInput extends StatefulWidget {
  final String hintText;
  final Function onPressed;
  const AuthSelectInput({
    Key key,
    this.hintText,
    this.onPressed,
  }) : super(key: key);

  @override
  _AuthSelectInputState createState() => _AuthSelectInputState();
}

class _AuthSelectInputState extends State<AuthSelectInput> {
  void initState() {
    super.initState();
    this._fillData();
  }

  void _fillData() async {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.only(left: 15, top: 7, right: 10),
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xffF3F4F8),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton<String>(
        hint: Text(
          "Select Hospital to request records from",
          style: TextStyle(
              color: Color(0xff828A95),
              fontFamily: 'SofiaPro',
              fontSize: sizer(true, 16.0, context)),
        ),
        items: [].map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
            onTap: () {
              setState(() {});
            },
          );
        }).toList(),
        onChanged: (value) {
          setState(() {});
        },
        isExpanded: true,
        style: TextStyle(
            color: Color(0xff2254D3), fontFamily: 'SofiaPro', fontSize: 14),
        underline: SizedBox(),
        dropdownColor: Color(0xffF3F4F8),
        iconDisabledColor: Color(0xff2254D3),
      ),
    );
  }
}
