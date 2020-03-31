import 'package:flutter/material.dart';

import 'AnswerHomePage.dart';
import 'HomePage.dart';
import 'MaterialColor.dart';
import 'QuizHomePage.dart';
import 'UserLogin.dart';

void main() {
  runApp(MyApplication());
}

class MyApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color(0xff9575cd)),
      ),
      home: UserLogin(),
      initialRoute: UserLogin.id,
      routes: {
        UserLogin.id: (context) => UserLogin(),
        HomePage.id: (context) => HomePage(),
        QuizHomePage.id: (context) => QuizHomePage(),
        AnswerHomePage.id: (context) => AnswerHomePage(),
      },
    );
  }
}
