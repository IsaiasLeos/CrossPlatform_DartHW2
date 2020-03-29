class QuizController {
  var quiz_answers = <dynamic>[];
  var quiz_questions = <dynamic>[];
  var quiz_user_responses = <dynamic>[];

  QuizController([this.quiz_answers, this.quiz_user_responses, this.quiz_questions]);

  ///Calculates which questions are wrong and which are correct and
  ///returns the number of question answered correctly.
  int calculateGrade() {
    var total = 0;
    var questionCount = 0;
    print('quiz_answers: $quiz_answers');
    print('quiz_questions: $quiz_questions');
    print('user: $quiz_user_responses');
    quiz_answers.forEach((answer) {
      if (answer is List) {
        if (answer[0]
            .toString()
            .toLowerCase()
            .contains(quiz_user_responses[questionCount].toString().toLowerCase())) {
          total++;
        }
      } else {
        if (answer == int.parse(quiz_user_responses[questionCount])) {
          total++;
        }
      }
      questionCount++;
    });
    return total;
  }
}
