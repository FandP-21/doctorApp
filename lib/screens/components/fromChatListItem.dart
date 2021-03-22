import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';

class FromChatListItem extends StatefulWidget {
  final String message;
  FromChatListItem({
    Key key,
    @required this.message,
  }) : super(key: key);
  @override
  _FromChatListItemState createState() => _FromChatListItemState();
}

class _FromChatListItemState extends State<FromChatListItem> {
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
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                      'https://res.cloudinary.com/gorge/image/upload/v1592820243/Ellipse_25.png',
                      fit: BoxFit.cover,
                      width: 30,
                      height: 30)),
              SizedBox(width: 5),
              Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: Color(0xffDFE8FC),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(widget.message,
                          style: TextStyle(
                              color: Color(0xff364354),
                              fontSize: 14,
                              fontWeight: FontWeight.w500))),
                ),
              )
            ]));
  }
}
