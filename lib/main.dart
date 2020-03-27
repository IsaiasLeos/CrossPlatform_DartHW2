import 'package:flutter/material.dart';
import 'package:inclasshomework/quizParser.dart';

import 'Questions.dart';

void main() {
  runApp(MyApplication());
}

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

  var emailField = TextField(
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

  var passwordField = TextField(
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
                    onPressed: () {
                      var user = new User(emailEditingContrller.text,
                          passEditingContrller.text, null, 0);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(
                                    user: user,
                                  )));
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

class User {
  String userName;
  String password;
  Questions body;
  int quizNumber;

  User(this.userName, this.password, this.body, this.quizNumber);
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
    var parser = new QuizParser(user.userName, user.password, user.quizNumber);
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
  QuizHomePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    print(user.body);
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
                    return Container(
                      height: 50,
                      margin: EdgeInsets.all(2.0),
                      child: Text('${user.body.questions[index]}'),
                    );
                  }),
            ),
          ],
        ));
  }
}
