import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'MaterialColor.dart';
import 'QuizHomePage.dart';
import 'QuizParser.dart';
import 'User.dart';

var questionBody;
var quizNumber = 0;

///homepage used to display all available quizzes
class HomePage extends StatefulWidget {
  User user;

  ///user information i.e. username, password
  static final String id = "home_page";

  HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState(user: user);
}

class _HomePageState extends State<HomePage> {
  User user;

  _HomePageState({Key key, this.user});

  ///list of quizzes
  final List<String> quizList = <String>[
    'Quiz 1',
    'Quiz 2',
    'Quiz 3',
    'Quiz 4',
    'Quiz 5',
    'Quiz 6',
    'Quiz 7',
    'Quiz 8',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: createMaterialColor(Color(0xffffebee)),
        appBar: AppBar(
          automaticallyImplyLeading: true,

          ///allow back button
          title: Text(
            'Home Page',

            ///title bar text
            style: GoogleFonts.spectral(
                textStyle: TextStyle(
                    color: createMaterialColor(Color(0xffeeeeeee)),
                    letterSpacing: .5,
                    fontWeight: FontWeight.bold,
                    fontSize: 35)),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 100,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Pick a desired quiz to start!',
                    style: GoogleFonts.spectral(
                        textStyle: TextStyle(
                            color: createMaterialColor(Color(0xff212121)),
                            letterSpacing: .5,
                            fontWeight: FontWeight.normal,
                            fontSize: 20)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(///builder to make a list from the number of quizzes
                  itemCount: quizList.length,///quiz length
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      margin: EdgeInsets.all(2.0),
                      child: RaisedButton(
                        color: createMaterialColor(Color(0xffd1c4e9)),
                        onPressed: () {
                          ///if the user presses a quiz button, it will assign the number
                          setState(() {
                            quizNumber = index;
                            ///call class to get user info
                            _getQuiz(context);
                          });
                        },
                        child: Text(
                          '${quizList[index]}',
                          style: GoogleFonts.spectral(
                              textStyle: TextStyle(
                                  color: createMaterialColor(Color(0xff212121)),
                                  letterSpacing: .5,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20)),
                        ),
                        highlightColor: createMaterialColor(Color(0xffc5cae9)),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }

  _getQuiz(BuildContext context) async {
    var parser = new QuizParser(user, quizNumber);///initiate class to obtain quiz information using credentials
    var rawBody = await parser.getQuiz();///get the quiz from server
    questionBody = await parser.parseQuestions(rawBody);///parse the questions into an object
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(///navigate to a new page passing user info and quiz information
            builder: (context) => QuizHomePage(user: user, questionBody: questionBody)));
  }
}
