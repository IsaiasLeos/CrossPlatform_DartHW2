import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inclasshomework/QuizController.dart';

class AnswerHomePage extends StatefulWidget {
  var userAnswers;
  var quizAnswers;
  static final String id = "answer_home_page";

  AnswerHomePage({Key key, this.userAnswers, this.quizAnswers});

  @override
  _AnswerHomePageState createState() =>
      _AnswerHomePageState(userAnswers: userAnswers, quizAnswers: quizAnswers);
}

class _AnswerHomePageState extends State<AnswerHomePage> {
  var style = TextStyle(fontSize: 50.0);
  var userAnswers;
  var quizAnswers;
  var controller = new QuizController();

  _AnswerHomePageState({Key key, this.userAnswers, this.quizAnswers});

  @override
  Widget build(BuildContext context) {
    controller.quiz_answers = quizAnswers;
    controller.quiz_user_responses = userAnswers;
    return Scaffold(
        appBar: AppBar(
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
            ],
          ),
        ));
  }
}
