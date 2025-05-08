
// File: student_info.dart
/// Holds all student data, including quiz completion for fractions and decimals.
class Student {
  final StudentInfo info;
  final Completion quizCompletion;

  Student({ required this.info, required this.quizCompletion });

  // (You may have factory constructors / fromJson here if needed)
}

class StudentInfo {
  final int studentId;
  final String firstName;
  final String lastName;

  StudentInfo(this.studentId, this.firstName, this.lastName);

  factory StudentInfo.fromMap(Map<String, dynamic> data) {
    return StudentInfo(
      data['studentId'] ?? 0,
      data['firstName'] ?? 'Unknown',
      data['lastName'] ?? 'Unknown'
    );
  }
}

/// Tracks completion separately for fraction quizzes and decimal quizzes.
class Completion {
  /// One entry per fraction quiz (e.g. 6 entries for 6 fraction quizzes).
  List<QuizCompletion> fractionQuizzes;

  /// One entry per decimal quiz (e.g. 6 entries for 6 decimal quizzes).
  List<QuizCompletion> decimalQuizzes;

  /// (Optional) track flashcard completion percentages.
  List<double>? completedFlashCards;

  Completion({
    required this.fractionQuizzes,
    required this.decimalQuizzes,
    this.completedFlashCards,
  });

  /// A combined view if you ever need all quizzes together.
  List<QuizCompletion> get completedQuizzes =>
      [...fractionQuizzes, ...decimalQuizzes];

  /// Overall percent across both fractions and decimals.
  double get totalQuizCompletionPercentage {
    final all = completedQuizzes;
    if (all.isEmpty) return 0.0;
    final sum = all.fold<double>(0.0, (prev, q) => prev + q.percentCompleted);
    return sum / all.length;
  }
}

/// Tracks a single quiz’s performance.
class QuizCompletion {
  int correctAnswers;
  int totalQuestions;
  late double percentCompleted;

  QuizCompletion(this.correctAnswers, this.totalQuestions) {
    calculatePercent();
  }

  void calculatePercent() {
    percentCompleted = (correctAnswers / totalQuestions) * 100;
  }
}



// import 'package:firebase_core/firebase_core.dart';

// //Individual student information will be stored here, we can create classes to add more informtaion to each student

// //currentStudent.in

// class Student{
//   final StudentInfo info;
//   final Completion quizCompletion; 

//   Student({required this.info, required this.quizCompletion});

//   // factory Student.fromFirebase(Map<String, dynamic> data) {
//   //   return Student(
//   //     info: StudentInfo(
//   //       data['studentId'],
//   //       data['firstName'],
//   //       data['lastName'],
//   //     ),
//   //     quizCompletion: QuizCompletion(
//   //       List<bool>.from(data['completedQuizzes'] ?? []),
//   //     ),
//   //   );
//   // }

//   // Student.fromJson(Map<String, Object?> json)
//   //   : this(
//   //     info: StudentInfo(json['studentId']! as int, json['firstName']! as String, json['lastName']! as String),
//   //     quizCompletion: QuizCompletion(List<bool>.from(json['completedQuizzes'] as List<dynamic>))
//   //   );

//   // factory Student.fromJson(Map<String, Object?> json) {
//   //   return Student(
//   //     info: StudentInfo(
//   //       json['studentID'] as int,
//   //       json['firstName'] as String,
//   //       json['lastName'] as String,
//   //     ),
//   //     quizCompletion: QuizCompletion(
//   //       List<bool>.from(json['completedQuizzes'] as List<dynamic>),
//   //     ),
//   //   );
//   // }


//   // Map<String, Object?> toJson(){
//   //   return{
//   //     "completedQuizzes": [false, false, false], //Will be <"completedQuizzes": quizCompletion.completedQuizzes,> eventually
//   //     "studentID": info.studentId,
//   //     "firstName": info.firstName,
//   //     "lastName": info.lastName,
//   //   };
//   // }

// }

// class StudentInfo {
//   final int studentId;
//   final String firstName;
//   final String lastName;

//   StudentInfo(this.studentId, this.firstName, this.lastName);
// }

// class Completion {
//   List<QuizCompletion> completedQuizzes;
//   List<double>? completedFlashCards; //Nullable since is still have to figure out how to track flashcard completions, or if i should even track it to begin with
//   late double totalQuizCompletionPercentage;

//   Completion(this.completedQuizzes, this.completedFlashCards);

//   double calculateTotalQuizCompletionPercentage(){
//     for(int i = 0; i < completedQuizzes.length; i++){
//       this.totalQuizCompletionPercentage = this.totalQuizCompletionPercentage + completedQuizzes[i].percentCompleted;
//     }

//     this.totalQuizCompletionPercentage = this.totalQuizCompletionPercentage / completedQuizzes.length;
//     return this.totalQuizCompletionPercentage;
//   }
// }

// class QuizCompletion {
//   int correctAnswers;
//   int totalQuestions;
//   late double percentCompleted;

//   QuizCompletion(this.correctAnswers, this.totalQuestions){
//     calculatePercent();
//   }

//   void calculatePercent(){
//     percentCompleted = (correctAnswers / totalQuestions) * 100;
//   }
// }




