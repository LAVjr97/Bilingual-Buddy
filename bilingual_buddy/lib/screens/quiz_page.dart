import 'package:flutter/material.dart';
import 'useful_widgets.dart';
import 'lessons_page.dart';

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
  bool correctAnswer;

  //Constructor
  TF(super.question, this.correctAnswer);
}

//"super" keyword calls the constructor of the parent class, which is "Question" and initilizes the question 
//string with whatever super.question is given, classes are pretty similar to how it works in cpp.

//Actual screen stuff
class QuestionsPage extends StatefulWidget{
  List<Question> listOfQuestions = [MCQ("What is your age?", ["21", "22", "24", "25"], 2), ]; //Add the bullshit questions here, use the constructor of MCQ or TF to add questions

  @override
  _QuestionsPage createState() => _QuestionsPage();
}


class _QuestionsPage extends State<QuestionsPage>{

  int currentQIndex = 0;

  void nextQuestion(){
    if(currentQIndex < widget.listOfQuestions.length - 1){
      setState(() {currentQIndex++;} ); //Set state rebuilds the widget (so like a refresh, updating whater variable we're changing here), increasing currentQIndex
    }
    else{

      //Page that will appear once the quiz is done

    }

  }

  @override
  Widget build(BuildContext context){
    Question currentQuestion = widget.listOfQuestions[currentQIndex]; 

    if(currentQuestion is MCQ){
      return MCQPage(question: currentQuestion, onNext: nextQuestion);
    }
    else {
      return Row(); //Replace this with whatever the 
    }
  }
}

class MCQPage extends StatefulWidget {
  final MCQ question;
  final VoidCallback onNext;

  const MCQPage({required this.question, required this.onNext, Key? key}) : super(key: key);

  @override
  _MCQPage createState() => _MCQPage();
}

class _MCQPage extends State<MCQPage>{

  void fractionQuizzes(){
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => FractionsQuizzes()));  
  }

  void temp(){
    return;
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
                    backTextMenuBar(widget.onNext, "Lesson 1 Exercises"),
                    buttonText(widget.question.answers[0], temp, x: 0.85, y: -0.35, width: 351, height: 156, fontSize: 48),
                    buttonText(widget.question.answers[1], temp, x: 0.85, y: 0.25, width: 351, height: 156, fontSize: 48),
                    buttonText(widget.question.answers[2], temp, x: 0.85, y: 0.85, width: 351, height: 156, fontSize: 48),
                    Align(
                      alignment: Alignment(-0.85, 0.85),
                      
                      child: Container(
                        width: 733,
                        height: 614,
                        decoration: ShapeDecoration(
                          color: Color(0xFFFFCFB3),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(84),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment(0.0, 0.0),
                          child: Text(
                            widget.question.question, 
                            style: TextStyle(
                              color: Color(0xFF0C2D57),
                              fontSize: 64,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        )

                      ),
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