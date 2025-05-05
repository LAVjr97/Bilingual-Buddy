// File: dec_quiz_page.dart

import 'package:flutter/material.dart';
import 'useful_widgets.dart';
import 'dec_lessons_page.dart';       // for DecimalsQuizzes
import 'dart:developer';
import 'dart:math' hide log;
import 'student_info.dart';
import 'dec_quiz_hint.dart';
import 'package:confetti/confetti.dart';
import 'globals.dart';

//
// ——————— Question Models ———————
//
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

class MATCH_TILES extends Question {
  List<String> buttonText;
  MATCH_TILES(super.question, this.buttonText, super.hint);
}

//
// ——————— Decimals Questions Page ———————
//
class DecimalsQuestionsPage extends StatefulWidget {
  final List<Question> listOfQuestions;
  final int lessonNum;

  DecimalsQuestionsPage(this.listOfQuestions, this.lessonNum);

  @override
  _DecimalsQuestionsPage createState() => _DecimalsQuestionsPage();
}

class _DecimalsQuestionsPage extends State<DecimalsQuestionsPage> {
  int currentQIndex = 0;
  int firstTryCorrectAnswers = 0;

  @override
  void initState() {
    super.initState();
    widget.listOfQuestions.shuffle(Random());
  }

  void nextQuestion() {
    if (currentQIndex < widget.listOfQuestions.length - 1) {
      setState(() => currentQIndex++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DecimalsResultsPage(
            correctAnswers: firstTryCorrectAnswers,
            totalQuestions: widget.listOfQuestions.length,
            quizNumber: widget.lessonNum,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = widget.listOfQuestions[currentQIndex];

    if (currentQuestion is MCQ) {
      return DecimalsMCQPage(
        question: currentQuestion,
        onNext: nextQuestion,
        onFirstTryCorrect: () => setState(() => firstTryCorrectAnswers++),
        lessonNum: widget.lessonNum,
      );
    } else if (currentQuestion is TF) {
      return DecimalsTFPage(
        question: currentQuestion,
        onNext: nextQuestion,
        onFirstTryCorrect: () => setState(() => firstTryCorrectAnswers++),
        lessonNum: widget.lessonNum,
      );
    } else if (currentQuestion is TXT) {
      return DecimalsTXTPage(
        question: currentQuestion,
        onNext: nextQuestion,
        onFirstTryCorrect: () => setState(() => firstTryCorrectAnswers++),
        lessonNum: widget.lessonNum,
      );
    } else if (currentQuestion is MATCH_TILES) {
      return DecimalsMATCH_TILESPage(
        question: currentQuestion,
        onNext: nextQuestion,
        onFirstTryCorrect: () => setState(() => firstTryCorrectAnswers++),
        lessonNum: widget.lessonNum,
      );
    } else {
      return Scaffold(
        body: Center(child: Text('Error')),
      );
    }
  }
}

//
// ——————— True/False Page ———————
//
class DecimalsTFPage extends StatefulWidget {
  final TF question;
  final VoidCallback onNext;
  final VoidCallback onFirstTryCorrect;
  final int lessonNum;

  const DecimalsTFPage({
    required this.question,
    required this.onNext,
    required this.onFirstTryCorrect,
    required this.lessonNum,
    Key? key,
  }) : super(key: key);

  @override
  _DecimalsTFPage createState() => _DecimalsTFPage();
}

class _DecimalsTFPage extends State<DecimalsTFPage> {
  bool isFirstTry = true;
  late List<String> shuffledAnswers;
  late int shuffledCorrectAnswerIndex;

  @override
  void initState() {
    super.initState();
    _shuffleAnswers();
  }

  @override
  void didUpdateWidget(covariant DecimalsTFPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      _shuffleAnswers();
      isFirstTry = true;
    }
  }

  void _shuffleAnswers() {
    shuffledAnswers = List.from(widget.question.answers);
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
              MaterialPageRoute(builder: (_) => DecimalsQuizzes()),
            );
          },
          child: Text("Yes",
              style: TextStyle(
                  color: Color(0xFF0C2D57),
                  fontSize: 36,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w800)),
        ),
        SizedBox(width: 20),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("No",
              style: TextStyle(
                  color: Color(0xFF0C2D57),
                  fontSize: 36,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w800)),
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
          child: Text("Next",
              style: TextStyle(
                  color: Color(0xFF0C2D57),
                  fontSize: 36,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w800)),
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
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Retry 🥲",
              style: TextStyle(
                  color: Color(0xFF0C2D57),
                  fontSize: 36,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w800)),
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: backgroundColor),
                child: Stack(
                  children: [
                    backTextMenuBar(context, leaveQuiz,
                        "Lesson ${widget.lessonNum} Exercises"),
                    buttonText(shuffledAnswers[0], () => checkAnswer(0),
                        x: 0.85, y: -0.025, width: 400, height: 156, fontSize: 48),
                    buttonText(shuffledAnswers[1], () => checkAnswer(1),
                        x: 0.85, y: 0.575, width: 400, height: 156, fontSize: 48),
                    DecimalsFlipCardQuizCard(question: widget.question),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// ——————— Multiple Choice Page ———————
//
class DecimalsMCQPage extends StatefulWidget {
  final MCQ question;
  final VoidCallback onNext;
  final VoidCallback onFirstTryCorrect;
  final int lessonNum;

  const DecimalsMCQPage({
    required this.question,
    required this.onNext,
    required this.onFirstTryCorrect,
    required this.lessonNum,
    Key? key,
  }) : super(key: key);

  @override
  _DecimalsMCQPage createState() => _DecimalsMCQPage();
}

class _DecimalsMCQPage extends State<DecimalsMCQPage> {
  bool isFirstTry = true;
  late List<String> shuffledAnswers;
  late int shuffledCorrectAnswerIndex;

  @override
  void initState() {
    super.initState();
    _shuffleAnswers();
  }

  @override
  void didUpdateWidget(covariant DecimalsMCQPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      _shuffleAnswers();
      isFirstTry = true;
    }
  }

  void _shuffleAnswers() {
    shuffledAnswers = List.from(widget.question.answers);
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
              MaterialPageRoute(builder: (_) => DecimalsQuizzes()),
            );
          },
          child: Text("Yes",
              style: TextStyle(
                  color: Color(0xFF0C2D57),
                  fontSize: 36,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w800)),
        ),
        SizedBox(width: 20),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("No",
              style: TextStyle(
                  color: Color(0xFF0C2D57),
                  fontSize: 36,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w800)),
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
          child: Text("Next",
              style: TextStyle(
                  color: Color(0xFF0C2D57),
                  fontSize: 36,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w800)),
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
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Retry 🥲",
              style: TextStyle(
                  color: Color(0xFF0C2D57),
                  fontSize: 36,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }

  void checkAnswer(int selectedIndex) {
    if (selectedIndex == shuffledCorrectAnswerIndex) { correct(); } 
    else { incorrect(); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: backgroundColor),
                child: Stack(
                  children: [
                    backTextMenuBar(
                        context, leaveQuiz, "Lesson ${widget.lessonNum} Exercises"),
                    buttonText(shuffledAnswers[0], () => checkAnswer(0),
                        x: 0.85, y: -0.35, width: 400, height: 156, fontSize: 48),
                    buttonText(shuffledAnswers[1], () => checkAnswer(1),
                        x: 0.85, y: 0.25, width: 400, height: 156, fontSize: 48),
                    buttonText(shuffledAnswers[2], () => checkAnswer(2),
                        x: 0.85, y: 0.85, width: 400, height: 156, fontSize: 48),
                    DecimalsFlipCardQuizCard(question: widget.question),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// ——————— Text‑Input Page ———————
//
class DecimalsTXTPage extends StatefulWidget {
  final TXT question;
  final VoidCallback onNext;
  final VoidCallback onFirstTryCorrect;
  final int lessonNum;

  const DecimalsTXTPage({
    required this.question,
    required this.onNext,
    required this.onFirstTryCorrect,
    required this.lessonNum,
    Key? key,
  }) : super(key: key);

  @override
  _DecimalsTXTPage createState() => _DecimalsTXTPage();
}

class _DecimalsTXTPage extends State<DecimalsTXTPage> {
  bool isFirstTry = true;
  final TextEditingController input = TextEditingController();

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
              MaterialPageRoute(builder: (_) => DecimalsQuizzes()),
            );
          },
          child: Text("Yes",
              style: TextStyle(
                  color: Color(0xFF0C2D57),
                  fontSize: 36,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w800)),
        ),
        SizedBox(width: 20),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("No",
              style: TextStyle(
                  color: Color(0xFF0C2D57),
                  fontSize: 36,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w800)),
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
          child: Text("Next",
              style: TextStyle(
                  color: Color(0xFF0C2D57),
                  fontSize: 36,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w800)),
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
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Retry 🥲",
              style: TextStyle(
                  color: Color(0xFF0C2D57),
                  fontSize: 36,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }

  void checkAnswer() {
    var expected = widget.question.correctAnswer.toLowerCase().replaceAll(RegExp(r'[\-\s]'), '');
    var actual = input.text.toLowerCase().replaceAll(RegExp(r'[\-\s]'), '');
    if (expected == actual) correct(); else incorrect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: backgroundColor),
                child: Stack(
                  children: [
                    backTextMenuBar(
                        context, leaveQuiz, "Lesson ${widget.lessonNum} Exercises"),
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
    );
  }
}

