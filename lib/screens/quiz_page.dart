import 'package:flutter/material.dart';
import 'useful_widgets.dart';
import 'lessons_page.dart';
import 'dart:developer';
import 'dart:math' hide log;
import 'student_info.dart';
import 'quiz_hint.dart';
import 'chat_assistant.dart';  // ← Add this import

class Question {
  String question;
  String hint;

  Question(this.question, this.hint);
}

class MCQ extends Question {
  List<String> answers;
  int correctAnswer;

  MCQ(super.question, this.answers, this.correctAnswer, super.hint);
}

class TF extends Question {
  List<String> answers;
  int correctAnswer;

  TF(super.question, this.answers, this.correctAnswer, super.hint);
}

class TXT extends Question {
  String correctAnswer;

  TXT(super.question, this.correctAnswer, super.hint);
}

class QuestionsPage extends StatefulWidget {
  final List<Question> listOfQuestions;
  final int lessonNum;

  QuestionsPage(this.listOfQuestions, this.lessonNum);

  @override
  _QuestionsPage createState() => _QuestionsPage();
}

class _QuestionsPage extends State<QuestionsPage> {
  int currentQIndex = 0, firstTryCorrectAnswers = 0;

  void nextQuestion() {
    if (currentQIndex < widget.listOfQuestions.length - 1) {
      setState(() { currentQIndex++; });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(
            correctAnswers: firstTryCorrectAnswers,
            totalQuestions: widget.listOfQuestions.length,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    widget.listOfQuestions.shuffle(Random());
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = widget.listOfQuestions[currentQIndex];

    if (currentQuestion is MCQ) {
      return MCQPage(
        question: currentQuestion,
        onNext: nextQuestion,
        onFirstTryCorrect: () {
          setState(() { firstTryCorrectAnswers++; });
        },
        lessonNum: widget.lessonNum,
      );
    } else if (currentQuestion is TF) {
      return TFPage(
        question: currentQuestion,
        onNext: nextQuestion,
        onFirstTryCorrect: () {
          setState(() { firstTryCorrectAnswers++; });
        },
        lessonNum: widget.lessonNum,
      );
    } else if (currentQuestion is TXT) {
      return TXTPage(
        question: currentQuestion,
        onNext: nextQuestion,
        onFirstTryCorrect: () {
          setState(() { firstTryCorrectAnswers++; });
        },
        lessonNum: widget.lessonNum,
      );
    } else {
      return Scaffold(
        body: Center(child: Text('Error')),
      );
    }
  }
}

class TFPage extends StatefulWidget {
  final TF question;
  final VoidCallback onNext;
  final VoidCallback onFirstTryCorrect;
  final int lessonNum;

  const TFPage({
    required this.question,
    required this.onNext,
    required this.onFirstTryCorrect,
    required this.lessonNum,
    Key? key,
  }) : super(key: key);

  @override
  _TFPage createState() => _TFPage();
}

class _TFPage extends State<TFPage>{
  bool isFirstTry = true;
  late List<String> shuffledAnswers;
  late int shuffledCorrectAnswerIndex;

  @override
  void initState() {
    super.initState();
    shuffleAnswers();
  }

  @override
  void didUpdateWidget(covariant TFPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      shuffleAnswers();
      isFirstTry = true;
    }
  }

  void shuffleAnswers() {
    shuffledAnswers = widget.question.answers;
    shuffledCorrectAnswerIndex = widget.question.correctAnswer;

    var random = Random();
    for (int i = shuffledAnswers.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      if (i == shuffledCorrectAnswerIndex) {
        shuffledCorrectAnswerIndex = j;
      } else if (j == shuffledCorrectAnswerIndex) {
        shuffledCorrectAnswerIndex = i;
      }
      var temp = shuffledAnswers[i];
      shuffledAnswers[i] = shuffledAnswers[j];
      shuffledAnswers[j] = temp;
    }
  }

  void leaveQuiz() {
    showCustomDialog(
      context,
      "Are You Sure You Want to Quit?",
      [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => FractionsQuizzes()),
            );
          },
          child: Text("Yes"),
        ),
        SizedBox(width: 20),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("No"),
        ),
      ],
    );
  }

  void correct() {
    if (isFirstTry) widget.onFirstTryCorrect();
    showCustomDialogEmoji(
      context,
      "Correct!",
      "✅✅✅",
      [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onNext();
          },
          child: Text("Next"),
        ),
      ],
    );
  }

  void incorrect() {
    isFirstTry = false;
    showCustomDialogEmoji(
      context,
      "Incorrect!",
      "❌❌❌",
      [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Retry 🥲"),
        ),
      ],
    );
  }

  void checkAnswer(int selectedIndex) {
    if (selectedIndex == shuffledCorrectAnswerIndex) {
      correct();
    } else {
      incorrect();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: Color(0xFFB7E0FF)),
                    child: Stack(
                      children: [
                        backTextMenuBar(
                          context,
                          leaveQuiz,
                          "Lesson ${widget.lessonNum} Exercises",
                        ),
                        buttonText(
                          shuffledAnswers[0],
                              () => checkAnswer(0),
                          x: 0.85, y: -0.025, width: 400, height: 156, fontSize: 48,
                        ),
                        buttonText(
                          shuffledAnswers[1],
                              () => checkAnswer(1),
                          x: 0.85, y: 0.575, width: 400, height: 156, fontSize: 48,
                        ),
                        FlipCardQuizCard(question: widget.question),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ChatAssistant(), // ← overlayed chat assistant
      ],
    );
  }
}

