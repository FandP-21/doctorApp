import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/centerLoader.dart';
import 'package:thcDoctorMobile/components/emptyData.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/components/searchTextInput.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/models/doctor.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/services/chat.dart';

import '../../components/messageListItem.dart';

class Message extends StatefulWidget {
  Message({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  String firebaseID;
  bool isLoading = false;
  String currentUser = '';

  List messages;

  @override
  void initState() {
    super.initState();
    _setFirebaseID();
  }

  void _setFirebaseID() {
    if (FirebaseAuth.instance.currentUser.uid != null) {
      setState(() => currentUser = FirebaseAuth.instance.currentUser.uid);
      print("currentuser====$currentUser\n\n\n\n");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Doctor doctor = Doctor.fromJson(
        jsonDecode(Provider.of<UserModel>(context, listen: false).doctor)[0]);
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: EdgeInsets.only(
              left: sizer(true, 20, context),
              top: 70,
              right: sizer(true, 20, context)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderText(title: "Messages"),
              SizedBox(
                height: 20,
              ),
              SearchTextInput(
                hintText: 'Search',
                onChanged: (text) {},
              ),
              SizedBox(height: 10),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Contacts')
                      .doc(currentUser)
                      .collection("contacts")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CenterLoader();
                    } else {
                      try {
                        var key = snapshot.data.documents[0]["name"];
                        return ListView.builder(
                          padding: EdgeInsets.all(10.0),
                          itemBuilder: (context, index) {
                            return MessageListItem(
                                image:
                                    'https://res.cloudinary.com/adminixtrator/image/upload/v1605277853/icons8-user-male-64.png',
                                name: snapshot.data.documents[index]["name"],
                                message:
                                    "${snapshot.data.documents[index]["name"]} sent a message",
                                time:
                                    "${snapshot.data.documents[index]["time"]}",
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => Chat(
                                              myAvatar: "",
                                              myName: Provider.of<UserModel>(
                                                      context,
                                                      listen: false)
                                                  .name,
                                              peerName: snapshot.data
                                                  .documents[index]["name"],
                                              peerAvatar:
                                                  'https://res.cloudinary.com/adminixtrator/image/upload/v1605277853/icons8-user-male-64.png',
                                              peerId: snapshot.data
                                                  .documents[index]["userId"],
                                            )),
                                  );
                                });
                          },
                          itemCount: snapshot.data.documents.length,
                        );
                      } on RangeError {
                        return EmptyData(
                            title: 'You don\'t have any messages presently',
                            isButton: false);
                      }
                    }
                  },
                ),
              ),
            ],
          )),
    ));
  }
}
