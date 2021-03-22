import 'package:thcDoctorMobile/screens/auth/components/specialization.dart';
import 'package:flutter/material.dart';

class SpecializationSearchResult extends StatefulWidget {
  SpecializationSearchResult(
      {Key key,
      @required this.title,
      @required this.specialization,
      @required this.callback,
      @required this.mainId})
      : super(key: key);
  final String title;
  final int mainId;
  final List<dynamic> specialization;
  final VoidCallback callback;

  @override
  _SpecializationSearchResultState createState() =>
      _SpecializationSearchResultState();
}

class _SpecializationSearchResultState
    extends State<SpecializationSearchResult> {
  Color _defaultColor = Colors.white;
  Color _placeholderColor = Color.fromRGBO(7, 18, 50, 1);
  bool checkboxValue = false;
  bool _checkboxVisible = false;
  Color _arrowColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: Color.fromRGBO(243, 244, 248, 1),
          width: 1,
          style: BorderStyle.solid,
        ),
      )),
      child: Container(
        decoration: BoxDecoration(
          color: _defaultColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 35,
        margin: EdgeInsets.only(bottom: 5),
        child: FlatButton(
          padding: EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _checkboxVisible
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 1,
                              color: Color.fromRGBO(223, 232, 252, 1),
                            ),
                          ]),
                      margin: EdgeInsets.only(left: 15, right: 15),
                      height: 18,
                      width: 18,
                      child: Checkbox(
                        value: checkboxValue,
                        activeColor: _placeholderColor,
                        onChanged: (bool value) {
                          checkboxValue = value;
                        },
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(left: 10),
                    ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 250,
                    child: Text(widget.title,
                        style: TextStyle(color: _placeholderColor)),
                  ),
                  Container(
                    width: 20,
                    color: Colors.transparent,
                    child: Icon(Icons.arrow_forward_ios,
                        size: 14, color: _arrowColor),
                  ),
                ],
              ))
            ],
          ),
          color: Colors.transparent,
          onPressed: () {
            setState(() {
              checkboxValue = !checkboxValue;
              _checkboxVisible = !_checkboxVisible;
              if (_defaultColor == Colors.white) {
                _defaultColor = Color.fromRGBO(223, 232, 252, 1);
                _placeholderColor = Color.fromRGBO(34, 84, 211, 1);
                _arrowColor = Color.fromRGBO(34, 84, 211, 1);
                widget.callback();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Specialization(
                          mainId: widget.mainId,
                          specialization: widget.specialization,
                          speciality: widget.title)),
                );
              } else {
                _defaultColor = Colors.white;
                _placeholderColor = Color.fromRGBO(7, 18, 50, 1);
                _arrowColor = Colors.black;
              }
            });
          },
        ),
      ),
    );
  }
}
