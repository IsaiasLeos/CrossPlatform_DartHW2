import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inclasshomework/QuizHomePage.dart';
import 'package:inclasshomework/QuizParser.dart';
import 'Main.dart';

import 'User.dart';

import 'package:google_fonts/google_fonts.dart';


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
      backgroundColor: createMaterialColor(Color(0xffffebee)),
        appBar: AppBar(
          title: Text( 'Flutter',
            style: GoogleFonts.spectral(
                textStyle: TextStyle(
                    color:createMaterialColor(Color(0xffeeeeeee)), letterSpacing: .5, fontWeight: FontWeight.bold, fontSize: 20 )),),
        ),
        body: Column(

          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 100,
              child: Center(
                child:  RichText(
                  text: TextSpan(
                    text: 'Pick a desired quiz to',
                    style: GoogleFonts.spectral(
                        textStyle: TextStyle(
                            color:createMaterialColor(Color(0xff212121)),
                            letterSpacing: .5, fontWeight: FontWeight.normal, fontSize: 20 )),
                    children: <TextSpan>[
                      TextSpan(text: ' start!', style: GoogleFonts.spectral(
                      textStyle: TextStyle(
                          color:createMaterialColor(Color(0xff212121)),
                          letterSpacing: .5, fontWeight: FontWeight.normal, fontSize: 20 )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: quizNumbers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      margin: EdgeInsets.all(2.0),
                      child: RaisedButton(
                        color: createMaterialColor(Color(0xffd1c4e9)),
                        onPressed: () {
                          setState(() {
                            user.quizNumber = index;
                            _navigateHome(context);
                          });
                        },
                        child: Text('${quizNumbers[index]}',
                          style: GoogleFonts.spectral(
                          textStyle: TextStyle(
                           color:createMaterialColor(Color(0xff212121)),
                            letterSpacing: .5, fontWeight: FontWeight.normal, fontSize: 20 )),),
                          highlightColor: createMaterialColor(Color(0xffc5cae9)),
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
