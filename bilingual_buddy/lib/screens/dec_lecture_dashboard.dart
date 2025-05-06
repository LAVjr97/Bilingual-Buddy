// File: dec_lecture_dashboard.dart

import 'package:flutter/material.dart';
import 'useful_widgets.dart';
import 'dec_lessons_page.dart';
import 'dashboard_screen.dart';
import 'globals.dart';

class DecimalsLecture extends StatefulWidget {
  @override
  _DecimalsLectureState createState() => _DecimalsLectureState();
}

class _DecimalsLectureState extends State<DecimalsLecture> {

  void decimalsLessons() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DecimalsLessons()),
    );
  }

  void decimalsQuizzes() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DecimalsQuizzes()),
    );
  }

  void decimalsFlashcards() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DecimalsFlashCards()),
    );
  }

  void decimalsDashBoardPage() async {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => DashboardScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
                      "Decimals Lecture",
                    ),
                    buttonPairText(
                      'Lessons',
                      decimalsLessons,
                      'Quizzes',
                      decimalsQuizzes,
                      x: 0.0,
                      y: -0.25,
                      width: 412,
                      height: 250,
                      spacer: 35,
                      fontSize: 70,
                    ),
                    buttonText(
                      'Flashcards',
                      decimalsFlashcards,
                      y: 0.75,
                      width: 412,
                      height: 250,
                      fontSize: 70,
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
