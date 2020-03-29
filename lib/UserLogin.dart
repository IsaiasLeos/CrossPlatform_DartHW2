import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inclasshomework/QuizParser.dart';

import 'HomePage.dart';
import 'ShowAlertDialog.dart';
import 'User.dart';

class UserLogin extends StatefulWidget {
  String title;
  static final String id = "user_login";

  UserLogin({this.title});

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  String title;

  _UserLoginState({Key key, this.title});

  static final TextEditingController emailEditingController = TextEditingController();
  static final TextEditingController passEditingController = TextEditingController();

  final emailField = TextField(
    autofocus: false,
    obscureText: false,
    keyboardType: TextInputType.emailAddress,
    controller: emailEditingController,
    decoration: InputDecoration(
        labelText: "Username",
        hintText: "Username",
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, style: BorderStyle.solid))),
  );

  final passwordField = TextField(
    autofocus: false,
    obscureText: true,
    keyboardType: TextInputType.text,
    controller: passEditingController,
    decoration: InputDecoration(
        labelText: "Password",
        hintText: "Password",
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, style: BorderStyle.solid))),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Column(
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: 125,
                  ),
                ),
                emailField,
                SizedBox(
                  height: 30,
                ),
                passwordField,
                SizedBox(
                  height: 50,
                ),
                Material(
                  child: MaterialButton(
                    onPressed: () async {
                      var user =
                          new User(emailEditingController.text, passEditingController.text, 1);
                      var tempCheck = new QuizParser(user);
                      var isGood = await tempCheck.getQuiz();
                      isGood = json.decode(isGood);
                      if (isGood['response']) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      user: user,
                                    )));
                      } else {
                        showAlertDialog(context, isGood['reason']);
                      }
                    },
                    textColor: Colors.white,
                    color: Colors.blue,
                    height: 50,
                    child: Text("LOGIN"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
