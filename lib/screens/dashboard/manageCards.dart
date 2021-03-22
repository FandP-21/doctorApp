import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/components/plusButton.dart';
import 'package:thcDoctorMobile/components/backButtonWhite.dart';
import 'addCard.dart';

class ManageCards extends StatefulWidget {
  ManageCards({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ManageCardsState createState() => _ManageCardsState();
}

class _ManageCardsState extends State<ManageCards> {
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
                        HeaderText(title: 'Manage cards'),
                        SizedBox(height: 28),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '2 cards available',
                              style: TextStyle(
                                  color: Color(0xff8E919C),
                                  fontSize: sizer(true, 18, context)),
                            ),
                            PlusButton(onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => AddCard(title: '')));
                            }),
                          ],
                        ),
                        SizedBox(height: 36),
                        Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 2,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        card('Mastercard', '3878'))),
                      ]),
                ))));
  }

  Widget card(String type, String lastDigits) {
    return Container(
      margin: EdgeInsets.only(bottom: sizer(false, 20, context)),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xff2254D3),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(34, 84, 211, 0.3),
            spreadRadius: 3,
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/cardIcon.png',
            width: 26,
            height: 16,
          ),
          SizedBox(width: 10),
          Text(type,
              style: TextStyle(
                  color: Colors.white, fontSize: sizer(true, 20, context))),
          SizedBox(width: 6),
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
          ),
          SizedBox(width: 6),
          Text(lastDigits,
              style: TextStyle(
                  color: Colors.white, fontSize: sizer(true, 20, context))),
          Spacer(),
          Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                // side: BorderSide(color: Colors.red)
              ),
              color: Color(0xff436dda),
              child: GestureDetector(
                  onTap: () {},
                  child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Color(0xff436dda),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.delete,
                        size: 16,
                        color: Colors.white,
                      ))))
        ],
      ),
    );
  }
}
