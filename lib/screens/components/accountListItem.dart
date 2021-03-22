import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/models/digest.dart';

class AccountListItem extends StatefulWidget {
  final String title;
  final GestureTapCallback onPressed;
  final bool last;
  AccountListItem({
    Key key,
    @required this.title,
    @required this.onPressed,
    @required this.last,
  }) : super(key: key);
  @override
  _AccountListItemState createState() => _AccountListItemState();
}

class _AccountListItemState extends State<AccountListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              bottom: sizer(false, 4, context),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 15,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: widget.last ? Colors.white : Color(0xffF3F4F8),
                    width: 0.8),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Color(0xff071232),
                    fontSize: sizer(true, 16.0, context),
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xffF3F4F8),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.chevron_right,
                      size: sizer(true, 24, context),
                      color: Color(0xff091118),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
