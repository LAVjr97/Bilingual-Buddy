import 'package:flutter/material.dart';
import 'useful_widgets.dart';
import 'lessons_page.dart';
import 'dart:developer';
import 'dart:math' hide log;
import 'quiz_hint.dart';
import 'package:confetti/confetti.dart';
import 'globals.dart';

//Different colors for each type of question
Color getQuestionColor(Question question) {
  if (question is MCQ) return mcqQuestionColor;
  if (question is TF) return tfQuestionColor;
  if (question is TXT) return txtQuestionColor;
  return textBackgroundColor;
}

TextStyle getQuestionTextStyle(Question question) {
  if (question is MCQ) return mcqTextStyle;
  if (question is TF) return tfTextStyle;
  if (question is TXT) return txtTextStyle;
  return TextStyle(fontSize: 24, color: textColor);
}


class Question{
  String question;
  String hint;
  
  //Constructor
  Question(this.question, this.hint);
}

class MCQ extends Question{ //MCQ class
  List<String> answers;
  int correctAnswer;

  //Constructor
  MCQ(super.question, this.answers, this.correctAnswer, super.hint);
}

class TF extends Question{ //True or False class
  List<String> answers;
  int correctAnswer;

  //Constructor
  TF(super.question, this.answers, this.correctAnswer, super.hint);
}

class TXT extends Question{
  //List<String> emojis;
  String correctAnswer;

  //TXT(super.question, this.emojis, this.correctAnswer, super.hint);
  TXT(super.question, this.correctAnswer, super.hint);
}

class MATCH_TILES extends Question{
  List<String> buttonText; //MATCH_TILES("<Question>", ["One-Fifth", "1/5", "Two-Thirds", "2/3"], "<Pregunta>"), where buttonText is the pairs of buttons that will be shown on the screen, which should be 8

