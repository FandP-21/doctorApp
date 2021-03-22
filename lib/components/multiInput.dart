import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class MultiInput extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final bool enabled;
  final Color deepColor;
  final TextEditingController controller;
  final int maxLines;
  final int minLines;
  const MultiInput(
      {Key key,
      this.hintText,
      this.controller,
      this.enabled,
      this.onChanged,
      this.deepColor,
      this.maxLines,
      this.minLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      enabled: enabled ?? true,
      onSaved: onChanged,
      controller: controller ?? TextEditingController(),
      style: TextStyle(
          color: deepColor ?? Color(0xff071232),
          fontWeight: FontWeight.w500,
          fontSize: sizer(true, 16.0, context)),
      cursorColor: Color(0xff245DE8),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: sizer(false, 20, context),
            horizontal: sizer(true, 20, context)),
        fillColor: Color(0xffF3F4F8),
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
