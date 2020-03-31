class QuizController {
  ///correct answers
  var quizAnswers = <dynamic>[];

  ///questions
  var quizQuestions = <dynamic>[];

  ///user responses
  var quizUserResponses = <dynamic>[];

  ///questions user got right
  var correctAns;

  QuizController([this.quizAnswers, this.quizUserResponses, this.quizQuestions]);

  ///Calculates which questions are wrong and which are correct and
  ///returns the number of question answered correctly.
  int calculateGrade() {
    ///populate with how many questions the user might get right
    correctAns = List(quizQuestions.length);

    ///total questions correct
    var total = 0;

    ///number of questions
    var questionCount = 0;

    quizAnswers.forEach((answer) {
      if (answer is List) {
        ///check for a list
        ///convert to string
        ///lower case to remove capitalization errors
        ///check for open questions
        if (answer[0]
            .toString()
            .toLowerCase()
            .contains(quizUserResponses[questionCount].toString().toLowerCase())) {
          correctAns[questionCount] = 1;///populate if the user got it right
          total++;
        } else {
          correctAns[questionCount] = -1;///user did not get it right
        }
      } else {
        ///check for multiple choice questions
        if (answer == int.parse(quizUserResponses[questionCount])) {
          correctAns[questionCount] = 1;///populate if the user got it right
          total++;
        } else {
          correctAns[questionCount] = -1;///user did not get it right
        }
      }
      questionCount++;
    });
    return total;
  }
}
