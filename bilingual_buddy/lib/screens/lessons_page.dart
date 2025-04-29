import 'package:flutter/material.dart';
import 'useful_widgets.dart';
import 'lecture_dashboard.dart';
import 'quiz_page.dart';
import 'lecture_page.dart';
import 'games_page.dart';
import 'globals.dart';

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
                    backTextMenuBar(context, fractionDashBoardPage, "Fraction Quizzes"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buttonText('1', () => quiz([
                          MCQ("How do you write a quarter in English?", ["One-Fifth", "One-Fourth", "One-Sixth"], 1,"hint"), 
                          TF("Half is known as 1/2\n", ["False", "True"], 1, "hint"), 
                          MCQ("How do you write 2/9 in English?", ["Two-Ninths", "Two-Halves", "One-Seventh"], 0, "hint"), 
                          MCQ("How do you write 4/8 in English?", ["Four-Elevenths","Four-Eighths","Twelve-Eighths"], 1, "hint")], 1), 
                          x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128, backColor: currentStudent.quizCompletion.completedQuizzes[0].percentCompleted == 0 ? Color(0xFFFFF5CD) : getColorForPercentage(currentStudent.quizCompletion.completedQuizzes[0].percentCompleted)
                        ),
                        buttonText('2', () => quiz([
                          MCQ("Which fraction is equivalent to 3/6?", ["1/2", "2/3", "3/4"], 0, "hint"),
                          TF("One-fourth is smaller than one-half.\n", ["True", "False"], 0, "hint"),
                          MCQ("How do you write 7/8 in English?", ["Seven-Eighths", "Seven-Fifths", "Seven-Tenths"], 0, "hint"),
                          TF("Two-fifths is larger than one-half.\n", ["True", "False"], 1, "hint")], 2), 
                          x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128, backColor: currentStudent.quizCompletion.completedQuizzes[1].percentCompleted == 0 ? Color(0xFFFFF5CD) : getColorForPercentage(currentStudent.quizCompletion.completedQuizzes[1].percentCompleted)
                        ),
                        buttonText('3', () => quiz([
                          MCQ("How do you write 5/6 in English?", ["Five-Sixths", "Five-Eighths", "Five-Thirds"], 0, "hint"), 
                          TF("One-third is smaller than one-half.\n", ["True", "False"], 0, "hint"), 
                          MCQ("Which fraction is equivalent to 4/8?", ["One-Half", "Two-Thirds", "Three-Fourths"], 0, "hint"), 
                          TF("Two-fourths is the same as one-half.\n", ["True", "False"], 1, "hint")], 3), 
                          x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128, backColor: currentStudent.quizCompletion.completedQuizzes[2].percentCompleted == 0 ? Color(0xFFFFF5CD) : getColorForPercentage(currentStudent.quizCompletion.completedQuizzes[2].percentCompleted)
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buttonText('4', () => quiz([
                          MCQ("How do you write 2/3 in English?", ["Two-Thirds", "Two-Fifths", "Two-Sevenths"], 0, "hint"), 
                          TF("Three-fourths is larger than one-half.\n", ["True", "False"], 0, "hint"), 
                          MCQ("Which fraction is equivalent to 6/8?", ["Three-Fourths", "One-Half", "Two-Thirds"], 0, "hint"), 
                          TF("One-fifth is larger than one-fourth.\n", ["True", "False"], 1, "hint")], 4), 
                          x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128, backColor: currentStudent.quizCompletion.completedQuizzes[3].percentCompleted == 0 ? Color(0xFFFFF5CD) : getColorForPercentage(currentStudent.quizCompletion.completedQuizzes[3].percentCompleted)
                        ),
                        buttonText('5', () => quiz([
                          TXT("How do you write\n3/8\nin English?", "Three-Eighths", "Como se escribe 3/8 en ingles?")], 5), 
                          x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128, backColor: currentStudent.quizCompletion.completedQuizzes[4].percentCompleted == 0 ? Color(0xFFFFF5CD) : getColorForPercentage(currentStudent.quizCompletion.completedQuizzes[4].percentCompleted)
                        ),
                        buttonText('+', () => quiz([
                          MATCH_TILES("Question", ["Three Fourths", "3/4", "One Half", "1/2", "Eleven Fifteenths", "11/15", "Nine Thirds", "9/3"], "Hint")], 6), 
                          x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128, backColor: currentStudent.quizCompletion.completedQuizzes[5].percentCompleted == 0 ? Color(0xFFFFF5CD) : getColorForPercentage(currentStudent.quizCompletion.completedQuizzes[5].percentCompleted)
                        ),
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
                    backTextMenuBar(context, fractionDashBoardPage, "Fraction Lessons"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buttonText('1', () => lecturePage("assets/lessons/Senior_Design.pdf"), x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128),
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