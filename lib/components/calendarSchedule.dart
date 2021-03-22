import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';

class CalendarSchedule extends StatefulWidget {
  CalendarSchedule(
      {@required this.day,
      @required this.time,
      @required this.callback,
      @required this.index,
      @required this.selections});
  final String day;
  final List<String> time;
  final Function callback;
  final List<dynamic> selections;
  final int index;
  @override
  _CalendarScheduleState createState() => _CalendarScheduleState();
}

class _CalendarScheduleState extends State<CalendarSchedule> {
  @override
  void initState() {
    super.initState();
  }

  bool _checkState = false;
  bool expand = false;
  bool clearSelection = false;

  void extend() {
    setState(() => expand = true);
  }

  void callback(index) {
    setState(() => clearSelection = false);
    setState(() => _checkState = true);
    widget.callback(widget.index, index);
  }

  void selectionToggle(value) {
    setState(() => _checkState = value);
    if (value == false) setState(() => clearSelection = true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 40,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Color.fromRGBO(231, 238, 255, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.day,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    )),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: blue, width: 0.8),
                      color: _checkState ? blue : white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Checkbox(
                    value: _checkState,
                    activeColor: blue,
                    checkColor: white,
                    onChanged: (value) => selectionToggle(value),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                border: Border.all(
                  color: Color.fromRGBO(243, 244, 248, 1),
                  width: 0.8,
                )),
            child: Wrap(
              runSpacing: 10,
              spacing: 18,
              children: List.generate(
                  expand
                      ? widget.time.length
                      : widget.time.length > 12
                          ? 12
                          : widget.time.length,
                  (index) => CircularCheck(
                        callback: () => callback(index),
                        time: widget.time[index],
                        expand: extend,
                        expanded: expand,
                        selected: clearSelection
                            ? false
                            : widget.selections[index] == index
                                ? true
                                : false,
                        index: index,
                        last: expand
                            ? true
                            : index == 11
                                ? false
                                : true,
                      )),
            ),
          ),
        ],
      ),
    );
  }
}

class CircularCheck extends StatefulWidget {
  CircularCheck(
      {@required this.callback,
      @required this.time,
      @required this.last,
      @required this.expanded,
      @required this.expand,
      this.selected,
      @required this.index});
  final VoidCallback expand;
  final Function callback;
  final String time;
  final bool last, expanded;
  var selected;
  final int index;
  @override
  _CircularCheckState createState() => _CircularCheckState();
}

class _CircularCheckState extends State<CircularCheck> {
  bool checked = false;

  @override
  void initState() {
    super.initState();
  }

  void updateState() {
    if (checked == false)
      setState(() => checked = true);
    else
      setState(() => checked = false);
    widget.callback();
  }

  void extend() {
    widget.expand();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      widget.last
          ? GestureDetector(
              onTap: updateState,
              child: Container(
                height: 33,
                width: 33,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.selected ?? checked
                      ? blue
                      : Color.fromRGBO(231, 238, 255, 1),
                ),
                child: widget.selected ?? checked
                    ? Icon(Icons.check, color: white, size: 20)
                    : SizedBox(),
              ))
          : GestureDetector(
              onTap: widget.index == 11 && widget.expanded == false
                  ? extend
                  : updateState,
              child: Container(
                height: 33,
                width: 33,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(231, 238, 255, 1),
                ),
                child: Icon(Icons.add, color: blue, size: 20),
              )),
      SizedBox(height: 5),
      widget.last
          ? Text(
              widget.time,
              style: TextStyle(
                color: Color.fromRGBO(130, 138, 149, 1),
                fontSize: 12,
                fontFamily: 'Metropolis',
                fontWeight: FontWeight.normal,
              ),
            )
          : SizedBox(),
    ]);
  }
}
