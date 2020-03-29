class QuizController {
  var quiz_answers;
  var quiz_user_responses;

  QuizController([this.quiz_answers, this.quiz_user_responses]);

  ///Calculates which questions are wrong and which are correct and
  ///returns the number of question answered correctly.
  int calculateGrade() {
    var total = 0;
    var questionCount = 0;
    print('quiz: $quiz_answers');
    print('user: $quiz_user_responses');
    quiz_user_responses.forEach((answer) {
      if (answer == '4' || answer == '3' || answer == '2' || answer == '1') {
        answer = int.parse(answer);
      }
      questionCount++;
    });
    return total;
  }
}
