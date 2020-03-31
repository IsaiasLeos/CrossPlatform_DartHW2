import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'HomePage.dart';
import 'MaterialColor.dart';
import 'QuizParser.dart';
import 'ShowAlertDialog.dart';
import 'User.dart';

///used for connecting with the server to authenticate and return response for a valid user
int quizNumber = 0;

///login page for the user to input credentials
class UserLogin extends StatefulWidget {
  static final String id = "user_login";

  UserLogin();

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  _UserLoginState({Key key});

  static final TextEditingController emailEditingController = TextEditingController();
  static final TextEditingController passEditingController = TextEditingController();

  ///email input + ui design
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

  ///password input + ui design
  final passwordField = TextField(
    autofocus: false,
    ///prevent text from showing
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
      backgroundColor: createMaterialColor(Color(0xffd6d6d6)),
      appBar: AppBar(
        title: Text(
          'Login Page',
          style: GoogleFonts.spectral(
              textStyle: TextStyle(
                  color: createMaterialColor(Color(0xffeeeeeee)),
                  letterSpacing: .5,
                  fontWeight: FontWeight.bold,
                  fontSize: 35)),
        ),
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
                ///email widget
                emailField,
                SizedBox(
                  height: 30,
                ),
                ///password widget
                passwordField,
                SizedBox(
                  height: 50,
                ),
                Material(
                  child: MaterialButton(
                    onPressed: () async {
                      ///populate user information after clicking login
                      var user = new User(emailEditingController.text, passEditingController.text);
                      ///used for validating if its a correct user.
                      var tempCheck = new QuizParser(user, quizNumber);
                      ///obtain a quiz, if a valid quiz is return user is autheticated with server
                      var isGood = await tempCheck.getQuiz();
                      isGood = json.decode(isGood);
                      ///check the response code the server returned
                      if (isGood['response']) {
                        ///if valid navigate to homepage
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                  ///pass user information
                                      user: user,
                                    )));
                      } else {

                        ///show reason for issues with server
                        showAlertDialog(context, isGood['reason']);
                      }
                    },
                    textColor: Colors.white,
                    color: createMaterialColor(Color(0xff9575cd)),
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