class MCQPage extends StatefulWidget {
  final MCQ question;
  final VoidCallback onNext;
  final VoidCallback onFirstTryCorrect;
  final int lessonNum;

  const MCQPage({
    required this.question,
    required this.onNext,
    required this.onFirstTryCorrect,
    required this.lessonNum,
    Key? key,
  }) : super(key: key);

  @override
  _MCQPage createState() => _MCQPage();
}

class _MCQPage extends State<MCQPage>{
  bool isFirstTry = true;
  late List<String> shuffledAnswers;
  late int shuffledCorrectAnswerIndex;

  @override
  void initState() {
    super.initState();
    shuffleAnswers();
  }

  @override
  void didUpdateWidget(covariant MCQPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      shuffleAnswers();
      isFirstTry = true;
    }
  }

  void shuffleAnswers() {
    shuffledAnswers = widget.question.answers;
    shuffledCorrectAnswerIndex = widget.question.correctAnswer;

    var random = Random();
    for (int i = shuffledAnswers.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      if (i == shuffledCorrectAnswerIndex) {
        shuffledCorrectAnswerIndex = j;
      } else if (j == shuffledCorrectAnswerIndex) {
        shuffledCorrectAnswerIndex = i;
      }
      var temp = shuffledAnswers[i];
      shuffledAnswers[i] = shuffledAnswers[j];
      shuffledAnswers[j] = temp;
    }
  }

  void leaveQuiz() {
    showCustomDialog(
      context,
      "Are You Sure You Want to Quit?",
      [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => FractionsQuizzes()),
            );
          },
          child: Text("Yes"),
        ),
        SizedBox(width: 20),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("No"),
        ),
      ],
    );
  }

  void correct() {
    if (isFirstTry) widget.onFirstTryCorrect();
    showCustomDialogEmoji(
      context,
      "Correct!",
      "✅✅✅",
      [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onNext();
          },
          child: Text("Next"),
        ),
      ],
    );
  }

  void incorrect() {
    isFirstTry = false;
    showCustomDialogEmoji(
      context,
      "Incorrect!",
      "❌❌❌",
      [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Retry 🥲"),
        ),
      ],
    );
  }

  void checkAnswer(int selectedIndex) {
    if (selectedIndex == shuffledCorrectAnswerIndex) {
      correct();
    } else {
      incorrect();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: Color(0xFFB7E0FF)),
                    child: Stack(
                      children: [
                        backTextMenuBar(
                          context,
                          leaveQuiz,
                          "Lesson ${widget.lessonNum} Exercises",
                        ),
                        buttonText(
                          shuffledAnswers[0],
                              () => checkAnswer(0),
                          x: 0.85, y: -0.35, width: 400, height: 156, fontSize: 48,
                        ),
                        buttonText(
                          shuffledAnswers[1],
                              () => checkAnswer(1),
                          x: 0.85, y: 0.25, width: 400, height: 156, fontSize: 48,
                        ),
                        buttonText(
                          shuffledAnswers[2],
                              () => checkAnswer(2),
                          x: 0.85, y: 0.85, width: 400, height: 156, fontSize: 48,
                        ),
                        FlipCardQuizCard(question: widget.question),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ChatAssistant(), // ← overlayed chat assistant
      ],
    );
  }
}

