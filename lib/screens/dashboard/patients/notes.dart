import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcDoctorMobile/components/centerLoader.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/models/note.dart';
import 'package:thcDoctorMobile/models/patientInfo.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/screens/dashboard/dashboardBody.dart';

class Notes extends StatefulWidget {
  Notes({this.key, this.title, @required this.patientInfo});
  final String title;
  final GlobalKey<ScaffoldState> key;
  final PatientInfo patientInfo;

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  bool loading = true;
  List<dynamic> _notes = [];

  @override
  void initState() {
    super.initState();
    this._offlineData();
  }

  Future _offlineData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(widget.patientInfo.user.email + 'DoctorNotes')) {
      setState(() {
        _notes = jsonDecode(
            prefs.getString(widget.patientInfo.user.email + 'DoctorNotes'));
        loading = false;
      });
    } else {
      setState(() => loading = false);
    }
    this.fetchNotes();
  }

  Future<Null> fetchNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = Provider.of<UserModel>(context, listen: false).baseUrl;
    String token = Provider.of<UserModel>(context, listen: false).token;
    String id = Provider.of<UserModel>(context, listen: false).id;

    try {
      var response = await http.get(url + 'notes/$id/', headers: {
        "Connection": 'keep-alive',
        "Authorization": "Bearer " + token
      });

      setState(() => _notes = jsonDecode(response.body));
      prefs.setString(
          widget.patientInfo.user.email + 'DoctorNotes', response.body);
    } on SocketException {
      widget.key.currentState
          .showSnackBar(SnackBar(content: Text('No internet connection!')));
    }
    setState(() => loading = false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: sizer(false, 28, context), left: 20, right: 20),
      child: !loading
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: _notes.length,
              itemBuilder: (context, index) =>
                  NotesBody(note: Note.fromJson(_notes[index])))
          : CenterLoader(),
    );
  }
}

class NotesBody extends StatelessWidget {
  NotesBody({this.note});
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: backgroundGrey,
          width: 0.8,
        ))),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 15),
              Text(
                formatDateString(note.dateLastModified) + ' - ' + '6:00pm',
                style: TextStyle(color: Color(0xff2254D3), fontSize: 14),
              ),
              SizedBox(height: 7),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Color(0xffFEF5D8),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Title',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff071232)),
                      ),
                      SizedBox(height: 6),
                      Text(note.doctorNotes),
                    ],
                  ))
            ]));
  }

  static String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    var formatter = DateFormat('dd MM yyyy');
    var date = formatter.format(dateTime).toString();
    var coloured = date.split(' ');
    return coloured[0].toString() +
        ' ' +
        monthsStripped[int.parse(coloured[1]) - 1].toString() +
        ' ' +
        coloured[2].toString();
  }
}