//
// ——————— Match‑Tiles Page ———————
//
class matchButton {
  final int pairID;
  final String text;
  bool matched;
  matchButton({required this.pairID, required this.text, this.matched = false});
}

class DecimalsMATCH_TILESPage extends StatefulWidget {
  final MATCH_TILES question;
  final VoidCallback onNext;
  final VoidCallback onFirstTryCorrect;
  final int lessonNum;

  DecimalsMATCH_TILESPage({
    required this.question,
    required this.onNext,
    required this.onFirstTryCorrect,
    required this.lessonNum,
    Key? key,
  }) : super(key: key);

  @override
  _DecimalsMATCH_TILESPage createState() => _DecimalsMATCH_TILESPage();
}

class _DecimalsMATCH_TILESPage extends State<DecimalsMATCH_TILESPage> {
  late List<matchButton> buttons;
  int? firstSelectedIndex;
  Set<int> incorrectIndexes = {};
  bool isFirstTry = true;

  @override
  void initState() {
    super.initState();
    buttons = generateShuffledButtons(widget.question.buttonText);
  }

  List<matchButton> generateShuffledButtons(List<String> buttonTexts) {
    List<matchButton> generatedButtons = [];
    for (int i = 0; i < buttonTexts.length; i++) {
      generatedButtons.add(matchButton(pairID: i ~/ 2, text: buttonTexts[i]));
    }
    generatedButtons.shuffle();
    return generatedButtons;
  }