  MATCH_TILES(super.question, this.buttonText, super.hint);
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
            quizNumber: widget.lessonNum,
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
    } else if(currentQuestion is TF){
      return TFPage(
        question: currentQuestion,
        onNext: nextQuestion,
        onFirstTryCorrect: (){
          setState(() {
            firstTryCorrectAnswers++;
          });
        },
        lessonNum: widget.lessonNum
      );
    } else if(currentQuestion is TXT){
      return TXTPage(
        question: currentQuestion, 
        onNext: nextQuestion, 
        onFirstTryCorrect: (){
          setState(() {
            firstTryCorrectAnswers++;
          });
        },
        lessonNum: widget.lessonNum
      );
    } else if(currentQuestion is MATCH_TILES){
      return MATCH_TILESPage(
        question: currentQuestion, 
        onNext: nextQuestion, 
        onFirstTryCorrect: (){
          setState(() {
            firstTryCorrectAnswers++;
          });
        },
        lessonNum: widget.lessonNum
      );
    } else {
      return Scaffold(
        body: Center(
        child: Text('Error'),
      ),
    );
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
   Widget mcqAnswerButton(String text, VoidCallback onPressed, {double? x, double? y}) {
    return buttonText(
      text,
      onPressed,
      x: x,
      y: y,
      backColor: mcqButtonColor, // <- make sure this is defined in globals.dart
      fontSize: 48,
    );
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
                decoration: BoxDecoration(color: backgroundColor),
                child: Stack(
                  children: [
                    backTextMenuBar(context, leaveQuiz, "Lesson ${widget.lessonNum} Exercises"),
                    buttonText(shuffledAnswers[0], () => checkAnswer(0), x: 0.85, y: -0.025, width: 400, height: 156, fontSize: 48, backColor: tfButtonColor),
                    buttonText(shuffledAnswers[1], () => checkAnswer(1), x: 0.85, y: 0.575, width: 400, height: 156, fontSize: 48, backColor: tfButtonColor),
                    FlipCardQuizCard(question: widget.question),
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
                decoration: BoxDecoration(color: backgroundColor),
                child: Stack(
                  children: [
                    backTextMenuBar(context, leaveQuiz, "Lesson ${widget.lessonNum} Exercises"),
                    buttonText(shuffledAnswers[0], () => checkAnswer(0), x: 0.85, y: -0.35, width: 400, height: 156, fontSize: 48, backColor: mcqButtonColor),
                    buttonText(shuffledAnswers[1], () => checkAnswer(1), x: 0.85, y: 0.25, width: 400, height: 156, fontSize: 48, backColor: mcqButtonColor),
                    buttonText(shuffledAnswers[2], () => checkAnswer(2), x: 0.85, y: 0.85, width: 400, height: 156, fontSize: 48, backColor: mcqButtonColor),
                    FlipCardQuizCard(question: widget.question),
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

// In quiz_page.dart, find the ResultsPage and replace with:

class ResultsPage extends StatefulWidget {
  final int correctAnswers;
  final int totalQuestions;
  final int quizNumber;

  const ResultsPage({
    required this.correctAnswers,
    required this.totalQuestions,
    required this.quizNumber,
    Key? key,
  }) : super(key: key);

  @override
  _ResultsPage createState() => _ResultsPage();
}

class _ResultsPage extends State<ResultsPage> {
  late ConfettiController _rightConfettiController;
  late ConfettiController _leftConfettiController;

  @override
  void initState() {
    super.initState();
    _rightConfettiController = ConfettiController(duration: const Duration(seconds: 3));
    _leftConfettiController  = ConfettiController(duration: const Duration(seconds: 3));

    // **NEW**: write back into fractionQuizzes
    var record = currentStudent.quizCompletion.fractionQuizzes[widget.quizNumber - 1];
    if (widget.correctAnswers > record.correctAnswers) {
      record.correctAnswers = widget.correctAnswers;
      record.calculatePercent();
    }

    // play confetti if perfect
    if (widget.correctAnswers == widget.totalQuestions) {
      _rightConfettiController.play();
      _leftConfettiController.play();
    }
  }

  @override
  void dispose() {
    _rightConfettiController.dispose();
    _leftConfettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String text;
    if (widget.correctAnswers >= 1) {
      if (widget.correctAnswers == widget.totalQuestions) {
        text = "You got ALL ${widget.totalQuestions} questions correct on your first try!";
      } else {
        text = "You got ${widget.correctAnswers} of ${widget.totalQuestions} correct on your first try!";
      }
    } else {
      text = "You got none correct on your first try.";
    }

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
                    boxText(text, x: 0.0, y: -0.2, width: 733, height: 450, fontSize: 80),
                    buttonText("Back to Quizzes", () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => FractionsQuizzes()),
                      );
                    }, x: 0.0, y: 0.75, width: 350, height: 90, fontSize: 40),
                    Align(
                      alignment: Alignment(0.9, -0.95),
                      child: ConfettiWidget(
                        confettiController: _leftConfettiController,
                        blastDirection: pi / 2,
                        blastDirectionality: BlastDirectionality.directional,
                        shouldLoop: false,
                        maxBlastForce: 20,
                        minBlastForce: 5,
                        emissionFrequency: 0.05,
                        numberOfParticles: 15,
                        gravity: 0.3,
                      ),
                    ),
                    Align(
                      alignment: Alignment(-0.9, -0.95),
                      child: ConfettiWidget(
                        confettiController: _rightConfettiController,
                        blastDirection: pi / 2,
                        blastDirectionality: BlastDirectionality.directional,
                        shouldLoop: false,
                        maxBlastForce: 20,
                        minBlastForce: 5,
                        emissionFrequency: 0.05,
                        numberOfParticles: 15,
                        gravity: 0.3,
                      ),
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


class TXTPage extends StatefulWidget {
  final int lessonNum;
  final TXT question;
  final VoidCallback onNext;
  final VoidCallback onFirstTryCorrect;

  const TXTPage({required this.question, required this.onNext, required this.onFirstTryCorrect, required this.lessonNum, Key? key}) : super(key: key);

  @override
  _TXTPage createState() => _TXTPage();
}

class _TXTPage extends State<TXTPage> {
  bool isFirstTry = true;
  late TextEditingController input = TextEditingController();

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
  //normalize the strings so they're both lowercase
  String normalizedCorrectAnswer = widget.question.correctAnswer.toLowerCase().trim();
  String normalizedInput = input.text.toLowerCase().trim();

  //replave "-" with spaces in both strings
  normalizedCorrectAnswer = normalizedCorrectAnswer.replaceAll('-', ' ');
  normalizedInput = normalizedInput.replaceAll('-', ' ');

  //replace spaces with nothing in both strings
  normalizedCorrectAnswer = normalizedCorrectAnswer.replaceAll(' ', '');
  normalizedInput = normalizedInput.replaceAll(' ', '');

  //log("$normalizedCorrectAnswer and $normalizedInput");
  
  if(normalizedCorrectAnswer == normalizedInput){
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
                decoration: BoxDecoration(color: backgroundColor),
                child: Stack(
                  children: [

                    backTextMenuBar(context, leaveQuiz, "Lesson 1 Exercises"),
                    boxText(widget.question.question, 
                    x: 0.0, 
                    y: -0.05, 
                    width: 1133, 
                    height: 412,
                    backColor: txtQuestionColor),
                    boxInput(input, "Type Answer", x: -0.7, y: 0.85, width: 784, height: 100, fontSize: 48, backColor: txtQuestionColor),
                    buttonText("Submit", checkAnswer, x: 0.75, y: 0.85, width: 250, height: 100, fontSize: 48)

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

class matchButton {
  final int pairID;
  final String text;
  bool matched;

  matchButton({required this.pairID, required this.text, this.matched = false});
}

class MATCH_TILESPage extends StatefulWidget{
  final int lessonNum;
  final MATCH_TILES question;
  final VoidCallback onNext;
  final VoidCallback onFirstTryCorrect;

  MATCH_TILESPage({required this.question, required this.onNext, required this.onFirstTryCorrect, required this.lessonNum, Key? key}) : super(key: key);

  @override
  _MATCH_TILESPage createState() => _MATCH_TILESPage();
}

class _MATCH_TILESPage extends State<MATCH_TILESPage>{
  late List<matchButton> buttons;
  int? firstSelectedIndex;
  Set<int> incorrectIndexes = {};
  bool isFirstTry = true;


  @override
  void initState() {
    super.initState();
    buttons = generateShuffledButtons(widget.question.buttonText.length);
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

  List<matchButton> generateShuffledButtons(int numberOfPairs) {
    List<matchButton> buttons = [];

    for (int i = 0; i < widget.question.buttonText.length; i++) {
      buttons.add(matchButton(pairID: i ~/ 2, text: widget.question.buttonText[i]));
    }

    buttons.shuffle();
    return buttons;
  }

  void handleButtonTap(int index){
    if(buttons[index].matched || incorrectIndexes.contains(index)) return;

    setState(() {
      if(incorrectIndexes.isNotEmpty){ //If the answer is incorrect
        incorrectIndexes.clear();
      }

      if(firstSelectedIndex == null){ //First tile clicked on
        firstSelectedIndex = index;
      } else {
        final first = buttons[firstSelectedIndex!];
        final second = buttons[index];

        if(first.pairID == second.pairID && firstSelectedIndex != index) { //Match
          buttons[firstSelectedIndex!].matched = true;
          buttons[index].matched = true;
        } else { //Mismatch, buttons turn red
          isFirstTry = false;
          incorrectIndexes.add(firstSelectedIndex!);
          incorrectIndexes.add(index);
        }

        //Reset clicked button
        firstSelectedIndex = null;
      }

      if(buttons.every((btn) => btn.matched)){
        completed();
      }

    });
  }

  void completed(){
    if(isFirstTry){
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
                    backTextMenuBar(context, fractionQuizzes, "Fraction Quizzes"),
                     Align(
                      alignment: Alignment(0.0, 0.6),
                      child: SizedBox(
                        width: 900,
                        height: 500,
                        child: GridView.count(
                          crossAxisCount: 4,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          padding: const EdgeInsets.all(12),
                          children: List.generate(buttons.length, (index) {
                            final button = buttons[index];    
                            final bool isMatched = button.matched;
                            final bool isIncorrect = incorrectIndexes.contains(index);
                            final bool isSelected = firstSelectedIndex == index;                            
                            
                            Color bgColor;
                            if(isMatched){
                              bgColor = Colors.green;
                            } else if(isIncorrect){
                              bgColor = Colors.red;
                            } else if(isSelected){
                              bgColor = Colors.orange; 
                            } else {
                              bgColor = Color(0xFFFFF5CD);
                            }

                            return ElevatedButton(
                              onPressed: () => handleButtonTap(index),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: bgColor,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1),
                                  borderRadius: BorderRadius.circular(84),
                                ),
                              ),
                              child: Text(
                                buttons[index].text,
                                style: const TextStyle(
                                  color: Color(0xFF0C2D57),
                                  fontSize: 24,
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                            );
                          })
                        )
                      )
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