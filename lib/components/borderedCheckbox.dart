import 'package:flutter/material.dart';

class BorderedCheckbox extends StatefulWidget {
  BorderedCheckbox({Key key, @required this.placeholder}) : super(key: key);

  final String placeholder;

  @override
  _BorderedCheckboxState createState() => _BorderedCheckboxState();
}

class _BorderedCheckboxState extends State<BorderedCheckbox> {
  Color _defaultColor = Color.fromRGBO(243, 244, 248, 1);
  Color _placeholderColor = Color.fromRGBO(7, 18, 50, 1);
  bool checkboxValue = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _defaultColor,
            ),
            height: 50,
          margin: EdgeInsets.only(top: 5, bottom: 5,),
          child: FlatButton(
            padding: EdgeInsets.all(0),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 1,
                    color: Color.fromRGBO(223, 232, 252, 1),
                  ),
                  ]
                ),
                margin: EdgeInsets.only(left: 15, right: 15),
                height: 18, width: 18,
                child: Checkbox(
                value: checkboxValue,
                activeColor: _placeholderColor,
                onChanged: (bool value){
                  checkboxValue = value;
                },
              ),
              ),
              Text(widget.placeholder, style: TextStyle(color: _placeholderColor, fontWeight: FontWeight.bold),),
            ],
            ),
          color: Colors.transparent,
          onPressed: () {
            setState(() {
              if (_defaultColor == Color.fromRGBO(243, 244, 248, 1)){
                _defaultColor = Color.fromRGBO(223, 232, 252, 1);
                _placeholderColor = Color.fromRGBO(34, 84, 211, 1);
                checkboxValue = true;
              } else {
                _defaultColor = Color.fromRGBO(243, 244, 248, 1);
                checkboxValue = false;
                _placeholderColor = Color.fromRGBO(7, 18, 50, 1);
              }
            });
          },
        ),
        )
      ],
    );
  }
}