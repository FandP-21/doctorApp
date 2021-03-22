import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:photo_view/photo_view.dart';
import 'package:thcDoctorMobile/components/backButtonBlack.dart';
import 'package:thcDoctorMobile/components/headerText.dart';
import 'package:thcDoctorMobile/helpers/sizeCalculator.dart';
import 'package:thcDoctorMobile/provider/image_upload_provider.dart';
import 'package:thcDoctorMobile/resources/auth_methods.dart';
import 'package:thcDoctorMobile/screens/components/accountListItem.dart';
import 'package:thcDoctorMobile/screens/dashboard/addMedication.dart';
import 'package:thcDoctorMobile/screens/dashboard/createHealthAlert.dart';
import 'package:thcDoctorMobile/screens/dashboard/patients/patientInfoBody.dart';
import 'package:thcDoctorMobile/screens/dashboard/referPatient.dart';
import 'package:thcDoctorMobile/screens/dashboard/requestMedicalData.dart';
import 'package:thcDoctorMobile/utils/call_utilities.dart';
import 'package:thcDoctorMobile/utils/permissions.dart';

class Chat extends StatefulWidget {
  final String peerId;
  final String peerAvatar, peerName;
  final String myAvatar, myName;

  Chat(
      {Key key,
      @required this.peerId,
      @required this.peerAvatar,
      @required this.myAvatar,
      @required this.myName,
      @required this.peerName})
      : super(key: key);

  final TextEditingController textEditingController = TextEditingController();

  @override
  _ChatState createState() => _ChatState();
}

@override
class _ChatState extends State<Chat> {
  ImageUploadProvider imageUploadProvider;
  final AuthMethods _authMethods = AuthMethods();

  Map<String, dynamic> sender, receiver;
  String _currentUserId;
  bool isWriting = false;

