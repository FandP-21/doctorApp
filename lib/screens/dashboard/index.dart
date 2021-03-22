import 'dart:io';

import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/screens/dashboard/account.dart';
import 'dashboardBody.dart';
import 'patients/index.dart';
import 'messages/index.dart';
import 'schedule/index.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title, @required this.loading}) : super(key: key);
  final String title;
  final bool loading;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  bool _loading = false;
  final List<Widget> _children = [
    DashboardBody(),
    PatientBody(),
    Message(),
    Schedule(),
    Account(),
  ];
  @override
  void initState() {
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: LoadingOverlay(
        isLoading: _loading,
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          new BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? new Image.asset('assets/images/homeBlue.png',
                    width: 24, height: 24, fit: BoxFit.contain)
                : new Image.asset('assets/images/homeGrey.png',
                    width: 24, height: 24, fit: BoxFit.contain),
            title: Text('Home',
                style: TextStyle(color: Color(0xff828A95), fontSize: 12)),
          ),
          new BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? new Image.asset('assets/images/patientsBlue.png',
                    width: 24, height: 24, fit: BoxFit.contain)
                : new Image.asset('assets/images/patientsGrey.png',
                    width: 24, height: 24, fit: BoxFit.contain),
            title: Text('Patients',
                style: TextStyle(color: Color(0xff828A95), fontSize: 12)),
          ),
          new BottomNavigationBarItem(
            icon: _currentIndex == 2
                ? new Image.asset('assets/images/messagesBlue.png',
                    width: 24, height: 24, fit: BoxFit.contain)
                : new Image.asset('assets/images/messagesGrey.png',
                    width: 24, height: 24, fit: BoxFit.contain),
            title: Text('Messages',
                style: TextStyle(color: Color(0xff828A95), fontSize: 12)),
          ),
          new BottomNavigationBarItem(
            icon: _currentIndex == 3
                ? new Image.asset('assets/images/scheduleBlue.png',
                    width: 24, height: 24, fit: BoxFit.contain)
                : new Image.asset('assets/images/scheduleGrey.png',
                    width: 24, height: 24, fit: BoxFit.contain),
            title: Text('Schedule',
                style: TextStyle(color: Color(0xff828A95), fontSize: 12)),
          ),
          new BottomNavigationBarItem(
            icon: _currentIndex == 4
                ? new Image.asset('assets/images/accountBlue.png',
                    width: 24, height: 24, fit: BoxFit.contain)
                : new Image.asset('assets/images/accountGrey.png',
                    width: 24, height: 24, fit: BoxFit.contain),
            title: Text('Account',
                style: TextStyle(color: Color(0xff828A95), fontSize: 12)),
          )
        ],
      ),
    );
  }
}
