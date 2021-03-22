import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/buttonBlue.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/screens/dashboard/dashboardBody.dart';
import '../../components/menuDropdown.dart';
import 'package:thcDoctorMobile/components/multiInput.dart';
import '../../components/appointmentSuccess.dart';
import 'package:loading_overlay/loading_overlay.dart';

class BookFacility extends StatefulWidget {
  BookFacility({
    Key key,
  }) : super(key: key);

  @override
  _BookFacilityState createState() => _BookFacilityState();
}

class _BookFacilityState extends State<BookFacility> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loading = false;
  String dateTime = '';
  String duration = '';
  String description = '';
  String time = '';
  String date = '';
  String selected = '';
  bool _autoValidate = false;
  bool value = false;
  String apartment = 'Operating theater';
  String card = 'Select card';
  CalendarController _controller = new CalendarController();
  @override
  void initState() {
    super.initState();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    date = DateFormat('yyyy-MM-dd').format(day);
    String d = date.split('-')[2];
    String m = monthsLower[int.parse(date.split('-')[1])];
    String y = date.split('-')[0];
    setState(() {
      date = '$m $d, $y';
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: LoadingOverlay(
            child: SafeArea(
                child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.only(
                    top: sizer(false, 50, context), left: 20, right: 20),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          BackButtonWhite(
                            onPressed: () {},
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 11),
                              decoration: BoxDecoration(
                                color: Color(0xffF3F4F8),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                  child: Image.asset(
                                      'assets/images/appointmentBlue.png',
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.contain))),
                        ],
                      ), //
                      SizedBox(height: 15),
                      HeaderText(title: 'Schedule your booking'),
                      SizedBox(height: 26),
                      Container(
                        margin:
                            EdgeInsets.only(bottom: sizer(false, 16, context)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 20, top: 7, right: 20),
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xffF3F4F8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<dynamic>(
                            hint: Text(
                              apartment,
                              style: TextStyle(
                                  color: Color(0xff2254D3),
                                  fontFamily: 'SofiaPro',
                                  fontSize: sizer(true, 16.0, context)),
                            ),
                            items: [
                              'Operating theater',
                              'Operating theater',
                              'Operating theater'
                            ].map((value) {
                              return DropdownMenuItem<dynamic>(
                                value: value,
                                child: Text(value),
                                onTap: () {
                                  setState(() {
                                    apartment = value;
                                  });
                                },
                              );
                            }).toList(),
                            onChanged: (value) => {},
                            isExpanded: true,
                            style: TextStyle(
                                color: Color(0xff828A95),
                                fontFamily: 'SofiaPro',
                                fontSize: 14),
                            underline: SizedBox(),
                            dropdownColor: Colors.white,
                            iconDisabledColor: Color(0xff2254D3),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                              color: Color(0xff2254D3),
                            ),
                          ),
                        ),
                      ),
                      MultiInput(
                        minLines: 4,
                        maxLines: 4,
                        hintText: 'Description',
                        enabled: false,
                      ),
                      SizedBox(height: 12),
                      Container(
                        margin:
                            EdgeInsets.only(bottom: sizer(false, 16, context)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 20, top: 7, right: 20),
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xffF3F4F8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<dynamic>(
                            hint: Text(
                              card,
                              style: TextStyle(
                                  color: Color(0xff2254D3),
                                  fontFamily: 'SofiaPro',
                                  fontSize: sizer(true, 16.0, context)),
                            ),
                            items: [
                              'Mastercard . 3878',
                              'Mastercard . 3879',
                              'Mastercard . 3840',
                            ].map((value) {
                              return DropdownMenuItem<dynamic>(
                                value: value,
                                child: Text(value),
                                onTap: () {
                                  setState(() {
                                    card = value;
                                  });
                                },
                              );
                            }).toList(),
                            onChanged: (value) => {},
                            isExpanded: true,
                            style: TextStyle(
                                color: Color(0xff828A95),
                                fontFamily: 'SofiaPro',
                                fontSize: 14),
                            underline: SizedBox(),
                            dropdownColor: Colors.white,
                            iconDisabledColor: Color(0xff2254D3),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                              color: Color(0xff2254D3),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 14),
                      Text('Select a day',
                          style: TextStyle(
                              color: Color(0xff071232),
                              fontSize: sizer(true, 16, context),
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 5),
                      Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(243, 244, 248, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: TableCalendar(
                            calendarController: _controller,
                            initialCalendarFormat: CalendarFormat.month,
                            availableCalendarFormats: const {
                              CalendarFormat.month: 'Month view',
                              // CalendarFormat.week: 'Week view',
                            },
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            calendarStyle: CalendarStyle(
                                selectedColor: Color(0xff245DE8),
                                todayColor: blue.withOpacity(0.2),
                                markersColor: Colors.green,
                                outsideDaysVisible: false,
                                weekdayStyle: TextStyle(
                                  color: inputGrey,
                                ),
                                renderDaysOfWeek: true,
                                weekendStyle: TextStyle(
                                  color: inputGrey,
                                )),
                            headerStyle: HeaderStyle(
                              titleTextStyle: TextStyle(
                                  color: Color(0xff245DE8),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              formatButtonTextStyle: TextStyle().copyWith(
                                  color: Color(0xff245DE8), fontSize: 15.0),
                              formatButtonDecoration: BoxDecoration(
                                color: Colors.deepOrange[400],
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            onDaySelected: _onDaySelected,
                            onVisibleDaysChanged: _onVisibleDaysChanged,
                            onCalendarCreated: _onCalendarCreated,
                          )),
                      SizedBox(height: 10),
                      Center(
                          child: Container(
                              margin: EdgeInsets.only(top: 10.0, bottom: 30),
                              width: MediaQuery.of(context).size.width,
                              child: ButtonBlue(
                                title: 'NEXT',
                                onPressed: () => displayBottomSheet(context),
                              ))),
                      SizedBox(height: 10),
                    ]),
              )),
            )),
            isLoading: loading));
  }

  Widget greyHolder(String text) {
    return (Container(
        decoration: BoxDecoration(
          color: Color(0xffDFE8FC),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(vertical: 1.5, horizontal: 5),
        margin: EdgeInsets.only(right: 5),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Color(0xff2254D3), fontSize: 14),
          ),
        )));
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(20.0),
            topRight: const Radius.circular(20.0),
          ),
        ),
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.89,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0),
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  HeaderText(title: 'Select a Time'),
                  SizedBox(height: 11),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            greyHolder(date),
                            // greyHolder(duration),
                          ])),
                  SizedBox(height: 29),
                  BigGreyHolder(
                      title: '9:00 AM',
                      onPressed: () {
                        setState(() {
                          time = '09:00:00';
                        });
                      }),
                  SizedBox(height: 11),
                  BigGreyHolder(
                      title: '11:00 AM',
                      onPressed: () {
                        setState(() {
                          time = '11:00:00';
                        });
                      }),
                  SizedBox(height: 11),
                  BigGreyHolder(
                      title: '12:00 PM',
                      onPressed: () {
                        setState(() {
                          time = '12:00:00';
                        });
                      }),
                  SizedBox(height: 11),
                  BigGreyHolder(
                      title: '1:00 PM',
                      onPressed: () {
                        setState(() {
                          time = '13:00:00';
                        });
                      }),
                  SizedBox(height: 11),
                  BigGreyHolder(
                      title: '2:00 PM',
                      onPressed: () {
                        setState(() {
                          time = '14:00:00';
                        });
                      }),
                  SizedBox(height: 80),
                  ButtonBlue(
                      title: "COMPLETE REQUEST",
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppointmentSuccess()))),
                ]),
          );
        });
  }
}

class BigGreyHolder extends StatefulWidget {
  BigGreyHolder({@required this.title, @required this.onPressed});
  final VoidCallback onPressed;
  final String title;
  @override
  _BigGreyHolderState createState() => _BigGreyHolderState();
}

class _BigGreyHolderState extends State<BigGreyHolder> {
  String selected = '';
  @override
  Widget build(BuildContext context) {
    return Material(
        color: selected == widget.title ? Color(0xffDFE8FC) : backgroundGrey,
        borderRadius: BorderRadius.circular(5),
        child: GestureDetector(
            onTap: () {
              if (selected == '')
                setState(() => selected = widget.title);
              else
                setState(() => selected = '');
              widget.onPressed();
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.symmetric(vertical: 13.5, horizontal: 5),
                margin: EdgeInsets.only(right: 5),
                child: Center(
                  child: Text(
                    widget.title,
                    style: TextStyle(color: Color(0xff2254D3), fontSize: 16),
                  ),
                ))));
  }
}
