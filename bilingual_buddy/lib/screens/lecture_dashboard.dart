import 'package:flutter/material.dart';
import 'useful_widgets.dart';
import 'lessons_page.dart';
import 'dashboard_screen.dart';


class FractionsLecture extends StatefulWidget{
  @override
  _FractionsLecture createState() => _FractionsLecture();
}

class _FractionsLecture extends State<FractionsLecture>{

  void fractionLessons() async{
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => FractionsLessons()));  

  }

  void fractionQuizzes() async{
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => FractionsQuizzes()));
  }

  void fractionFlashcards() async{
    return;
  }

  void fractionDashBoardPage() async{//This creates a transistion that goes from left to right, where the default is right to left 
    Navigator.pushReplacement( 
      context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => DashboardScreen(), 
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
                    backTextMenuBar(fractionDashBoardPage, "Fraction Lecture"),
                    buttonPairText('Lessons', fractionLessons, 'Quizzes', fractionQuizzes, x: 0.0, y: -0.25, width: 412, height: 250, spacer: 35,fontSize: 70),
                    buttonText('Flashcards', fractionFlashcards, y: 0.75, width: 412, height: 250, fontSize: 70)
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