import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:inclasshomework/AnswerHomePage.dart';

import 'User.dart';

List<String> userAnswers = List(10);

class QuizHomePage extends StatefulWidget {
  User user;
  var questionBody;

  static final String id = "quiz_home_page";

  QuizHomePage({this.user, this.questionBody});

  @override
  _QuizHomePageState createState() => _QuizHomePageState(user: user, questionBody: questionBody);
}

class _QuizHomePageState extends State<QuizHomePage> {
  var user;
  var questionBody;
  int selected;

  _QuizHomePageState({Key key, this.user, this.questionBody});

  @override
  Widget build(BuildContext context) {
    int correctNumberTitle = user.quizNumber + 1;
    return Scaffold(
        appBar: AppBar(
          title: Text("Quiz $correctNumberTitle"),
          automaticallyImplyLeading: false,
          actions: <Widget>[],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: questionBody.questions.length,
                  itemBuilder: (BuildContext context, int index) {
                    var bullet = index + 1;
                    if (questionBody.options[index] != 0) {
                      var tempList = questionBody.options[index].cast<String>();
                      return Card(
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  ('$bullet. ${questionBody.questions[index]}'),
                                  style: TextStyle(fontSize: 22.0),
                                ),
                                RadioButtonGroup(
                                  labels: tempList,
                                  onChange: (label, value) {
                                    value += 1;
                                    userAnswers[index] = value.toString();
                                  },
                                )
                              ],
                            )),
                      );
                    } else {
                      return Card(
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: createOpenQuestion(bullet, index)),
                      );
                    }
                  }),
            ),
            Material(
              child: MaterialButton(
                onPressed: () {
                  List<String> tempList = userAnswers;
                  userAnswers = List(10);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnswerHomePage(
                                userAnswers: tempList,
                                quiz: questionBody,
                              )));
                },
                textColor: Colors.white,
                color: Colors.blue,
                height: 50,
                child: Text("SUBMIT"),
              ),
            ),
          ],
        ));
  }

  Widget createOpenQuestion(int bullet, int index) {
    TextEditingController myController = new TextEditingController();
    return Column(
      children: <Widget>[
        Text(
          ('$bullet. ${questionBody.questions[index]}'),
          style: TextStyle(fontSize: 22.0),
        ),
        new TextField(
          controller: myController,
          decoration: new InputDecoration(hintText: 'Answer'),
          autocorrect: false,
          onChanged: (value) {
            userAnswers[index] = value;
          },
        ),
      ],
    );
  }
}
