import 'package:flutter/material.dart';
import 'student_info.dart';

//STUDENT DATA
late Map<String, Student> students;
late Student currentStudent;
// In global.dart

void createStudentMap() {
  students = {
    '0RXs9OMJD0QaqgTUduZrgWhbtp82': Student(
      info: StudentInfo(1, 'Bucky', 'Bronco'),
      quizCompletion: Completion(
        // Six fraction quizzes (match your original totalQuestions per quiz)
        fractionQuizzes: [
          QuizCompletion(0, 4),
          QuizCompletion(0, 4),
          QuizCompletion(0, 4),
          QuizCompletion(0, 4),
          QuizCompletion(0, 1),
          QuizCompletion(0, 1),
        ],
        // Six decimal quizzes (adjust totalQuestions to match your decimal sets)
        decimalQuizzes: [
          QuizCompletion(0, 4),
          QuizCompletion(0, 4),
          QuizCompletion(0, 4),
          QuizCompletion(0, 4),
          QuizCompletion(0, 4),
          QuizCompletion(0, 1),
        ],
        // If you still want to track flashcards, otherwise you can omit this
        completedFlashCards: [0.0],
      ),
    ),
    'r877zLHljvd8BpxDwZjeZ3sghMj1': Student(
      info: StudentInfo(1, 'Bucky', 'Bronco'),
      quizCompletion: Completion(
        // Six fraction quizzes (match your original totalQuestions per quiz)
        fractionQuizzes: [
          QuizCompletion(0, 4),
          QuizCompletion(0, 4),
          QuizCompletion(0, 4),
          QuizCompletion(0, 4),
          QuizCompletion(0, 1),
          QuizCompletion(0, 1),
        ],
        // Six decimal quizzes (adjust totalQuestions to match your decimal sets)
        decimalQuizzes: [
          QuizCompletion(0, 4),
          QuizCompletion(0, 4),
          QuizCompletion(0, 4),
          QuizCompletion(0, 4),
          QuizCompletion(0, 4),
          QuizCompletion(0, 1),
        ],
        // If you still want to track flashcards, otherwise you can omit this
        completedFlashCards: [0.0],
      ),
    ),
  };
}


//COLORS
Color textColor = Color(0xD50C2D57);
Color buttonColor = Color(0xFFFFF5CD);
Color backgroundColor = Color(0xFFB7E0FF);
Color backOfFlashcardColor = Color(0xD50C2D57);
Color textBackgroundColor = Color(0xFFFFCFB3);
Color dialogBackgroundColor = Color(0xFFFFF5CD);
Color backTextMenuBarColor = Color(0xD50C2D57);
Color inputTextColor = Color(0xFFECECEC);

void createAppColorPalette(){
  //Color Palette #1
  textColor = Color(0xFF5F8B4C);
  buttonColor = Color(0xFFFFDDAB);
  backgroundColor = Color(0xFFFF9A9A);
  backOfFlashcardColor = Color(0xD50C2D57);
  textBackgroundColor = Color(0xFFFFCFB3);
  dialogBackgroundColor = Color(0xFFF6C6EA);
  backTextMenuBarColor = Color(0xFFEB5B00);
  inputTextColor = Color(0xFFECECEC);


  /*
  Color Palette #2
  textColor = Color(0xD50C2D57);
  buttonColor = Color(0xFFFFF5CD);
  backgroundColor = Color(0xFFB7E0FF);
  backOfFlashcardColor = Color(0xD50C2D57);
  textBackgroundColor = Color(0xFFFFCFB3);
  dialogBackgroundColor = Color(0xFFFFF5CD);
  backTextMenuBarColor = Color(0xD50C2D57);
  */

}
