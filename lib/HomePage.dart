import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inclasshomework/QuizHomePage.dart';
import 'package:inclasshomework/QuizParser.dart';

import 'User.dart';

var questionBody;

class HomePage extends StatefulWidget {
  User user;
  static final String id = "login_screen";

  HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState(user: user);
}

class _HomePageState extends State<HomePage> {
  User user;

  _HomePageState({Key key, this.user});

  final List<String> quizNumbers = <String>[
    'Quiz 1',
    'Quiz 2',
    'Quiz 3',
    'Quiz 4',
    'Quiz 5',
    'Quiz 6',
    'Quiz 7',
    'Quiz 8',
    'Quiz 9',
    'Quiz 10',
    'Quiz 11',
    'Quiz 12',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Choose a Quiz"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: quizNumbers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      margin: EdgeInsets.all(2.0),
                      child: RaisedButton(
                        onPressed: () {
                          user.quizNumber = index;
                          _navigateHome(context);
                        },
                        child: Text('${quizNumbers[index]}'),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }

  _navigateHome(BuildContext context) async {
    var parser = new QuizParser(user, user.quizNumber);
    var rawBody = await parser.getQuiz();
    questionBody = await parser.parseQuestions(rawBody);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizHomePage(user: user, questionBody: questionBody)));
  }
}
