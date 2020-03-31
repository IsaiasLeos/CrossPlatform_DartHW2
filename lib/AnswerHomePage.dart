import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inclasshomework/QuizController.dart';
import 'package:inclasshomework/ReviewHomePage.dart';

import 'HomePage.dart';
import 'MaterialColor.dart';
import 'User.dart';

///Homepage that will show the user their final grade for the quiz and optional review.
class AnswerHomePage extends StatefulWidget {
  var userAnswers;
  var questionBody;
  User user;
  static final String id = "answer_home_page";

  AnswerHomePage({Key key, this.userAnswers, this.questionBody, this.user});

  @override
  _AnswerHomePageState createState() =>
      _AnswerHomePageState(userAnswers: userAnswers, questionBody: questionBody, user: user);
}

class _AnswerHomePageState extends State<AnswerHomePage> {
  var style = TextStyle(fontSize: 50.0);

  ///Font size
  var userAnswers;

  ///User answers
  var questionBody;

  ///Quiz
  final User user;

  ///User information
  var controller = new QuizController();

  ///Manage quiz grades
  _AnswerHomePageState({Key key, this.userAnswers, this.questionBody, this.user});

  @override
  Widget build(BuildContext context) {
    controller.quizQuestions = questionBody.options;
    controller.quizAnswers = questionBody.answers;
    controller.quizUserResponses = userAnswers;
    var grade = 0;
    grade = controller.calculateGrade();

    ///Calculate user grade
    return new WillPopScope(
      ///prevent user from navigating back
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,

            ///remove back button
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
                  style: style.copyWith(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 65.0),
                ),
                SizedBox(height: 25.0),
                Text(
                  '$grade/${questionBody.questions.length} (${(grade / questionBody.questions.length) * 100}%)',///show grade
                  textAlign: TextAlign.center,
                  style: style.copyWith(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 65.0),
                ),
                SizedBox(height: 100.0),
                ///logic for if user got a 100, don't show review otherwise show it
                100.0 == ((grade / questionBody.questions.length) * 100)
                    ? SizedBox()///empty box
                    : MaterialButton(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => ReviewHomePage(
                                      questionBody: questionBody,
                                      user: user,
                                      correctAns: controller.correctAns)));
                        },
                        textColor: Colors.white,
                        color: createMaterialColor(Color(0xff9575cd)),
                        child: Text("REVIEW"),
                      ),///button to go review homepage
                SizedBox(height: 25.0),
                MaterialButton(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomePage(
                                  user: user,
                                )));
                  },///button to go to homepage
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