  @override
  void initState() {
    super.initState();
    _authMethods.getCurrentUser().then((user) {
      _currentUserId = user.uid;

      // setState(() {
      //   sender = {
      //     "uid": "n23Ge8CKhXgL8TUpZXKZbdWTLzM2",
      //     "name": widget.myName,
      //     "profilePhoto": widget.myAvatar,
      //   };

      //   receiver = {
      //     "uid": "Hd6steBvdwQwVMAfyIa31dM8F3O2",
      //     "name": widget.name,
      //     "profilePhoto": widget.peerAvatar,
      //   };
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    bottom: 20,
                    top: sizer(false, 50, context),
                    left: sizer(true, 20, context),
                    right: sizer(true, 20, context)),
                decoration: BoxDecoration(
                  color: Color(0xff071232),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    BackButtonBlack(onPressed: () {}),
                    SizedBox(width: sizer(true, 20, context)),
                    GestureDetector(
                      onTap: () => {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(widget.peerAvatar,
                            fit: BoxFit.cover, width: 45, height: 45),
                      ),
                    ),
                    SizedBox(width: sizer(true, 20, context)),
                    Text(
                      '${widget.peerName}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: sizer(true, 18, context)),
                    ),
                    SizedBox(width: sizer(true, 20, context)),
                    Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                          Material(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Color(0xff4b7aed),
                            child: GestureDetector(
                              onTap: () async => await Permissions
                                      .cameraAndMicrophonePermissionsGranted()
                                  ? CallUtils.dial({
                                      "uid":
                                          FirebaseAuth.instance.currentUser.uid,
                                      "name": widget.myName,
                                      "profilePhoto": widget.myAvatar,
                                    }, {
                                      "uid": widget.peerId,
                                      "name": widget.peerName,
                                      "profilePhoto": widget.peerAvatar,
                                    }, context)
                                  : {},
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Color(0xff1d2746),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.videocam,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: sizer(true, 15, context)),
                          Material(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              // side: BorderSide(color: Colors.red)
                            ),
                            color: Color(0xff4b7aed),
                            child: GestureDetector(
                              onTap: () => print('Call'),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xff1d2746),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.call,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]))
                  ],
                ),
              ),
              ChatScreen(
                  peerId: widget.peerId,
                  peerAvatar: widget.peerAvatar,
                  peerName: widget.peerName,
                  myName: widget.myName,
                  myAvatar: widget.myAvatar),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String peerId, myName;
  final String peerAvatar, peerName, myAvatar;

  ChatScreen(
      {Key key,
      @required this.peerId,
      @required this.peerAvatar,
      @required this.peerName,
      @required this.myName,
      @required this.myAvatar})
      : super(key: key);

  @override
  State createState() => ChatScreenState(
      peerId: peerId,
      peerAvatar: peerAvatar,
      myAvatar: myAvatar,
      peerName: peerName,
      myName: myName);
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState(
      {Key key,
      @required this.peerId,
      @required this.peerAvatar,
      @required this.peerName,
      @required this.myName,
      @required this.myAvatar});

  String peerId, myName;
  String peerAvatar, peerName, myAvatar;
  String id;

  List<QueryDocumentSnapshot> listMessage = new List.from([]);
  int _limit = 20;
  final int _limitIncrement = 20;
  String groupChatId;
  SharedPreferences prefs;
  String currentUser = FirebaseAuth.instance.currentUser.uid;

  File imageFile;
  bool isLoading;
  bool isShowSticker;
  String imageUrl;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the bottom");
      setState(() {
        print("reach the bottom");
        _limit += _limitIncrement;
      });
    }
    if (listScrollController.offset <=
            listScrollController.position.minScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the top");
      setState(() {
        print("reach the top");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);

    groupChatId = '';

    isLoading = false;
    isShowSticker = false;
    imageUrl = '';

    readLocal();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('firebaseId') ?? '';
    if (id.hashCode <= peerId.hashCode) {
      groupChatId = '$id-$peerId';
    } else {
      groupChatId = '$peerId-$id';
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'chattingWith': peerId});

    setState(() {});
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);

    if (imageFile != null) {
      setState(() {
        isLoading = true;
      });
      uploadFile();
    }
  }

  void getSticker() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, 1);
      });
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: 'This file is not an image');
    });
  }

  // pad(int n) {
  //   if (n < 10)
  //     return "0${n.toString()}";
  //   else
  //     return '${n.toString()[0]} ${n.toString()[1]}';
  // }

  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();

      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      var lastMessageReference = FirebaseFirestore.instance
          .collection('Contacts')
          .doc(peerId)
          .collection("contacts")
          .doc(myName)
          .collection("cache")
          .doc("lastmessage");

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'idFrom': id,
            'idTo': peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          lastMessageReference,
          {
            'day': DateTime.now().day,
            'content': content,
          },
        );
      });
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    if (document.data()['idFrom'] == id) {
      // Right (my message)
      return Row(
        children: <Widget>[
          document.data()['type'] == 0
              // Text
              ? Container(
                  child: Text(
                    document.data()['content'],
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: Color(0xff245DE8),
                      borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(
                      bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                      right: 10.0),
                )
              : document.data()['type'] == 1
                  // Image
                  ? Container(
                      child: FlatButton(
                        child: Material(
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                              width: 200.0,
                              height: 200.0,
                              padding: EdgeInsets.all(70.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Material(
                              child: Image.asset(
                                'assets/images/img_not_available.jpeg',
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              clipBehavior: Clip.hardEdge,
                            ),
                            imageUrl: document.data()['content'],
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          clipBehavior: Clip.hardEdge,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullPhoto(
                                      url: document.data()['content'])));
                        },
                        padding: EdgeInsets.all(0),
                      ),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                          right: 10.0),
                    )
                  // Sticker
                  : Container(
                      child: Image.asset(
                        'assets/images/${document.data()['content']}.gif',
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                          right: 10.0),
                    ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                isLastMessageLeft(index)
                    ? Material(
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Container(
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                            width: 35.0,
                            height: 35.0,
                            padding: EdgeInsets.all(10.0),
                          ),
                          imageUrl: peerAvatar,
                          width: 35.0,
                          height: 35.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                        clipBehavior: Clip.hardEdge,
                      )
                    : Container(width: 35.0),
                document.data()['type'] == 0
                    ? Container(
                        child: Text(
                          document.data()['content'],
                          style: TextStyle(color: Colors.black),
                        ),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        width: 200.0,
                        decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(8.0)),
                        margin: EdgeInsets.only(left: 10.0),
                      )
                    : document.data()['type'] == 1
                        ? Container(
                            child: FlatButton(
                              child: Material(
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
                                    ),
                                    width: 200.0,
                                    height: 200.0,
                                    padding: EdgeInsets.all(70.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Material(
                                    child: Image.asset(
                                      'assets/images/img_not_available.jpeg',
                                      width: 200.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                  imageUrl: document.data()['content'],
                                  width: 200.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                clipBehavior: Clip.hardEdge,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullPhoto(
                                            url: document.data()['content'])));
                              },
                              padding: EdgeInsets.all(0),
                            ),
                            margin: EdgeInsets.only(left: 10.0),
                          )
                        : Container(
                            child: Image.asset(
                              'assets/images/${document.data()['content']}.gif',
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                            margin: EdgeInsets.only(
                                bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                                right: 10.0),
                          ),
              ],
            ),

            // Time
            isLastMessageLeft(index)
                ? Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(document.data()['timestamp']))),
                      style: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic),
                    ),
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                  )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].data()['idFrom'] == id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].data()['idFrom'] != id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update({'chattingWith': null});
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              buildListMessage(),

              // Input content
              buildInput(),
            ],
          ),

          // Loading
          buildLoading()
        ],
      ),
      onWillPop: onBackPress,
    ));
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading ? const Loading() : Container(),
    );
  }

  Future snapImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    imageFile = File(pickedFile.path);
    print(imageFile);

    if (imageFile != null) {
      if (mounted)
        setState(() {
          isLoading = true;
        });
      uploadFile();
    }
  }

  Widget buildInput() {
    return Container(
      height: 55,
      margin: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
          left: sizer(true, 20, context), right: sizer(true, 20, context)),
      decoration: BoxDecoration(
        color: Color.fromRGBO(193, 201, 218, 0.3),
        borderRadius: BorderRadius.circular(65),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      snapImage();
                    },
                    child: Image.asset('assets/images/camera.png',
                        width: 24, height: 24, fit: BoxFit.contain),
                  ),
                ),
                SizedBox(
                  width: sizer(true, 9, context),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      onSubmitted: (value) {
                        onSendMessage(textEditingController.text, 0);
                      },
                      style:
                          TextStyle(color: Color(0xff8E919C), fontSize: 15.0),
                      controller: textEditingController,
                      textInputAction: TextInputAction.newline,
                      maxLines: null,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Enter a message',
                        hintStyle: TextStyle(
                            color: Color(0xff8E919C),
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic),
                      ),
                      focusNode: focusNode,
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            // IconButton(
            //   icon: Icon(Icons.send, size: 24),
            //   onPressed: () =>
            //       onSendMessage(textEditingController.text, 0),
            //   //color: Colors.green,
            // ),
            focusNode.hasFocus
                ? IconButton(
                    icon: Icon(Icons.send, size: 24),
                    onPressed: () =>
                        onSendMessage(textEditingController.text, 0),
                    //color: Colors.green,
                  )
                : Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Image.asset('assets/images/mic.png',
                          width: 22, height: 22, fit: BoxFit.contain),
                    ),
                  ),
            SizedBox(width: sizer(true, 10, context)),
            Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Image.asset('assets/images/image.png',
                    width: 32, height: 32, fit: BoxFit.contain),
              ),
            ),
            SizedBox(width: sizer(true, 10, context)),
            Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () => displayBottomSheet(context),
                child: Image.asset('assets/images/plus.png',
                    width: 24, height: 24, fit: BoxFit.contain),
              ),
            ),
            // SizedBox(width: sizer(true,5,context)),
            // Image.asset('assets/images/plus.png',
            //     width: 27,
            //     height: 27,
            //     fit: BoxFit.contain),
          ])
        ],
      ),
    );
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
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0),
                ),
              ),
              child: new SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      HeaderText(title: 'Manage Patient'),
                      SizedBox(height: 28),
                      AccountListItem(
                          last: false,
                          title: 'View patient profile',
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => PatientInfoBody()));
                          }),
                      AccountListItem(
                          last: false,
                          title: 'Add prescription/medication',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => AddMedication()),
                            );
                          }),
                      AccountListItem(
                          last: false,
                          title: 'Add medical note',
                          onPressed: () {}),
                      AccountListItem(
                          last: false,
                          title: 'Request medical data',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => RequestMedicalData()),
                            );
                          }),
                      AccountListItem(
                          last: false,
                          title: 'Schedule Appointment',
                          onPressed: () {
                            //   Navigator.of(context).push(
                            //   MaterialPageRoute(builder: (_) => Schedule()),
                            // );
                          }),
                      AccountListItem(
                          last: false,
                          title: 'Create Health Alert',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => CreateHealthAlert()),
                            );
                          }),
                      AccountListItem(
                          last: true,
                          title: 'Refer Patient',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => ReferPatient()),
                            );
                          }),
                      Center(
                          child: Material(
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                              //       color: Color(0xff245DE8),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                    margin: EdgeInsets.only(bottom: 19),
                                    padding: EdgeInsets.only(bottom: 18),
                                    decoration: BoxDecoration(
                                        //      color: Color(0xffffffff),
                                        //   borderRadius: BorderRadius.circular(10.0),
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color(0xffF3F4F8),
                                                width: 0.8))),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('Remove Patient',
                                            style: TextStyle(
                                                color: Color(0xff071232),
                                                fontSize: 16)),
                                        Material(
                                          color: Color(0xffF3F4F8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Color(0xffF3F4F8),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Center(
                                                  child: Icon(Icons.delete,
                                                      size: 17,
                                                      color: Colors.red)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              )))
                    ]),
              ));
        });
  }

  Widget buildListMessage() {
    return groupChatId == ''
        ? Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)))
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('messages')
                .doc(groupChatId)
                .collection(groupChatId)
                .orderBy('timestamp', descending: true)
                .limit(_limit)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue))));
              } else {
                listMessage.addAll(snapshot.data.documents);
                return Expanded(
                    child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (context, index) =>
                      buildItem(index, snapshot.data.documents[index]),
                  itemCount: snapshot.data.documents.length,
                  reverse: true,
                  controller: listScrollController,
                ));
              }
            },
          );
  }
}

class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
      ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}

class FullPhoto extends StatelessWidget {
  final String url;

  FullPhoto({Key key, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: FullPhotoScreen(url: url),
    );
  }
}

class FullPhotoScreen extends StatefulWidget {
  final String url;

  FullPhotoScreen({Key key, @required this.url}) : super(key: key);

  @override
  State createState() => FullPhotoScreenState(url: url);
}

class FullPhotoScreenState extends State<FullPhotoScreen> {
  final String url;

  FullPhotoScreenState({Key key, @required this.url});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(imageProvider: CachedNetworkImageProvider(url)));
  }
}
