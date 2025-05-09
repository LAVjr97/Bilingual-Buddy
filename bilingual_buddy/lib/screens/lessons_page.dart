import 'package:flutter/material.dart';
import 'useful_widgets.dart';
import 'lecture_dashboard.dart';
import 'quiz_page.dart';
import 'lecture_page.dart';
import 'globals.dart';
import 'flashcards.dart';

void tempPage() async{
  return;
}

class FractionsQuizzes extends StatefulWidget{
    @override
    _FractionsQuizzes createState() => _FractionsQuizzes();
}

class _FractionsQuizzes extends State<FractionsQuizzes>{
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
                decoration: BoxDecoration(color: backgroundColor),
                child: Stack(
                  children: [
                    backTextMenuBar(context, fractionDashBoardPage, "Fraction Quizzes"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buttonText('1', () => quiz([
                          MCQ("How do you write a quarter in English?", ["One-Fifth", "One-Fourth", "One-Sixth"], 1, "hint"), 
                          TF("Half is known as 1/2\n", ["False", "True"], 1, "hint"), 
                          TXT("How do you write\n3/4\nin English?", "Three-Fourths", "hint"),               
                          MCQ("How do you write 4/8 in English?", ["Four-Elevenths","Four-Eighths","Twelve-Eighths"], 1, "hint")
                        ], 1), 
                          x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128, backColor: currentStudent.quizCompletion.fractionQuizzes[0].percentCompleted == 0 ? buttonColor : getColorForPercentage(currentStudent.quizCompletion.fractionQuizzes[0].percentCompleted)
                        ),
                        buttonText('2', () => quiz([
                          MCQ("Which fraction is equivalent to 3/6?", ["1/2", "2/3", "3/4"], 0, "hint"),
                          TXT("How do you write\n1/4\nin English?", "One-Fourth", "hint"),                
                          MCQ("How do you write 7/8 in English?", ["Seven-Eighths", "Seven-Fifths", "Seven-Tenths"], 0, "hint"),
                          TF("Two-fifths is larger than one-half.\n", ["True", "False"], 1, "hint")
                        ], 2), 
                          x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128, backColor: currentStudent.quizCompletion.fractionQuizzes[1].percentCompleted == 0 ? buttonColor : getColorForPercentage(currentStudent.quizCompletion.fractionQuizzes[1].percentCompleted)
                        ),
                        buttonText('3', () => quiz([
                          MCQ("How do you write 5/6 in English?", ["Five-Sixths", "Five-Eighths", "Five-Thirds"], 0, "hint"), 
                          TF("One-third is smaller than one-half.\n", ["True", "False"], 0, "hint"), 
                          TXT("How do you write\n2/9\nin English?", "Two-Ninths", "hint"),                       
                          TF("Two-fourths is the same as one-half.\n", ["True", "False"], 1, "hint")
                        ], 3), 
                          x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128, backColor: currentStudent.quizCompletion.fractionQuizzes[2].percentCompleted == 0 ? Color(0xFFFFF5CD) : getColorForPercentage(currentStudent.quizCompletion.fractionQuizzes[2].percentCompleted)
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buttonText('4', () => quiz([
                          MCQ("How do you write 2/3 in English?", ["Two-Thirds", "Two-Fifths", "Two-Sevenths"], 0, "hint"), 
                          TXT("How do you write\n3/5\nin English?", "Three-Fifths", "hint"),                     
                          MCQ("Which fraction is equivalent to 6/8?", ["Three-Fourths", "One-Half", "Two-Thirds"], 0, "hint"), 
                          TF("One-fifth is larger than one-fourth.\n", ["True", "False"], 1, "hint")
                        ], 4), 
                          x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128, backColor: currentStudent.quizCompletion.fractionQuizzes[3].percentCompleted == 0 ? Color(0xFFFFF5CD) : getColorForPercentage(currentStudent.quizCompletion.fractionQuizzes[3].percentCompleted)
                        ),
                        buttonText('5', () => quiz([
                          TXT("How do you write\n3/8\nin English?", "Three-Eighths", "Como se escribe 3/8 en ingles?"),
                          MCQ("Which fraction equals 2/4?", ["One-Half", "Two-Fourths", "One-Quarter"], 0, "hint"),  
                          TF("Three-quarters is written as 3/4.\n", ["True", "False"], 1, "hint"),                     
                          TXT("How do you write\n4/5\nin English?", "Four-Fifths", "hint")                            
                        ], 5), 
                          x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128, backColor: currentStudent.quizCompletion.fractionQuizzes[4].percentCompleted == 0 ? Color(0xFFFFF5CD) : getColorForPercentage(currentStudent.quizCompletion.fractionQuizzes[4].percentCompleted)
                        ),
                        buttonText('G', () => quiz([
                          MATCH_TILES("Question", ["Three Fourths", "3/4", "One Half", "1/2", "Eleven Fifteenths", "11/15", "Nine Thirds", "9/3"], "Hint"), MATCH_TILES(
                            "Match the fractions to their numeric forms.",
                            [
                              "One Third",     "1/3",
                              "Two Fifths",    "2/5",
                              "Three Sixths",  "3/6",
                              "Seven Eighths", "7/8"
                            ],
                            "Match each fraction with its numeric form."
                          ),

                          // New set 2
                          MATCH_TILES(
                            "Match the fractions to their numeric forms.",
                            [
                              "Five Sixths",   "5/6",
                              "Three Eighths", "3/8",
                              "Ten Twelfths",  "10/12",
                              "Two Sevenths",  "2/7"
                            ],
                            "Match each fraction with its numeric form."
                          )], 6), 
                          x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128, backColor: currentStudent.quizCompletion.fractionQuizzes[5].percentCompleted == 0 ? Color(0xFFFFF5CD) : getColorForPercentage(currentStudent.quizCompletion.fractionQuizzes[5].percentCompleted)
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
  void lecturePage(String path, int num){
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => LessonPage(pdfPath: path, lessonNum: num))); 
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
                decoration: BoxDecoration(color: backgroundColor),
                child: Stack(
                  children: [
                    backTextMenuBar(context, fractionDashBoardPage, "Fraction Lessons"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buttonText('1', () => lecturePage("assets/lessons/Fraction_Lessons.pdf", 1), x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128),
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

class FractionsFlashCards extends StatefulWidget{
  @override
  _FractionsFlashCards createState() => _FractionsFlashCards();
}

class _FractionsFlashCards extends State<FractionsFlashCards>{
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

  void flashCardPage(List<Flashcards> flashcards, int num){
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => FlashcardViewer(flashcards: flashcards, lessonNum: num,)));
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
                decoration: BoxDecoration(color: backgroundColor),
                child: Stack(
                  children: [
                    backTextMenuBar(context, fractionDashBoardPage, "Fraction Flashcards"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buttonText('1', () => flashCardPage([Flashcards("Un Cuarto", "One-fourth\n1/4"), Flashcards("Dos-Novenos", "Two-Ninths\n2/9"), Flashcards("Tres-Cuartos", "Three-fourths\n3/4"), Flashcards("Cinco-Sextos", "Five-Sixths\n5/6"), Flashcards("Siete-Octavos", "Seven-Eighths\n7/8")], 1), x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128),
                        buttonText('2', () => flashCardPage([Flashcards("Un Medio", "One-half\n1/2"), Flashcards("Un Tercio", "One-third\n1/3"), Flashcards("Dos Quintos", "Two-fifths\n2/5"), Flashcards("Tres Cuartos", "Three-fourths\n3/4"), Flashcards("Cuatro Quintos", "Four-fifths\n4/5")], 2), x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128),
                        buttonText('3', () => flashCardPage([Flashcards("Dos Tercios", "Two-thirds\n2/3"), Flashcards("Cinco Sextos", "Five-sixths\n5/6"), Flashcards("Siete Octavos", "Seven-eighths\n7/8"), Flashcards("Cuatro Novenos", "Four-ninths\n4/9"), Flashcards("Seis Décimos", "Six-tenths\n6/10")], 3), x: 0.0, y: -0.3, width: 310, height: 270, fontSize: 128),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buttonText('4', () => flashCardPage([Flashcards("Cinco Décimos", "Five-tenths\n5/10"), Flashcards("Siete Décimos", "Seven-tenths\n7/10"), Flashcards("Tres Sextos", "Three-sixths\n3/6"), Flashcards("Dos Octavos", "Two-eighths\n2/8"), Flashcards("Ocho Novenos", "Eight-ninths\n8/9")], 4), x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128),
                        buttonText('5', () => flashCardPage([Flashcards("Nueve Cuartos", "Nine-quarters\n9/4"), Flashcards("Diez Novenos", "Ten-ninths\n10/9"), Flashcards("Un Sexto", "One-sixth\n1/6"), Flashcards("Once Oncesavos", "Eleven-elevenths\n11/11"), Flashcards("Cuatro Tercios", "Four-thirds\n4/3")], 5), x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128),
                        buttonText('6', () => flashCardPage([Flashcards("Uno Doceavos", "One-twelfths\n1/12"), Flashcards("Tres Octavos", "Three-eighths\n3/8"), Flashcards("Dos Cuartos", "Two-quarters\n2/4"), Flashcards("Seis Novenos", "Six-ninths\n6/9"), Flashcards("Cuatro Sextos", "Four-sixths\n4/6")], 6), x: 0.0, y: 0.85, width: 310, height: 270, fontSize: 128),
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