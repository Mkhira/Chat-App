import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'textField.dart';
import 'button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool check = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
//        color: Colors.black,
//        opacity: 3,
        inAsyncCall: check,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Hero(
                    tag: 'logo',


                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                textfiled(
                  textInputType: TextInputType.emailAddress,
                  obs: false,
                  change: (value) {
                    email = value;
                  },
                  text: "Enter your email",
                ),
                SizedBox(
                  height: 8.0,
                ),
                textfiled(
                  obs: true,
                  change: (value) {
                    password = value;
                  },
                  text: "Enter your password",
                ),
                SizedBox(
                  height: 24.0,
                ),
                Button(
                  prees: () async {
                    if (email == null || password == null) {
                      setState(() {
                        check = false;
                      });
                    } else {
                      setState(() {
                        check = true;
                      });
                    }
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        check = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  name: 'Login',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
