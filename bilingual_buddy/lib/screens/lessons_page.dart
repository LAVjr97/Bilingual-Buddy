import 'package:flutter/material.dart';
import 'useful_widgets.dart';
import 'lecture_dashboard.dart';
import 'quiz_page.dart';
import 'lecture_page.dart';

class FractionsQuizzes extends StatefulWidget{
    @override
    _FractionsQuizzes createState() => _FractionsQuizzes();
}

class _FractionsQuizzes extends State<FractionsQuizzes>{

  void tempPage() async{
    return;
  }

  void quiz(List<Question> questions, int num) async{
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => QuestionsPage(questions, num))); 
  }


  void fractionDashBoardPage() async{
    Navigator.pushReplacement( 
      context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => FractionsLecture(), 
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      )
    );  
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false, //makes sure that the keyboard popping up from the bottom doesn't mess with the size of the page
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container( //Screen borders for the background color
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Color(0xFFB7E0FF)),
                child: Stack(
                  children: [
                    backTextMenuBar(fractionDashBoardPage, "Fraction Quizzes"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buttonText('1', () => quiz([MCQ("¿Cómo se escribe un cuarto en inglés?", ["One-Fifth", "One-Fourth", "One-Sixth"], 1), TF("asd\n", ["False", "True"], 1), MCQ("¿Cómo se escribe dos novenos en inglés?", ["Two-Ninths", "Two-Halves", "One-Seventh"], 0), MCQ("¿Cómo se escribe cuatro octavos en inglés?", ["Four-Elevenths","Four-Eighths","Twelve-Eighths"], 1)], 1), x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128),
                        buttonText('2', () => quiz([MCQ("¿Cómo se escribe un cuarto en inglés?", ["One-Fifth", "One-Fourth", "One-Sixth"], 1), TF("asd\n", ["False", "True"], 1), MCQ("¿Cómo se escribe dos novenos en inglés?", ["Two-Ninths", "Two-Halves", "One-Seventh"], 0), MCQ("¿Cómo se escribe cuatro octavos en inglés?", ["Four-Elevenths","Four-Eighths","Twelve-Eighths"], 1)], 2), x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128),
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
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
}

class FractionsLessons extends StatefulWidget{
  @override
  _FractionsLessons createState() => _FractionsLessons();
}

class _FractionsLessons extends State<FractionsLessons>{

  void tempPage() async{
    return;
  }

  void fractionDashBoardPage() async{
    Navigator.pushReplacement( 
      context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => FractionsLecture(), 
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      )
    );  
  }


  //Senior Design.pdf
  void lecturePage(String path){
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => LessonPage(pdfPath: path))); 
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false, //makes sure that the keyboard popping up from the bottom doesn't mess with the size of the page
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container( //Screen borders for the background color
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Color(0xFFB7E0FF)),
                child: Stack(
                  children: [
                    backTextMenuBar(fractionDashBoardPage, "Fraction Lessons"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buttonText('1', () => lecturePage("lib/assets/lessons/Senior_Design.pdf"), x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128),
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
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
}