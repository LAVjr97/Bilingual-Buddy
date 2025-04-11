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
        List<bool>.from(data['completedQuizzes'] ?? []),
      ),
    );
  }

  // Student.fromJson(Map<String, Object?> json)
  //   : this(
  //     info: StudentInfo(json['studentId']! as int, json['firstName']! as String, json['lastName']! as String),
  //     quizCompletion: QuizCompletion(List<bool>.from(json['completedQuizzes'] as List<dynamic>))
  //   );

  factory Student.fromJson(Map<String, Object?> json) {
    return Student(
      info: StudentInfo(
        json['studentID'] as int,
        json['firstName'] as String,
        json['lastName'] as String,
      ),
      quizCompletion: QuizCompletion(
        List<bool>.from(json['completedQuizzes'] as List<dynamic>),
      ),
    );
  }


  Map<String, Object?> toJson(){
    return{
      "completedQuizzes": [false, false, false], //Will be <"completedQuizzes": quizCompletion.completedQuizzes,> eventually
      "studentID": info.studentId,
      "firstName": info.firstName,
      "lastName": info.lastName,
    };
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
  List<bool> completedQuizzes;

  QuizCompletion(this.completedQuizzes,);
}


