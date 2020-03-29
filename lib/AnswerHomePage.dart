import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnswerHomePage extends StatefulWidget {
  List<String> answers;
  static final String id = "login_screen";

  AnswerHomePage({Key key, List<String> answers}) {
    this.answers = answers;
  }

  @override
  _AnswerHomePageState createState() => _AnswerHomePageState(answers: answers);
}

class _AnswerHomePageState extends State<AnswerHomePage> {
  static final String id = "answer_home_page";

  _AnswerHomePageState({Key key, List<String> answers});

  @override
  Widget build(BuildContext context) {
    List<String> quizController = new List(10);
    return Scaffold(
        appBar: AppBar(
          title: Text("Review"),
        ),
        body: Column(
          children: <Widget>[],
        ));
  }
}
