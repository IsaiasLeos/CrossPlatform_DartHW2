import 'package:flutter/material.dart';
import 'package:inclasshomework/AnswerHomePage.dart';
import 'package:inclasshomework/HomePage.dart';
import 'package:inclasshomework/QuizHomePage.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: UserLogin(title: 'Login'),
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
