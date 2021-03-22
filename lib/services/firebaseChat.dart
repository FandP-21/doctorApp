// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
import 'package:thcDoctorMobile/helpers/store.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:thcDoctorMobile/services/chat.dart';

// class FirebaseChat extends StatefulWidget {
//   @override
//   _FirebaseChatState createState() => _FirebaseChatState();
// }

// class _FirebaseChatState extends State<FirebaseChat> {
//   @override
//   void initState() {
//     super.initState();
//     this._setFirebaseID();
//   }

//   void _setFirebaseID() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       firebaseID = prefs.getString("firebaseId");
//     });
//     print("\n\n\n\n\n\n\n$firebaseID\n\n\n\n");
//   }

//   String firebaseID;
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'MAIN',
//           style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: WillPopScope(
//         child: Stack(
//           children: <Widget>[
//             // List
//             Container(
//               child: StreamBuilder(
//                 stream:
//                     FirebaseFirestore.instance.collection('users').snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData == false || snapshot.data == null) {
//                     return Center(
//                       child: CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//                       ),
//                     );
//                   } else {
//                     print("\n\n\n${snapshot.data.documents[1].data()}\n\n\n");
//                     return ListView.builder(
//                       padding: EdgeInsets.all(10.0),
//                       itemBuilder: (context, index) =>
//                           buildItem(context, snapshot.data.documents[index]),
//                       itemCount: snapshot.data.documents.length,
//                     );
//                   }
//                 },
//               ),
//             ),

//             Positioned(
//               child: isLoading ? const Loading() : Container(),
//             )
//           ],
//         ),
//         onWillPop: null,
//       ),
//     );
//   }

//   Widget buildItem(BuildContext context, DocumentSnapshot document) {
//     if (document.data()['id'] == firebaseID) {
//       return Container();
//     } else {
//       return Container(
//         child: FlatButton(
//           child: Row(
//             children: <Widget>[
//               Material(
//                 child: document.data()['photoUrl'] != null
//                     ? CachedNetworkImage(
//                         placeholder: (context, url) => Container(
//                           child: CircularProgressIndicator(
//                             strokeWidth: 1.0,
//                             valueColor:
//                                 AlwaysStoppedAnimation<Color>(Colors.blue),
//                           ),
//                           width: 50.0,
//                           height: 50.0,
//                           padding: EdgeInsets.all(15.0),
//                         ),
//                         imageUrl: document.data()['photoUrl'],
//                         width: 50.0,
//                         height: 50.0,
//                         fit: BoxFit.cover,
//                       )
//                     : Icon(
//                         Icons.account_circle,
//                         size: 50.0,
//                         color: Colors.grey[300],
//                       ),
//                 borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                 clipBehavior: Clip.hardEdge,
//               ),
//               Flexible(
//                 child: Container(
//                   child: Column(
//                     children: <Widget>[
//                       Container(
//                         child: Text(
//                           'Nickname: ${document.data()['nickname']}',
//                           style: TextStyle(color: Colors.green),
//                         ),
//                         alignment: Alignment.centerLeft,
//                         margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
//                       ),
//                       Container(
//                         child: Text(
//                           'About me: ${document.data()['aboutMe'] ?? 'Not available'}',
//                           style: TextStyle(color: Colors.green),
//                         ),
//                         alignment: Alignment.centerLeft,
//                         margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
//                       )
//                     ],
//                   ),
//                   margin: EdgeInsets.only(left: 20.0),
//                 ),
//               ),
//             ],
//           ),
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => Chat(
//                       myAvatar: "",
//                       myName: "${Provider.of<UserModel>(context, listen: false).lname} ${Provider.of<UserModel>(context, listen: false).name}",
//                       name: "Debug Testing",
//                           peerId: document.id,
//                           peerAvatar: document.data()['photoUrl'],
//                         )));
//           },
//           color: Colors.grey[300],
//           padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//         ),
//         margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
//       );
//     }
//   }
// }

// class Loading extends StatelessWidget {
//   const Loading();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: CircularProgressIndicator(
//           valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//         ),
//       ),
//       color: Colors.white.withOpacity(0.8),
//     );
//   }
// }
