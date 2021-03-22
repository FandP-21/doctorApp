import 'package:flutter/material.dart';

class CenterLoader extends StatelessWidget {
  CenterLoader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          SizedBox(height: 10),
          CircularProgressIndicator(
            backgroundColor: Color(0xff245DE8),
          ),
          SizedBox(height: 10),
        ]));
  }
}
