import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thcDoctorMobile/helpers/color.dart';
import 'package:thcDoctorMobile/provider/image_upload_provider.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/provider/user_provider.dart';
import 'package:thcDoctorMobile/screens/loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => new UserModel()),
    ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {});
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    _saveDeviceToken();
  }

  void _serialiseAndNavigate(Map<String, dynamic> message, String id) {
    var notificationData = message['data'];
    var view = notificationData['view'];
    var groupChatId = notificationData['groupChatId'];
    var deviceToken = notificationData['deviceToken'];
    var name = notificationData['name'];
    var peerId = notificationData['id'];
    if (view != null) {
      // Navigate to the create post view
      // if (view == 'chat') {
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //         builder: (_) => Chat(
      //               groupChatId: groupChatId,
      //               peerId: peerId,
      //               id: id,
      //               deviceToken: deviceToken,
      //             )),
      //   );
      // }
    }
  }

  void _saveDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = (prefs.getString('main_id') ?? '');

    if (id != '') {
      // FirebaseUser user = await _auth.currentUser();

      // Get the token for this device
      String fcmToken = await _fcm.getToken();

      // Save it to Firestore
      if (fcmToken != null) {
        Provider.of<UserModel>(context, listen: false).setDeviceToken(fcmToken);
        var user = _db.collection('users').doc(id);

        await user.set({
          'deviceToken': fcmToken,
          'createdAt': FieldValue.serverTimestamp(), // optional
          'platform': Platform.operatingSystem // optional
        }, SetOptions(merge: true));
      } else {
        print('\n');
        print('\n');
        print('\n');
        print('\n' + '-------');
        print('\n');
        print('\n');
        print('\n');
      }
      _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          _serialiseAndNavigate(message, id);
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          _serialiseAndNavigate(message, id);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff071232),
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Total Health Care',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: colorCustom,
        unselectedWidgetColor: Colors.transparent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'SofiaPro',
      ),
      home: Loader(title: 'THC'),
    );
  }
}
