import 'package:firebase_core/firebase_core.dart';

//Individual student information will be stored here, we can create classes to add more informtaion to each student

class Student{
  final StudentInfo info;
  final QuizCompletion quizCompletion; 

  Student({required this.info, required this.quizCompletion});

  factory Student.fromFirebase(Map<String, dynamic> data) {
    return Student(
      info: StudentInfo(
        data['studentId'],
        data['firstName'],
        data['lastName'],
      ),
      quizCompletion: QuizCompletion(
        List<int>.from(data['completedQuizzes'] ?? []),
      ),
    );
  }

}

class StudentInfo {
  final int studentId;
  final String firstName;
  final String lastName;

  //Constructor
  StudentInfo(this.studentId, this.firstName, this.lastName);
}

class QuizCompletion {
  List<int> completedQuizzes;

  QuizCompletion(this.completedQuizzes,);
}


