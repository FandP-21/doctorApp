import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class DropdownWidget extends StatefulWidget {
  DropdownWidget(
      {this.store,
      this.title,
      this.altColor,
      this.altDropdownColor,
      this.altTextColor,
      this.onChanged,
      this.altArrowColor});
  final List store;
  final String title;
  final ValueChanged onChanged;
  final Color altColor, altArrowColor, altDropdownColor, altTextColor;

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String _title;

  @override
  void initState() {
    super.initState();
    setState(() {
      _title = widget.title;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: sizer(false, 16, context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: blue),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 20, top: 7, right: 20),
        height: 60,
        decoration: BoxDecoration(
          color: widget.altColor ?? Color(0xffF3F4F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButton<dynamic>(
          hint: Text(
            _title,
            style: TextStyle(
                color: widget.altTextColor ?? Color(0xff2254D3),
                fontFamily: 'SofiaPro',
                fontSize: sizer(true, 16.0, context)),
          ),
          items: widget.store.map((value) {
            return DropdownMenuItem<dynamic>(
              value: value,
              child: Text(value),
              onTap: () {
                setState(() {
                  _title = value;
                });
              },
            );
          }).toList(),
          onChanged: widget.onChanged,
          isExpanded: true,
          style: TextStyle(
              color: widget.altTextColor ?? Color(0xff828A95),
              fontFamily: 'SofiaPro',
              fontSize: 14),
          underline: SizedBox(),
          dropdownColor: widget.altDropdownColor ?? Colors.white,
          iconDisabledColor: Color(0xff2254D3),
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 20,
            color: widget.altArrowColor ?? Color(0xff2254D3),
          ),
        ),
      ),
    );
  }
}
