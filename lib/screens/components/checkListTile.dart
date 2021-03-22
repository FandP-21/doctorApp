import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/helpers/store.dart';

class CheckListTile extends StatefulWidget {
  CheckListTile(
      {@required this.title,
      this.last,
      this.iconPresent,
      @required this.route});
  final String title;
  final bool last, iconPresent;
  final Widget route;

  @override
  _CheckListTileState createState() => _CheckListTileState();
}

class _CheckListTileState extends State<CheckListTile> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: sizer(false, 19, context)),
        decoration: BoxDecoration(
            border: Border(
                bottom: widget.last == null
                    ? BorderSide(color: Color(0xffF3F4F8), width: 1.0)
                    : BorderSide.none)),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    if (value == false)
                      setState(() => value = true);
                    else
                      setState(() => value = false);
                  },
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                        color: value ? blue : Color.fromRGBO(223, 232, 252, 1),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.all(10),
                    child: Checkbox(
                      onChanged: (val) => {},
                      value: value,
                      activeColor: blue,
                      checkColor: Colors.white,
                    ),
                  )),
              SizedBox(width: sizer(true, 17, context)),
              Text(widget.title,
                  style: TextStyle(
                      color: Color(0xff071232),
                      fontSize: sizer(true, 16.0, context))),
              Spacer(),
              SizedBox(width: 82.8),
              widget.iconPresent == null
                  ? IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => widget.route));
                      },
                      icon: Icon(Icons.info_outline,
                          color: Color(0xff245DE8),
                          size: sizer(true, 22, context)))
                  : SizedBox(
                      height: 22,
                    ),
            ]));
  }
}
