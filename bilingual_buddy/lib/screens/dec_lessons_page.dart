// File: dec_lessons_page.dart

import 'package:flutter/material.dart';
import 'useful_widgets.dart';
import 'dec_lecture_dashboard.dart';
import 'dec_quiz_page.dart';
import 'dec_lecture_page.dart';
import 'globals.dart';
import 'dec_flashcards.dart';

void tempPage() async {
  return;
}

//
// ——————— Decimals Quizzes Screen ———————
//
class DecimalsQuizzes extends StatefulWidget {
  @override
  _DecimalsQuizzes createState() => _DecimalsQuizzes();
}

class _DecimalsQuizzes extends State<DecimalsQuizzes> {
  void quiz(List<Question> questions, int num) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DecimalsQuestionsPage(questions, num),
      ),
    );
  }

  void decimalsDashBoardPage() async {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            DecimalsLecture(),
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
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
                      decimalsDashBoardPage,
                      "Decimal Quizzes",
                    ),

                    // — First row of quiz buttons —
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buttonText('1', () => quiz([
                            MCQ("How do you write 2.3 in English?", ["Two Point Three", "Two Comma Three", "Two and Three"], 0, "hint"), 
                            TF("The decimal 0.75 is said as 'Zero Point Seventy-Five' in English.", ["True", "False"], 1, "hint"), 
                            TXT("How do you say 5.6 in English?", "Five Point Six", "hint"), 
                            MCQ("Which is the correct way to say 0.4 in English?", ["Zero Four", "Zero Point Four", "Four Tenth"], 1, "hint"),
                          ], 1), 
                          x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 120, backColor: currentStudent.quizCompletion.decimalQuizzes[0].percentCompleted == 0 ? Color(0xFFFFF5CD) : getColorForPercentage(currentStudent.quizCompletion.decimalQuizzes[0].percentCompleted)
                          ),

                        buttonText('2', () => quiz([
                            TF("In English, 3.14 is said as 'Three Point One Four'.", ["True", "False"], 0, "hint"),
                            MCQ("What is the English for 0.08?", ["Zero Point Eight", "Eight Hundredths", "Zero Point Zero Eight"], 2, "hint"),
                            TXT("How do you say 10.5 in English?", "Ten Point Five", "hint"),
                            MCQ("Which is correct for 7.07?", ["Seven Point Zero Seven", "Seven Point Seven", "Seven Zero Seven"], 0, "hint"),
                          ], 2), 
                          x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128, backColor: currentStudent.quizCompletion.decimalQuizzes[1].percentCompleted == 0 ? Color(0xFFFFF5CD) : getColorForPercentage(currentStudent.quizCompletion.decimalQuizzes[1].percentCompleted)
                          ),

                        buttonText('3', () => quiz([
                            MCQ("How do you say 12.99 in English?", ["Twelve Ninety-Nine", "Twelve Point Ninety-Nine", "Twelve Point Nine Nine"], 2, "hint"),
                            TF("In English, 0.5 can be called 'A Half'.", ["True", "False"], 0, "hint"),
                            TXT("Write 4.25 in English.", "Four Point Two Five", "hint"),
                            MCQ("What is the correct way to say 0.001?", ["Zero Point Zero Zero One", "Zero Point One", "One Thousandth"], 0, "hint"),
                          ], 3), 
                          x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 120, backColor: currentStudent.quizCompletion.decimalQuizzes[2].percentCompleted == 0 ? Color(0xFFFFF5CD) : getColorForPercentage(currentStudent.quizCompletion.decimalQuizzes[2].percentCompleted)
                          ),

                      ],
                    ),

                    // — Second row of quiz buttons —
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buttonText('4', () => quiz([
                              MCQ("How do you write 15.75 in English?", ["Fifteen Point Seventy-Five", "Fifteen Seventy-Five", "Fifteen and Seventy-Five"], 0, "hint"),
                              TF("The number 0.3 is said as 'Zero Point Three'.", ["True", "False"], 0, "hint"),
                              TXT("How do you say 9.01 in English?", "Nine Point Zero One", "hint"),
                              MCQ("Which of the following is correct for 100.5?", ["One Hundred Five", "One Hundred Point Five", "One Zero Zero Point Five"], 1, "hint"),
                            ], 4), 
                            x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128, backColor: currentStudent.quizCompletion.decimalQuizzes[3].percentCompleted == 0 ? Color(0xFFFFF5CD) : getColorForPercentage(currentStudent.quizCompletion.decimalQuizzes[3].percentCompleted)
                            ),

                        buttonText('5', () => quiz([
                              TF("In English, 0.09 is said as 'Zero Point Nine'.", ["True", "False"], 1, "hint"),
                              MCQ("How do you say 2.75?", ["Two Seventy-Five", "Two Point Seven Five", "Two And Seventy-Five"], 1, "hint"),
                              TXT("How do you write 0.505 in English?", "Zero Point Five Zero Five", "hint"),
                              MCQ("Which of these is the correct way to say 6.66?", ["Six Point Six Six", "Six Sixty-Six", "Six and Sixty-Six"], 0, "hint"),
                            ], 5), 
                            x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128, backColor: currentStudent.quizCompletion.decimalQuizzes[4].percentCompleted == 0 ? Color(0xFFFFF5CD) : getColorForPercentage(currentStudent.quizCompletion.decimalQuizzes[4].percentCompleted)
                            ),

                        buttonText('G', () => quiz([
                              MATCH_TILES("Match the numbers to their English words.", [
                                "Three Point Four", "3.4",
                                "One Point Five", "1.5",
                                "Zero Point Nine", "0.9",
                                "Seven Point Zero Five", "7.05"
                              ], "Match each decimal with its English wording.")
                            ], 6), 
                            x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128, backColor: currentStudent.quizCompletion.decimalQuizzes[5].percentCompleted == 0 ? Color(0xFFFFF5CD) : getColorForPercentage(currentStudent.quizCompletion.decimalQuizzes[5].percentCompleted)
                            ),

                      ],
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
// ——————— Decimals Lessons Screen ———————
//
class DecimalsLessons extends StatefulWidget {
  @override
  _DecimalsLessons createState() => _DecimalsLessons();
}

