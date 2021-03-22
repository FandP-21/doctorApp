import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class SelectButton extends StatefulWidget {
  SelectButton({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SelectButtonState createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  int qty = 1;
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
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: sizer(false, 20, context),
          horizontal: sizer(true, 20, context)),
      decoration: BoxDecoration(
        color: Color(0xffF3F4F8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Select quantity',
            style: TextStyle(
                color: Color(0xff828A95), fontSize: sizer(true, 16.0, context)),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Material(
                  color: Color(0xffDFE8FC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (mounted)
                        setState(() {
                          if (qty != 0) {
                            qty--;
                          }
                        });
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: 30,
                          height: 30,
                          child: Icon(
                            Icons.remove,
                            size: 13,
                            color: Color(0xff2254D3),
                          ),
                        )),
                  )),
              SizedBox(width: 11.5),
              Text(qty.toString(),
                  style: TextStyle(
                      color: Colors.black, fontSize: sizer(true, 18, context))),
              SizedBox(width: 11.5),
              Material(
                  color: Color(0xffDFE8FC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (mounted)
                        setState(() {
                          qty++;
                        });
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: 30,
                          height: 30,
                          child: Icon(
                            Icons.add,
                            size: 13,
                            color: Color(0xff2254D3),
                          ),
                        )),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
