import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';

class ToChatListItem extends StatefulWidget {
  final String message;
  ToChatListItem({
    Key key,
    @required this.message,
  }) : super(key: key);
  @override
  _ToChatListItemState createState() => _ToChatListItemState();
}

class _ToChatListItemState extends State<ToChatListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 9),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: Color(0xff2254D3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(widget.message,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500))),
                ),
              ),
              SizedBox(width: 5),
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                      'https://res.cloudinary.com/gorge/image/upload/v1592820243/Ellipse_25.png',
                      fit: BoxFit.cover,
                      width: 30,
                      height: 30)),
            ]));
  }
}
