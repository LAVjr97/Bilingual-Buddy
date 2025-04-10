import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'useful_widgets.dart';
import 'lecture_dashboard.dart';

class FractionsLectureQuiz extends StatefulWidget{
  @override
  _FractionsLectureQuiz createState() => _FractionsLectureQuiz();
}

class _FractionsLectureQuiz extends State<FractionsLectureQuiz>{
  void fractionsLecturePage() async{
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => FractionsLecture()));  
  }

  void fractionsQuizPage() async{
    return; 
  }

  void dashBoardPage() async{//This creates a transistion that goes from left to right, where the default is right to left 
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
                  backTextMenuBar(dashBoardPage, "Fraction"),
                  buttonPairEmojiText('📖', 'Lecture', fractionsLecturePage, '📝', 'Quiz', fractionsQuizPage)
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
 
//We can create the lecture and quiz screen for deciamls in this file as well