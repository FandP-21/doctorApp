import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
import 'package:thcDoctorMobile/provider/user.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'package:thcDoctorMobile/screens/components/accountListItem.dart';
import 'package:thcDoctorMobile/screens/dashboard/consultancyRates/index.dart';
import 'package:thcDoctorMobile/screens/dashboard/manageCards.dart';
import 'package:thcDoctorMobile/screens/dashboard/paymentHistory.dart';
import 'package:thcDoctorMobile/screens/dashboard/payoutOptions.dart';

class BillingDetails extends StatefulWidget {
  BillingDetails({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BillingDetailsState createState() => _BillingDetailsState();
}

class _BillingDetailsState extends State<BillingDetails> {
  @override
  void initState() {
    super.initState();
  }

  bool ratesVisible = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() => ratesVisible =
        Provider.of<UserModel>(context, listen: false).ratesVisible);
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
      padding:
          EdgeInsets.only(top: sizer(false, 50, context), left: 20, right: 20),
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
            SizedBox(height: 20),
            HeaderText(title: 'Billing & Payments'),
            SizedBox(height: 27),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff2254D3),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Container(
                    height: 132,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/adBackground.png"),
                          fit: BoxFit.cover,
                        ),
                        color: Color(0xff1E4AB8),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Montserrat',
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "NGN ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                            text: "200,000",
                                            style: TextStyle(
                                              fontSize: 32,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        TextSpan(
                                            text: ".00",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ]),
                                ),
                                Opacity(
                                    opacity: 0.8,
                                    child: Text(
                                      'TOTAL EARNINGS',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ))
                              ]),
                          Spacer(),
                          GestureDetector(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 31,
                                decoration: BoxDecoration(
                                  color: darkBlue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.only(left: 8, right: 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      'All time',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )),
                                    Icon(Icons.arrow_drop_down,
                                        color: Colors.white, size: 16),
                                  ],
                                ),
                              ))
                        ])),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xffF3F4F8),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      'Hide consultancy rates from profile',
                      style: TextStyle(color: Color(0xff2254D3), fontSize: 15),
                    )),
                    GestureDetector(
                        onTap: () {
                          if (ratesVisible == true)
                            Provider.of<UserModel>(context, listen: false)
                                .setRatesVisible(false);
                          else
                            Provider.of<UserModel>(context, listen: false)
                                .setRatesVisible(true);
                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Image.asset(
                              Provider.of<UserModel>(context).ratesVisible
                                  ? 'assets/images/off.png'
                                  : 'assets/images/on.png',
                              height: 40,
                            )))
                  ]),
            ),
            SizedBox(height: 25),
            Text('Billing',
                style: TextStyle(
                    color: Color(0xff2254D3),
                    fontSize: sizer(true, 18, context),
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 5),
            AccountListItem(
                last: false,
                title: 'Payout options',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => PayoutOptions()),
                  );
                }),
            AccountListItem(
                last: false,
                title: 'Manage consultancy rates',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ConsultancyIndex()),
                  );
                }),
            AccountListItem(
                last: true,
                title: 'Manage cards',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ManageCards()),
                  );
                }),
            SizedBox(height: 25),
            Text('Payments',
                style: TextStyle(
                    color: Color(0xff2254D3),
                    fontSize: sizer(true, 18, context),
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 5),
            AccountListItem(
                last: true,
                title: 'View transaction history',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => PaymentHistory()),
                  );
                }),
            SizedBox(height: 20),
          ]),
    ))));
  }
}
