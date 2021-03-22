import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'transactionSummary.dart';

class PaymentHistory extends StatefulWidget {
  PaymentHistory({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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
                          ],
                        ),
                        SizedBox(height: 15),
                        HeaderText(title: 'Transaction History'),
                        SizedBox(height: 28),
                        Container(
                          height: 1.0,
                          color: Color(0xffF3F4F8),
                        ),
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 6,
                              itemBuilder: (BuildContext context, int index) =>
                                  transactionBox(
                                      'NGN 2,500',
                                      'Subscription',
                                      '16 Jul 2020',
                                      index == 2 || index == 4 || index == 5
                                          ? true
                                          : false,
                                      index == 4 ? true : false)),
                        )
                      ]),
                ))));
  }

  Widget transactionBox(
      String amount, String type, String date, bool incoming, bool failed) {
    return Material(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => TransactionSummary(title: '')));
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xffF3F4F8), width: 0.8))),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    incoming
                        ? Container(
                            width: 40,
                            height: 40,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: failed
                                    ? Color.fromRGBO(255, 111, 79, 0.3)
                                    : Color.fromRGBO(34, 211, 137, 0.3)),
                            child: Image.asset(failed
                                ? "assets/images/incomingFailed.png"
                                : "assets/images/incoming.png"))
                        : Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromRGBO(255, 111, 79, 0.3)),
                            child: Center(
                                child: Icon(Icons.call_made,
                                    color: Color(0xffFF6F4F), size: 18))),
                    SizedBox(width: 11.89),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          amount,
                          style: TextStyle(
                              color: Color(0xff071232),
                              fontSize: sizer(true, 18, context),
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          type,
                          style: TextStyle(
                            color: Color(0xff8E919C),
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Text(
                      date,
                      style: TextStyle(
                        color: Color(0xff071232),
                        fontSize: sizer(true, 16, context),
                      ),
                    ),
                  ],
                ))));
  }
}
