import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class SearchTextInput extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final TextEditingController textController;
  final GestureTapCallback action;
  final Color altColor;
  const SearchTextInput({
    Key key,
    this.hintText,
    this.onChanged,
    this.altColor,
    this.textController,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      onSaved: onChanged,
      style: TextStyle(
          color: altColor != null ? Colors.white : Color(0xff071232),
          fontWeight: FontWeight.w500,
          fontSize: sizer(true, 16.0, context)),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: sizer(false, 20, context),
            horizontal: sizer(true, 20, context)),
        fillColor: altColor ?? Color(0xffF3F4F8),
        hintText: hintText,
        hintStyle: TextStyle(
            color: Color(0xff828A95), fontSize: sizer(true, 16.0, context)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1.5,
            color: Color(0xff245DE8),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        suffixIconConstraints: BoxConstraints(
          maxHeight: 38,
          maxWidth: 38,
        ),
        suffixIcon: GestureDetector(
          child: Container(
              height: double.infinity,
              width: double.infinity,
              margin: EdgeInsets.only(right: 15),
              child:
                  Image.asset('assets/images/search.png', fit: BoxFit.contain)),
          onTap: action,
        ),
      ),
      validator: (val) {
        if (val.length == 0) {
          return hintText + " is required";
        } else {
          return null;
        }
      },
    );
  }
}
