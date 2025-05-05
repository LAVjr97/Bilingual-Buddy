// File: dec_lecture_quiz_screen.dart

import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'useful_widgets.dart';
import 'dec_lecture_dashboard.dart';
import 'dec_lessons_page.dart';
import 'globals.dart';

class DecimalsLectureQuiz extends StatefulWidget {
  @override
  _DecimalsLectureQuizState createState() => _DecimalsLectureQuizState();
}

class _DecimalsLectureQuizState extends State<DecimalsLectureQuiz> {
  void decimalsLecturePage() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DecimalsLecture()),
    );
  }

  void decimalsQuizPage() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DecimalsQuizzes()),
    );
  }

  void decimalsDashBoardPage() async {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            DashboardScreen(),
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
                      "Decimals",
                    ),
                    buttonPairEmojiText(
                      '📖',
                      'Lecture',
                      decimalsLecturePage,
                      '📝',
                      'Quiz',
                      decimalsQuizPage,
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
