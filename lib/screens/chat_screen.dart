import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseUser loggeduser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final masgedit = TextEditingController();
  final _cloud = Firestore.instance;
  String massagetext;
  final _auth = FirebaseAuth.instance;

  final bool cg = true;

  @override
  void initState() {
    super.initState();
    getcurentuser();
  }

  void getcurentuser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggeduser = user;
        print(loggeduser.email);
      }
    } catch (e) {
      print(e);
    }
  }

//  void getmessage() async {
//    final massges = await _cloud.collection('massage').getDocuments();
//    for (var masseg in massges.documents) {
//      print(masseg.data);
//    }
//  }

  void massageshot() async {
    await for (var snap in _cloud.collection('massage').snapshots()) {
      for (var masseg in snap.documents) {
        print(masseg.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _cloud.collection('massage').snapshots(),
              builder: (context, snap) {
                if (snap.hasData) {
                  final massages = snap.data.documents.reversed;
                  List<masgebuble> massegbubles = [];
                  for (var massge in massages) {
                    final massgettext = massge.data['text'];
                    final msgsender = massge.data['sender'];
                    final curentuser = loggeduser.email;

                    final masgBubl = masgebuble(
                      texet: massgettext,
                      sender: msgsender,
                      isme: curentuser == msgsender,
                    );
                    massegbubles.add(masgBubl);
                  }
                  return Container(
                    child: Expanded(
                      child: ListView(
                        reverse: true,
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        children: massegbubles,
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: masgedit,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        massagetext = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      masgedit.clear();
                      _cloud.collection('massage').add({
                        'text': massagetext,
                        'sender': loggeduser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class masgebuble extends StatelessWidget {
  masgebuble({this.sender, this.texet, this.isme});
  final String sender;
  final String texet;
  final bool isme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Material(
            elevation: 10,
            color: isme ? Colors.blueAccent : Colors.white70,
            borderRadius: isme
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                texet,
                style: TextStyle(color: isme ? Colors.white : Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
