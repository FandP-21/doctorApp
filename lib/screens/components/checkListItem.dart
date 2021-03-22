import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class CheckListItem extends StatefulWidget {
  final String title;
  final Function onPressed;
  final bool value;
  CheckListItem({Key key, @required this.title, this.onPressed, this.value})
      : super(key: key);
  @override
  _CheckListItemState createState() => _CheckListItemState();
}

class _CheckListItemState extends State<CheckListItem> {
  bool value = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              // side: BorderSide(color: Colors.red)
            ),
            //       color: Color(0xff245DE8),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                  margin: EdgeInsets.only(bottom: 19),
                  padding: EdgeInsets.only(bottom: sizer(false, 18, context)),
                  decoration: BoxDecoration(
                      //      color: Color(0xffffffff),
                      //   borderRadius: BorderRadius.circular(10.0),
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xffF3F4F8), width: 0.8))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Text(widget.title,
                              style: TextStyle(
                                  color: Color(0xff071232), fontSize: 16))),
                      Theme(
                          data: ThemeData(
                              unselectedWidgetColor: Color(0xffDFE8FC)),
                          child: Checkbox(
                            onChanged: widget.onPressed != null
                                ? (val) => widget.onPressed(val)
                                : (val) {
                                    setState(() {
                                      value = val;
                                    });
                                  },
                            value: widget.value != null ? widget.value : value,
                            activeColor: Color(0xff2254D3),
                            checkColor: Colors.white,
                          )),
                    ],
                  )),
            )));
  }
}
