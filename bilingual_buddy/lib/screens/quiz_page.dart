import 'package:flutter/material.dart';
import 'useful_widgets.dart';
import 'lessons_page.dart';
import 'dart:math';
import 'student_info.dart';

class Question{
  String question;
  
  //Constructor
  Question(this.question);
}

class MCQ extends Question{ //MCQ class
  List<String> answers;
  int correctAnswer;

  //Constructor
  MCQ(super.question, this.answers, this.correctAnswer); 
}

class TF extends Question{ //True or False class
  List<String> answers;
  int correctAnswer;

  //Constructor
  TF(super.question, this.answers, this.correctAnswer);
}

class TXT extends Question{
  List<String> emojis;
  String correctAnswer;

  TXT(super.question, this.emojis, this.correctAnswer);
}

//"super" keyword calls the constructor of the parent class, which is "Question" and initilizes the question 
//string with whatever super.question is given, classes are pretty similar to how it works in cpp.

//This class is what's used to display the questions
class QuestionsPage extends StatefulWidget{
  List<Question> listOfQuestions; //= [MCQ("¿Cómo se escribe un cuarto en inglés?", ["One-Fifth", "One-Fourth", "One-Sixth"], 1), TF("asd\n", ["False", "True"], 1), MCQ("¿Cómo se escribe dos novenos en inglés?", ["Two-Ninths", "Two-Halves", "One-Seventh"], 0), MCQ("¿Cómo se escribe cuatro octavos en inglés?", ["Four-Elevenths","Four-Eighths","Twelve-Eighths"], 1)]; //Add the bullshit questions here, use the constructor of MCQ or TF to add questions
  int lessonNum;

  QuestionsPage(this.listOfQuestions, this.lessonNum);

  @override
  _QuestionsPage createState() => _QuestionsPage();
}


class _QuestionsPage extends State<QuestionsPage>{

  int currentQIndex = 0, firstTryCorrectAnswers = 0;

  //Moves the current index to the next question
  void nextQuestion(){
    if(currentQIndex < widget.listOfQuestions.length - 1){
      setState(() {currentQIndex++;} ); //Set state rebuilds the widget (so like a refresh, updating whater variable we're changing here), increasing currentQIndex
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(
            correctAnswers: firstTryCorrectAnswers,
            totalQuestions: widget.listOfQuestions.length,
          ),
        ),
      ); 
    }
  }

  //Shuffles the list of questions that it recieves from the contrstructor before the first question is shown
  @override
  void initState() {
    super.initState();
    widget.listOfQuestions.shuffle(Random()); //Shuffle the list of questions
  }

  @override
  Widget build(BuildContext context){
    Question currentQuestion = widget.listOfQuestions[currentQIndex]; 

    if(currentQuestion is MCQ){
      return MCQPage(
        question: currentQuestion, 
        onNext: nextQuestion, 
        onFirstTryCorrect: () {
          setState(() {
            firstTryCorrectAnswers++;
          });
        },
        lessonNum: widget.lessonNum
      );
    } else {
      

      return TFPage(
        question: currentQuestion as TF,
        onNext: nextQuestion,
        onFirstTryCorrect: (){
          setState(() {
            firstTryCorrectAnswers++;
          });
        },
        lessonNum: widget.lessonNum
        ); //Replace this with whatever the true or false questions are going to be
    }
  }
}

class TFPage extends StatefulWidget{
  final int lessonNum;
  final TF question; 
  final VoidCallback onNext;
  final VoidCallback onFirstTryCorrect;

  const TFPage({required this.question, required this.onNext, required this.onFirstTryCorrect, required this.lessonNum, Key? key}) : super(key: key);
  _TFPage createState() => _TFPage();
}

class _TFPage extends State<TFPage>{
  bool isFirstTry = true;
  late List<String> shuffledAnswers;
  late int shuffledCorrectAnswerIndex;

  @override
  void initState() {
    super.initState();
    shuffleAnswers();
  }

