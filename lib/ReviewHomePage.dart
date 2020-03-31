import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import 'HomePage.dart';
import 'MaterialColor.dart';
import 'User.dart';

List<String> userAnswers = List(10);

///page to review the question the user got right and wrong
class ReviewHomePage extends StatefulWidget {
  User user;

  ///user information in order to prevent nulls
  var questionBody;

  ///question body to display questions
  var correctAns;

  ///array of questions the user got right

  static final String id = "quiz_home_page";

  ReviewHomePage({this.user, this.questionBody, this.correctAns});

  @override
  _ReviewHomePage createState() =>
      _ReviewHomePage(user: user, questionBody: questionBody, correctAns: correctAns);
}

class _ReviewHomePage extends State<ReviewHomePage> {
  User user;

  ///user information in order to prevent nulls
  var questionBody;

  ///question body to display questions
  var correctAns;

  ///array of questions the user got right

  _ReviewHomePage({Key key, this.questionBody, this.user, this.correctAns});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: createMaterialColor(Color(0xffd6d6d6)),
      appBar: AppBar(
        title: Text(
          'Review Page',
          style: GoogleFonts.spectral(
              textStyle: TextStyle(
                  color: createMaterialColor(Color(0xffeeeeeee)),
                  letterSpacing: .5,
                  fontWeight: FontWeight.bold,
                  fontSize: 35)),
        ),
        automaticallyImplyLeading: false,

        ///prevent error navigation
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            ///create a list of user correct and wrong answers
            child: ListView.builder(
                itemCount: questionBody.questions.length,
                itemBuilder: (BuildContext context, int index) {
                  ///fix numbering for questions
                  var bullet = index + 1;

                  ///if the user got the answer wrong
                  if (correctAns[index] == -1) {
                    ///multiple choice question
                    if (questionBody.options[index] != 0) {
                      ///convert dynamic list into string for radiobuttongroup
                      var tempList = questionBody.options[index].cast<String>();
                      return Card(
                        color: createMaterialColor(Color(0xffffebee)),
                        child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  ///show the bullet with the question i.e. 1. What is ...
                                  '$bullet. ${questionBody.questions[index]}',
                                  style: TextStyle(fontSize: 22.0),
                                ),

                                ///Radio button group used to figure out how to display options for the user
                                RadioButtonGroup(
                                  ///pre-picked option of what the correct answer is
                                  picked: tempList[questionBody.answers[index]],
                                  labels: tempList,
                                )
                              ],
                            )),
                      );
                    } else {
                      TextEditingController myController =
                          new TextEditingController(text: questionBody.answers[index][0]);
                      return Card(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                ///show the bullet with the question i.e. 1. What is ...
                                ('$bullet. ${questionBody.questions[index]}'),
                                style: TextStyle(fontSize: 22.0),
                              ),

                              ///Text input for user
                              new TextField(
                                ///what holds the answer
                                controller: myController,
                                decoration: new InputDecoration(hintText: 'Answer'),
                                autocorrect: false,
                                enabled: false,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  } else {
                    ///display which questions the user got correct
                    return Card(
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              ///display question number and if the user got it correct
                              ('$bullet. Correct'),
                              style: TextStyle(fontSize: 22.0),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: Material(
        child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          onPressed: () {
            userAnswers = List(10);
            ///navigate to home page
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          user: user,
                        )));
          },
          textColor: Colors.white,
          color: createMaterialColor(Color(0xff9575cd)),
          child: Text("Home"),
        ),
      ),
    );
  }
}
