import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import 'AnswerHomePage.dart';
import 'MaterialColor.dart';
import 'ShowAlertDialog.dart';
import 'User.dart';

List<String> userAnswers;

///handles all the information regarding the quizzes and its options and available input
class QuizHomePage extends StatefulWidget {
  User user;

  ///user information
  var questionBody;

  ///question body holding all answers,options,figures,

  static final String id = "quiz_home_page";

  QuizHomePage({this.user, this.questionBody});

  @override
  _QuizHomePageState createState() => _QuizHomePageState(user: user, questionBody: questionBody);
}

class _QuizHomePageState extends State<QuizHomePage> {
  var user;

  ///user information
  var questionBody;

  ///question body holding all answers,options,figures,
  int selected;

  ///selected option

  _QuizHomePageState({Key key, this.user, this.questionBody});

  @override
  Widget build(BuildContext context) {
    userAnswers = List(questionBody.questions.length);
    return new WillPopScope(
      ///prevent the user from navigating back
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: createMaterialColor(Color(0xffd6d6d6)),
        appBar: AppBar(
          title: Text(
            'Quiz Page',

            ///page title
            style: GoogleFonts.spectral(
                textStyle: TextStyle(
                    color: createMaterialColor(Color(0xffeeeeeee)),
                    letterSpacing: .5,
                    fontWeight: FontWeight.bold,
                    fontSize: 35)),
          ),
          automaticallyImplyLeading: false,

          ///remove back button
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: questionBody.questions.length,
                  itemBuilder: (BuildContext context, int index) {
                    ///fix numbering for questions
                    var bullet = index + 1;

                    ///check type of question either multiple choice or input type
                    if (questionBody.options[index] != 0) {
                      ///convert dynamic list into string list for radiobuttongroup
                      var tempList = questionBody.options[index].cast<String>();

                      ///convert a dynamic list into a string to display into radio buttons
                      return Card(
                        color: createMaterialColor(Color(0xffffebee)),
                        child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  ///show the bullet with the question i.e. 1. What is ...
                                  ('$bullet. ${questionBody.questions[index]}'),
                                  style: TextStyle(fontSize: 22.0),
                                ),

                                ///Radio button group used to figure out how to display options for the user
                                RadioButtonGroup(
                                  labels: tempList,
                                  onChange: (label, value) {
                                    int fixedValue = value;

                                    ///obtained the value for picked radio button
                                    fixedValue += 1;

                                    ///add one to fix its position with the question answers
                                    ///assign the fixedValue in string to an array that holds all user answers
                                    userAnswers[index] = fixedValue.toString();
                                  },
                                )
                              ],
                            )),
                      );
                    } else {
                      TextEditingController myController = new TextEditingController();
                      return Card(
                        color: createMaterialColor(Color(0xffe8eaf6)),
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

                                  ///hint text
                                  decoration: new InputDecoration(hintText: 'Answer'),

                                  autocorrect: false,
                                  onChanged: (value) {
                                    ///assign what the user inputted into an array holding all user answers
                                    userAnswers[index] = value;
                                  },
                                ),
                              ],
                            )),
                      );
                    }
                  }),
            ),
          ],
        ),
        floatingActionButton: Material(
          ///completely fill to have no gray
          child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
            onPressed: () {
              ///create a temp array of string to reset userAnswers when retaking a quiz
              ///assign the array holding user answers into a templist to pass
              List<String> tempList = userAnswers;

              ///reset user array holding answers
              userAnswers = List(questionBody.questions.length);

              ///check to see if the user finished the quiz and has no empty choices
              bool finishedQuiz = true;
              tempList.forEach((element) {
                if (element == null) {
                  finishedQuiz = false;
                }
              });

              ///navigate to answer home page if the user finished the quiz
              if (finishedQuiz) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnswerHomePage(
                              ///user information
                              user: user,

                              ///user answers
                              userAnswers: tempList,

                              ///question body
                              questionBody: questionBody,
                            )));
              } else {
                ///Alert for when user doesn't finish all the questions
                showAlertDialog(context, "Please answer all questions!");
              }
            },
            textColor: Colors.white,
            color: createMaterialColor(Color(0xff9575cd)),
            child: Text("SUBMIT"),
          ),
        ),
      ),
    );
  }
}