  @override
  void didUpdateWidget(covariant TFPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      shuffleAnswers();
      isFirstTry = true;
    }
  }

  void shuffleAnswers() {
    shuffledAnswers = widget.question.answers;
    shuffledCorrectAnswerIndex = widget.question.correctAnswer;

    // Shuffle the answers and update the correct answer index
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

  void fractionQuizzes(){
    Navigator.pushReplacement( 
      context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => FractionsQuizzes(), 
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

  void leaveQuiz() async{
    showCustomDialog(
      context,
      "Are You Sure You Want to Quit?",
      [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            fractionQuizzes();
          },
          child: Text(
            "Yes",
            style: TextStyle(
              color: Color(0xFF0C2D57),
              fontSize: 36,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800,
            )
          ),
        ),
        SizedBox(width: 20), //Space between the yes and no
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "No",
            style: TextStyle(
              color: Color(0xFF0C2D57),
              fontSize: 36,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800,
            )
          ),
        ),
      ]
    );
  }

  void correct(){
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
            widget.onNext(); //This calls for the next question
          },
          child: Text(
            "Next",
            style: TextStyle(
              color: Color(0xFF0C2D57),
              fontSize: 36,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800,
            )
          ),
        ),
      ],
    );
  }

  void incorrect(){
    isFirstTry = false;

    showCustomDialogEmoji(
      context,
      "Incorrect!",
      "❌❌❌",
      [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Retry 🥲",
            style: TextStyle(
              color: Color(0xFF0C2D57),
              fontSize: 36,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800,
            )
          ),
        ),
      ],
    );
  }

  void checkAnswer(int selectedIndex){
    if(selectedIndex == shuffledCorrectAnswerIndex){
      correct();
    } else{
      incorrect();
    }
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
                    backTextMenuBar(leaveQuiz, "Lesson ${widget.lessonNum} Exercises"),
                    buttonText(shuffledAnswers[0], () => checkAnswer(0), x: 0.85, y: -0.025, width: 400, height: 156, fontSize: 48),
                    buttonText(shuffledAnswers[1], () => checkAnswer(1), x: 0.85, y: 0.575, width: 400, height: 156, fontSize: 48),
                    boxText(widget.question.question),
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

class MCQPage extends StatefulWidget {
  final int lessonNum;
  final MCQ question;
  final VoidCallback onNext;
  final VoidCallback onFirstTryCorrect;

  const MCQPage({required this.question, required this.onNext, required this.onFirstTryCorrect, required this.lessonNum, Key? key}) : super(key: key);

  @override
  _MCQPage createState() => _MCQPage();
}

class _MCQPage extends State<MCQPage>{
  bool isFirstTry = true;
  late List<String> shuffledAnswers;
  late int shuffledCorrectAnswerIndex;

  @override
  void initState() {
    super.initState();
    shuffleAnswers();
  }

  @override
  void didUpdateWidget(covariant MCQPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      shuffleAnswers();
      isFirstTry = true;
    }
  }

  void shuffleAnswers() {
    shuffledAnswers = widget.question.answers;
    shuffledCorrectAnswerIndex = widget.question.correctAnswer;

    // Shuffle the answers and update the correct answer index
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

  void fractionQuizzes(){
    Navigator.pushReplacement( 
      context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => FractionsQuizzes(), 
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

  //Pop up if the student wants to leave the quiz using the back button from the top left corner
  void leaveQuiz() async{
    showCustomDialog(
      context,
      "Are You Sure You Want to Quit?",
      [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            fractionQuizzes();
          },
          child: Text(
            "Yes",
            style: TextStyle(
              color: Color(0xFF0C2D57),
              fontSize: 36,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800,
            )
          ),
        ),
        SizedBox(width: 20), //Space between the yes and no
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "No",
            style: TextStyle(
              color: Color(0xFF0C2D57),
              fontSize: 36,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800,
            )
          ),
        ),
      ]
    );
  }

  void correct(){
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
            widget.onNext(); //This calls for the next question
          },
          child: Text(
            "Next",
            style: TextStyle(
              color: Color(0xFF0C2D57),
              fontSize: 36,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800,
            )
          ),
        ),
      ],
    );
  }

  void incorrect(){
    isFirstTry = false;

    showCustomDialogEmoji(
      context,
      "Incorrect!",
      "❌❌❌",
      [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Retry 🥲",
            style: TextStyle(
              color: Color(0xFF0C2D57),
              fontSize: 36,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800,
            )
          ),
        ),
      ],
    );
  }

  void checkAnswer(int selectedIndex){
    if(selectedIndex == shuffledCorrectAnswerIndex){
      correct();
    } else{
      incorrect();
    }
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
                    backTextMenuBar(leaveQuiz, "Lesson ${widget.lessonNum} Exercises"),
                    buttonText(shuffledAnswers[0], () => checkAnswer(0), x: 0.85, y: -0.35, width: 400, height: 156, fontSize: 48),
                    buttonText(shuffledAnswers[1], () => checkAnswer(1), x: 0.85, y: 0.25, width: 400, height: 156, fontSize: 48),
                    buttonText(shuffledAnswers[2], () => checkAnswer(2), x: 0.85, y: 0.85, width: 400, height: 156, fontSize: 48),
                    boxText(widget.question.question),
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

class ResultsPage extends StatefulWidget {
  final int correctAnswers;
  final int totalQuestions;

  const ResultsPage({required this.correctAnswers, required this.totalQuestions, Key? key}) : super(key: key);

  @override
  _ResultsPage createState() => _ResultsPage();
}

class _ResultsPage extends State<ResultsPage> {
  void fractionQuizzes() async{
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => FractionsQuizzes())); 
  }

  @override
  Widget build(BuildContext context) {
    String text;
    if(widget.correctAnswers >= 1){
      text = "You got ${widget.correctAnswers} of ${widget.totalQuestions} correct on your first try!";
    } else {
      text = "You got none correct on your first try.";
    }

    return Scaffold(
      resizeToAvoidBottomInset: false, // makes sure that the keyboard popping up from the bottom doesn't mess with the size of the page
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                // Screen borders for the background color
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Color(0xFFB7E0FF)),
                child: Stack(
                  children: [
                    boxText(text, x: 0.0, y: -0.2, width: 733, height: 450, fontSize: 80),
                    buttonText("Back to Quizzes", fractionQuizzes, x: 0.0, y: 0.75, width: 350, height: 90, fontSize: 40)
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

class TXTPage extends StatefulWidget {
  final TXT question;
  final VoidCallback onNext;
  final VoidCallback onFirstTryCorrect;

  const TXTPage({required this.question, required this.onNext, required this.onFirstTryCorrect, Key? key}) : super(key: key);

  @override
  _TXTPage createState() => _TXTPage();
}

class _TXTPage extends State<TXTPage> {
  bool isFirstTry = true;
  late String input;

  void fractionQuizzes(){
    Navigator.pushReplacement( 
      context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => FractionsQuizzes(), 
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

    void leaveQuiz() async{
    showCustomDialog(
      context,
      "Are You Sure You Want to Quit?",
      [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            fractionQuizzes();
          },
          child: Text(
            "Yes",
            style: TextStyle(
              color: Color(0xFF0C2D57),
              fontSize: 36,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800,
            )
          ),
        ),
        SizedBox(width: 20), //Space between the yes and no
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "No",
            style: TextStyle(
              color: Color(0xFF0C2D57),
              fontSize: 36,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800,
            )
          ),
        ),
      ]
    );
  }

  void correct(){
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
            widget.onNext(); //This calls for the next question
          },
          child: Text(
            "Next",
            style: TextStyle(
              color: Color(0xFF0C2D57),
              fontSize: 36,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800,
            )
          ),
        ),
      ],
    );
  }

  void incorrect(){
    isFirstTry = false;

    showCustomDialogEmoji(
      context,
      "Incorrect!",
      "❌❌❌",
      [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Retry 🥲",
            style: TextStyle(
              color: Color(0xFF0C2D57),
              fontSize: 36,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800,
            )
          ),
        ),
      ],
    );
  }
  
  void checkAnswer(){
    if(widget.question.correctAnswer == input){
      correct();
    } else{
      incorrect();
    }
  }

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
                    backTextMenuBar(leaveQuiz, "Lesson 1 Exercises"),
                    boxText(widget.question.question),
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