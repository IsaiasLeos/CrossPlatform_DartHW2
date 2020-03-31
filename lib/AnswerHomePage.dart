import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inclasshomework/QuizController.dart';

import 'HomePage.dart';
import 'Main.dart';
import 'User.dart';

class AnswerHomePage extends StatefulWidget {
  var userAnswers;
  var quiz;
  User user;
  static final String id = "answer_home_page";

  AnswerHomePage({Key key, this.userAnswers, this.quiz, this.user});

  @override
  _AnswerHomePageState createState() =>
      _AnswerHomePageState(userAnswers: userAnswers, quiz: quiz, user: user);
}

class _AnswerHomePageState extends State<AnswerHomePage> {
  var style = TextStyle(fontSize: 50.0);
  var userAnswers;
  var quiz;
  final User user;
  var controller = new QuizController();

  _AnswerHomePageState({Key key, this.userAnswers, this.quiz, this.user});

  @override
  Widget build(BuildContext context) {
    controller.quiz_questions = quiz.options;
    controller.quiz_answers = quiz.answers;
    controller.quiz_user_responses = userAnswers;
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Grade Page',
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Grade',
                  textAlign: TextAlign.center,
                  style: style,
                ),
                SizedBox(height: 25.0),
                Text(
                  '${controller.calculateGrade()}/10.0',
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 65.0),
                ),
                SizedBox(height: 100.0),
                MaterialButton(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => AnswerHomePage()));
                  },
                  textColor: Colors.white,
                  color: createMaterialColor(Color(0xff9575cd)),
                  child: Text("REVIEW"),
                ),
                SizedBox(height: 25.0),
                MaterialButton(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomePage(
                                  user: user,
                                )));
                  },
                  textColor: Colors.white,
                  color: createMaterialColor(Color(0xff9575cd)),
                  child: Text("EXIT"),
                ),
              ],
            ),
          )),
    );
  }
}

class ReviewHomePage {}
