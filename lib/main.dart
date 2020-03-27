import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:inclasshomework/quizParser.dart';

import 'Questions.dart';

void main() {
  runApp(MyApplication());
}

final _formKey = GlobalKey<FormState>();
var testGoodUser = new QuizParser();

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

  static TextEditingController emailEditingContrller = TextEditingController();
  static TextEditingController passEditingContrller = TextEditingController();

  var emailField = TextFormField(
    validator: (value) {
      if (value.isEmpty) {
        return 'Empty Username';
      }
    },
    autofocus: false,
    obscureText: false,
    keyboardType: TextInputType.emailAddress,
    controller: emailEditingContrller,
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

  var passwordField = TextFormField(
    validator: (value) {
      if (value.length != 4) {
        return 'Please input your last 4 digits of your ID.';
      }
    },
    autofocus: false,
    obscureText: true,
    keyboardType: TextInputType.text,
    controller: passEditingContrller,
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
                          new User(emailEditingContrller.text, passEditingContrller.text, null, 0);
                      var isGood = await testGoodUser.getGrade(user.name, user.password);
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

class User {
  String name;
  String password;
  Questions body;
  int quizNumber;

  User(this.name, this.password, this.body, this.quizNumber);
}

class HomePage extends StatelessWidget {
  User user;

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
    var parser = new QuizParser(user.name, user.password, user.quizNumber);
    var rawBody = await parser.getQuiz();
    user.body = await parser.parseQuestions(rawBody);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizHomePage(
                  user: user,
                )));
  }
}

class QuizHomePage extends StatelessWidget {
  User user;
  String _radioValue;
  String choice;

  QuizHomePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text("Question"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: user.body.questions.length,
                  itemBuilder: (BuildContext context, int index) {
                    String inputstr = "";
                    var bullet = index + 1;
                    if (user.body.options[index] != 0) {
                      var tempList = (user.body.options[index] as List).cast<String>();
                      return Card(
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  ('$bullet. ${user.body.questions[index]}'),
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
                                  ('$bullet. ${user.body.questions[index]}'),
                                  style: TextStyle(fontSize: 22.0),
                                ),
                                new TextField(
                                  decoration: new InputDecoration(hintText: 'Answer'),
                                  onChanged: (String input) {
                                    inputstr = input;
                                  },
                                ),
                                new Text(inputstr),
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