class TXTPage extends StatefulWidget {
  final TXT question;
  final VoidCallback onNext;
  final VoidCallback onFirstTryCorrect;
  final int lessonNum;

  const TXTPage({
    required this.question,
    required this.onNext,
    required this.onFirstTryCorrect,
    required this.lessonNum,
    Key? key,
  }) : super(key: key);

  @override
  _TXTPage createState() => _TXTPage();
}

class _TXTPage extends State<TXTPage>{
  bool isFirstTry = true;
  late TextEditingController input = TextEditingController();

  void leaveQuiz() {
    showCustomDialog(
      context,
      "Are You Sure You Want to Quit?",
      [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => FractionsQuizzes()),
            );
          },
          child: Text("Yes"),
        ),
        SizedBox(width: 20),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("No"),
        ),
      ],
    );
  }

  void checkAnswer() {
    String normalizedCorrect = widget.question.correctAnswer
        .toLowerCase()
        .trim()
        .replaceAll('-', '')
        .replaceAll(' ', '');
    String normalizedInput = input.text
        .toLowerCase()
        .trim()
        .replaceAll('-', '')
        .replaceAll(' ', '');

    if (normalizedInput == normalizedCorrect) {
      if (isFirstTry) widget.onFirstTryCorrect();
      showCustomDialogEmoji(
        context,
        "Correct!",
        "✅✅✅",
        [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onNext();
            },
            child: Text("Next"),
          ),
        ],
      );
    } else {
      isFirstTry = false;
      showCustomDialogEmoji(
        context,
        "Incorrect!",
        "❌❌❌",
        [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Retry 🥲"),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: Color(0xFFB7E0FF)),
                    child: Stack(
                      children: [
                        backTextMenuBar(
                          context,
                          leaveQuiz,
                          "Lesson ${widget.lessonNum} Exercises",
                        ),
                        boxText(widget.question.question,
                            x: 0.0, y: -0.05, width: 1133, height: 412),
                        boxInput(input, "Type Answer",
                            x: -0.7, y: 0.85, width: 784, height: 100),
                        buttonText("Submit", checkAnswer,
                            x: 0.75, y: 0.85, width: 250, height: 100, fontSize: 48),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ChatAssistant(), // ← overlayed chat assistant
      ],
    );
  }
}

class ResultsPage extends StatefulWidget {
  final int correctAnswers;
  final int totalQuestions;

  const ResultsPage({
    required this.correctAnswers,
    required this.totalQuestions,
    Key? key,
  }) : super(key: key);

  @override
  _ResultsPage createState() => _ResultsPage();
}

class _ResultsPage extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    // Results text based on correct answers
    String text;
    if (widget.correctAnswers > 0) {
      text = "You got ${widget.correctAnswers} of ${widget.totalQuestions} correct on your first try!";
    } else {
      text = "You got none correct on your first try.";
    }

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: Color(0xFFB7E0FF)),
                    child: Stack(
                      children: [
                        boxText(
                          text,
                          x: 0.0, y: -0.2, width: 733, height: 450, fontSize: 80,
                        ),
                        buttonText(
                          "Back to Quizzes", () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => FractionsQuizzes()),
                          );
                        },
                          x: 0.0, y: 0.75, width: 350, height: 90, fontSize: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ChatAssistant(), // ← overlayed chat assistant
      ],
    );
  }
}