  void handleButtonTap(int index) {
    if (buttons[index].matched || incorrectIndexes.contains(index)) return;

    setState(() {
      if (incorrectIndexes.isNotEmpty) {
        incorrectIndexes.clear();
      }

      if (firstSelectedIndex == null) {
        firstSelectedIndex = index;
      } else {
        final first = buttons[firstSelectedIndex!];
        final second = buttons[index];

        if (first.pairID == second.pairID && firstSelectedIndex != index) {
          buttons[firstSelectedIndex!].matched = true;
          buttons[index].matched = true;
        } else {
          isFirstTry = false;
          incorrectIndexes.add(firstSelectedIndex!);
          incorrectIndexes.add(index);
        }
        firstSelectedIndex = null;
      }

      if (buttons.every((btn) => btn.matched)) {
        completed();
      }
    });
  }

  void completed() {
    if (isFirstTry) {
      widget.onFirstTryCorrect();
    }
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
          child: Text(
            "Next",
            style: TextStyle(
              color: Color(0xFF0C2D57),
              fontSize: 36,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: backgroundColor),
                child: Stack(
                  children: [
                    backTextMenuBar(
                      context,
                      () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DecimalsQuizzes(),
                        ),
                      ),
                      "Lesson ${widget.lessonNum} Exercises",
                    ),
                    Align(
                      alignment: Alignment(0.0, 0.6),
                      child: SizedBox(
                        width: 900,
                        height: 500,
                        child: GridView.count(
                          crossAxisCount: 4,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          padding: const EdgeInsets.all(12),
                          children: List.generate(buttons.length, (index) {
                            final button = buttons[index];
                            final bool isMatched = button.matched;
                            final bool isIncorrect = incorrectIndexes.contains(index);
                            final bool isSelected = firstSelectedIndex == index;

                            Color bgColor;
                            if (isMatched) {
                              bgColor = Colors.green;
                            } else if (isIncorrect) {
                              bgColor = Colors.red;
                            } else if (isSelected) {
                              bgColor = Colors.orange;
                            } else {
                              bgColor = Color(0xFFFFF5CD);
                            }

                            return ElevatedButton(
                              onPressed: () => handleButtonTap(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: bgColor,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1),
                                  borderRadius: BorderRadius.circular(84),
                                ),
                              ),
                              child: Text(
                                buttons[index].text,
                                style: const TextStyle(
                                  color: Color(0xFF0C2D57),
                                  fontSize: 24,
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// ——————— Results Page ———————
//
// Replace your existing DecimalsResultsPage in dec_quiz_page.dart with:

class DecimalsResultsPage extends StatefulWidget {
  final int correctAnswers;
  final int totalQuestions;
  final int quizNumber;

  const DecimalsResultsPage({
    required this.correctAnswers,
    required this.totalQuestions,
    required this.quizNumber,
    Key? key,
  }) : super(key: key);

  @override
  _DecimalsResultsPage createState() => _DecimalsResultsPage();
}

class _DecimalsResultsPage extends State<DecimalsResultsPage> {
  late ConfettiController _rightController;
  late ConfettiController _leftController;

  @override
  void initState() {
    super.initState();
    _rightController = ConfettiController(duration: const Duration(seconds: 3));
    _leftController  = ConfettiController(duration: const Duration(seconds: 3));

    // **WRITE INTO decimalQuizzes** instead of the old combined list
    var record = currentStudent.quizCompletion
        .decimalQuizzes[widget.quizNumber - 1];
    if (widget.correctAnswers > record.correctAnswers) {
      record.correctAnswers = widget.correctAnswers;
      record.calculatePercent();
    }

    // trigger confetti on perfect score
    if (widget.correctAnswers == widget.totalQuestions) {
      _rightController.play();
      _leftController.play();
    }
  }

  @override
  void dispose() {
    _rightController.dispose();
    _leftController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String text;
    if (widget.correctAnswers >= 1) {
      if (widget.correctAnswers == widget.totalQuestions) {
        text =
            "You got ALL ${widget.totalQuestions} questions correct on your first try!";
      } else {
        text =
            "You got ${widget.correctAnswers} of ${widget.totalQuestions} correct on your first try!";
      }
    } else {
      text = "You got none correct on your first try.";
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: backgroundColor),
                child: Stack(
                  children: [
                    boxText(
                      text,
                      x: 0.0,
                      y: -0.2,
                      width: 733,
                      height: 450,
                      fontSize: 80,
                    ),
                    buttonText(
                      "Back to Quizzes",
                      () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DecimalsQuizzes()),
                        );
                      },
                      x: 0.0,
                      y: 0.75,
                      width: 350,
                      height: 90,
                      fontSize: 40,
                    ),
                    Align(
                      alignment: Alignment(0.9, -0.95),
                      child: ConfettiWidget(
                        confettiController: _leftController,
                        blastDirection: pi / 2,
                        blastDirectionality: BlastDirectionality.directional,
                      ),
                    ),
                    Align(
                      alignment: Alignment(-0.9, -0.95),
                      child: ConfettiWidget(
                        confettiController: _rightController,
                        blastDirection: pi / 2,
                        blastDirectionality: BlastDirectionality.directional,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
