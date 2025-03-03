import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'login_page.dart'; //For the custom arrow
import 'usefulWidgets.dart';

class FractionsLectureQuiz extends StatefulWidget{
  @override
  _FractionsLectureQuiz createState() => _FractionsLectureQuiz();
}

class _FractionsLectureQuiz extends State<FractionsLectureQuiz>{
  void fractionsLecturePage() async{
    return;
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
                    Align( //Back button with "Fraction" text
                      alignment: Alignment(-0.9, -0.65),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Transform(
                            transform: Matrix4.identity()..translate(0.0, 0.9)..rotateZ(-1.57),
                            child: CustomArrowButton(
                              onPressed: dashBoardPage,
                            )
                          ),

                          SizedBox(
                            width:789,
                            height: 121,
                            child: Text(
                              'Fraction',
                              style: TextStyle(
                                color: Color(0xFF0C2D57),
                                fontSize: 75,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          )
                          
                        ]
                      )
                    ),

                    Align(
                      alignment: Alignment(0.0, 0.0),
                      child: Image.asset(
                        'lib/assets/images/menu_button.svg',
                        width: 102,
                        height: 78,
                      )
                    ), 
                    
                    Align( //Button Pair
                      alignment: Alignment(0.0, 0.75),
                      child: buttonPairEmojiText('📖', 'Lecture', fractionsLecturePage, '📝', 'Quiz', fractionsQuizPage)
                    ),
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