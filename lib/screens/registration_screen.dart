import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'button.dart';
import 'textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool cheeck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: cheeck,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
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
              new textfiled(
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
                  setState(() {
                    cheeck = true;
                  });
                  try {
                    final newuser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newuser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      cheeck = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                name: 'Register',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
