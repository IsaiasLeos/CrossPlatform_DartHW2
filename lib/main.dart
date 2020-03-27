import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:inclasshomework/quizParser.dart';

import 'User.dart';

void main() {
  runApp(MyApplication());
}

var questionBody;

class MyApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserLogin(title: 'Login'),
    );
  }
}

class UserLogin extends StatelessWidget {
  final String title;

  UserLogin({Key key, this.title}) : super(key: key);

  static final TextEditingController emailEditingController = TextEditingController();
  static final TextEditingController passEditingController = TextEditingController();

  final emailField = TextField(
    autofocus: false,
    obscureText: false,
    keyboardType: TextInputType.emailAddress,
    controller: emailEditingController,
    decoration: InputDecoration(
        labelText: "Username",
        hintText: "Username",
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, style: BorderStyle.solid))),
  );

  final passwordField = TextField(
    autofocus: false,
    obscureText: true,
    keyboardType: TextInputType.text,
    controller: passEditingController,
    decoration: InputDecoration(
        labelText: "Password",
        hintText: "Password",
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, style: BorderStyle.solid))),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Column(
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: 125,
                  ),
                ),
                emailField,
                SizedBox(
                  height: 30,
                ),
                passwordField,
                SizedBox(
                  height: 50,
                ),
                Material(
                  child: MaterialButton(
                    onPressed: () async {
                      var user =
                          new User(emailEditingController.text, passEditingController.text, 1);
                      var tempCheck = new QuizParser(user);
                      var isGood = await tempCheck.getQuiz();
                      isGood = json.decode(isGood);
                      if (isGood['response']) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      user: user,
                                    )));
                      } else {
                        showAlertDialog(context, isGood['reason']);
                      }
                    },
                    textColor: Colors.white,
                    color: Colors.blue,
                    height: 50,
                    child: Text("LOGIN"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, String reason) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Incorrect User Information"),
    content: Text("Reason: $reason"),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class HomePage extends StatelessWidget {
  final User user;

  HomePage({Key key, this.user}) : super(key: key);
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
          title: Text("Quiz"),
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
            builder: (context) => QuizHomePage(
                  user: user,
                )));
  }
}

class QuizHomePage extends StatelessWidget {
  final User user;

  QuizHomePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Question"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: questionBody.questions.length,
                  itemBuilder: (BuildContext context, int index) {
                    String input = "";
                    var bullet = index + 1;
                    if (questionBody.options[index] != 0) {
                      var tempList = (questionBody.options[index] as List).cast<String>();
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
                                )
                              ],
                            )),
                      );
                    } else {
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
                                  decoration: new InputDecoration(hintText: 'Answer'),
                                  onChanged: (String input) {
                                    input = input;
                                  },
                                ),
                                new Text(input),
                              ],
                            )),
                      );
                    }
                  }),
            ),
          ],
        ));
  }
}
