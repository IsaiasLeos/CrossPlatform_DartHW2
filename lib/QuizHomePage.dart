import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inclasshomework/AnswerHomePage.dart';

import 'User.dart';

List<String> quizController = new List(10);

class QuizHomePage extends StatefulWidget {
  User user;
  var questionBody;

  static final String id = "quiz_home_page";

  QuizHomePage({this.user, this.questionBody});

  @override
  _QuizHomePageState createState() => _QuizHomePageState(user: user, questionBody: questionBody);
}

class _QuizHomePageState extends State<QuizHomePage> {
  User user;
  var questionBody;
  int selectedBox;
  String answer;

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
                      return Card(
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  ('$bullet. ${questionBody.questions[index]}'),
                                  style: TextStyle(fontSize: 22.0),
                                ),
                                createCheckBoxGroup(questionBody.options[index]),
                              ],
                            )),
                      );
                    } else {
                      TextEditingController myController = new TextEditingController();
                      return Card(
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  ('$bullet. ${questionBody.questions[index]}'),
                                  style: TextStyle(fontSize: 22.0),
                                ),
                                new TextField(
                                  controller: myController,
                                  decoration: new InputDecoration(hintText: 'Answer'),
                                  onChanged: (value) {
                                    quizController[index] = value;
                                  },
                                ),
                              ],
                            )),
                      );
                    }
                  }),
            ),
            Material(
              child: MaterialButton(
                onPressed: () {
                  bool continueToReview = true;
                  quizController.forEach((element) {
                    print(element);
                  });
                  if (continueToReview)
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnswerHomePage(
                                  answers: quizController,
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

  Widget createCheckBoxGroup(List<dynamic> options) {
    return Column(
      children: options.asMap().entries.map((entry) {
        return CheckboxListTile(
          title: Text(entry.value.toString()),
          value: selectedBox == entry.key,
          onChanged: (newValue) => setState(() => selectedBox = entry.key),
          controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
        );
      }).toList(),
    );
  }
}
