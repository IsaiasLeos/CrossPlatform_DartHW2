import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Questions.dart';

class QuizParser {
  String username;
  String password;
  int quizNumber;

  QuizParser(String username, String password, int quizNumber) {
    this.username = username;
    this.password = password;
    this.quizNumber = quizNumber;
  }

  ///Makes connection with server to obtain a quiz in JSON format.
  Future<dynamic> getQuiz() async {
    var url = 'http://www.cs.utep.edu/cheon/cs4381/homework/quiz/post.php';
    var body =
        '{"user": "$username", "pin": "$password", "quiz": "quiz0$quizNumber" }';
    var response = await http.post(url, body: body);
    print(response.body.toString());
    return response.body;
  }

  ///Parses the questions and assigns them into a list to then compare to
  ///how many questions the user wants and gets done.
  Future<Questions> parseQuestions(var jsonMsg) async {
    var decodedMsg = await jsonMsg;
    var questionRepo;
    if (decodedMsg != null) {
      var quiz = json.decode(decodedMsg);
      questionRepo = Questions();
      questionRepo.quizName = quiz['quiz']['name']; //Quiz Name
      var fixedQuiz = quiz['quiz']['question'] as List; //Question
      fixedQuiz.forEach((element) {
        //Iterate
        questionRepo.figures.add(element['figure']);
        questionRepo.questions.add(element['stem']); //Gets literal question
        questionRepo.answers
            .add(element['answer']); //Gets the answer for the question
        if (element['option'] == null) {
          //assigns 0 because no options are available
          questionRepo.options.add(0);
        } else {
          //assigns options if available
          questionRepo.options.add(element['option']);
        }
      });
    }
    return questionRepo;
  }
}