class _DecimalsLessons extends State<DecimalsLessons> {
  void decimalsDashBoardPage() async {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            DecimalsLecture(),
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  void lessonPage(String path, int num) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DecimalsLessonPage(pdfPath: path, lessonNum: num),
      ),
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
                      decimalsDashBoardPage,
                      "Decimal Lessons",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buttonText(
                          '1',
                          () => lessonPage(
                              "assets/lessons/Senior_Design.pdf", 1),
                          x: 0.0,
                          y: -0.3,
                          width: 310,
                          height: 270,
                          fontSize: 128,
                        ),
                        buttonText('2', tempPage,
                            x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128),
                        buttonText('3', tempPage,
                            x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buttonText('4', tempPage,
                            x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128),
                        buttonText('5', tempPage,
                            x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128),
                        buttonText('+', tempPage,
                            x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128),
                      ],
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
// ——————— Decimals Flashcards Screen ———————
//
class DecimalsFlashCards extends StatefulWidget {
  @override
  _DecimalsFlashCards createState() => _DecimalsFlashCards();
}

class _DecimalsFlashCards extends State<DecimalsFlashCards> {
  void decimalsDashBoardPage() async {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            DecimalsLecture(),
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  void flashCardPage(List<Flashcards> flashcards, int num) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DecimalsFlashcardViewer(
          flashcards: flashcards,
          lessonNum: num,
        ),
      ),
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
                      decimalsDashBoardPage,
                      "Decimal Flashcards",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buttonText('1', () => flashCardPage([Flashcards("Cero punto cinco", "Zero point five\n0.5"),Flashcards("Uno punto dos", "One point two\n1.2"),Flashcards("Dos punto cinco", "Two point five\n2.5"),Flashcards("Tres punto catorce", "Three point one four\n3.14"),Flashcards("Cero punto veinticinco", "Zero point two five\n0.25")], 1), x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128),
                        buttonText('2', tempPage, x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128),
                        buttonText('3', tempPage, x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buttonText('4', tempPage, x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128),
                        buttonText('5', tempPage, x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128),
                        buttonText('+', tempPage, x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128),
                      ],
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
