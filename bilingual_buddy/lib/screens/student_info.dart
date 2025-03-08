//Individual student information will be stored here, we can create classes to add more informtaion to each student

class Student{
  final StudentInfo info;
  final QuizCompletion quizCompletion; 

  Student(this.info, this.quizCompletion);
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


