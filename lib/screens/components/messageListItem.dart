import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';

class MessageListItem extends StatefulWidget {
  final String name;
  final String message;
  final String time, image;
  final GestureTapCallback onPressed;
  MessageListItem(
      {Key key,
      @required this.name,
      @required this.message,
      @required this.onPressed,
      @required this.image,
      @required this.time})
      : super(key: key);
  @override
  _MessageListItemState createState() => _MessageListItemState();
}

class _MessageListItemState extends State<MessageListItem> {
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
            ),
            child: GestureDetector(
              onTap: widget.onPressed,
              child: Container(
                  margin: EdgeInsets.only(bottom: 19),
                  padding: EdgeInsets.only(bottom: sizer(false, 18, context)),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xffF3F4F8), width: 0.8))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(widget.image,
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60)),
                      SizedBox(width: 18),
                      Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(widget.name,
                                      style: TextStyle(
                                          color: Color(0xff071232),
                                          fontSize: sizer(true, 16, context),
                                          fontWeight: FontWeight.w500)),
                                  Text(widget.time,
                                      style: TextStyle(
                                          color: Color(0xff245DE8),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              SizedBox(height: sizer(false, 7, context)),
                              Text(widget.message,
                                  style: TextStyle(
                                      color: Color(0xff828A95), fontSize: 14))
                            ],
                          )),
                    ],
                  )),
            )));
  }
}
