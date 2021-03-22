import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/constants/strings.dart';
import 'package:thcDoctorMobile/models/call.dart';
import 'package:thcDoctorMobile/models/log.dart';
import 'package:thcDoctorMobile/models/user_.dart';
import 'package:thcDoctorMobile/resources/call_methods.dart';
import 'package:thcDoctorMobile/resources/local_db/repository/log_repository.dart';
import 'package:thcDoctorMobile/screens/callscreens/call_screen.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial(Map<String, dynamic> sender, Map<String, dynamic> reciever,
      BuildContext context) async {
    Call call = Call(
      callerId: sender['uid'],
      callerName: sender['name'],
      callerPic: sender['profilePhoto'],
      receiverId: sender['uid'],
      receiverName: sender['name'],
      receiverPic: sender['profilePhoto'],
      channelId: Random().nextInt(1000).toString(),
    );

    // Log log = Log(
    //   callerName: "from.name",
    //   callerPic: "from.profilePhoto",
    //   callStatus: CALL_STATUS_DIALLED,
    //   receiverName: "to.name",
    //   receiverPic: "to.profilePhoto",
    //   timestamp: DateTime.now().toString(),
    // );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      // enter log
      // LogRepository.addLogs(log);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(call: call),
        ),
      );
    }
  }
}
