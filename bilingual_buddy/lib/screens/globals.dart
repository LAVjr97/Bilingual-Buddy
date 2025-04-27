import 'student_info.dart';

late Map<String, Student> students;
late Student currentStudent;

void createStudentMap(){
  students = {
    '0RXs9OMJD0QaqgTUduZrgWhbtp82': Student(info: StudentInfo(1, "Bucky", "Bronco"), quizCompletion: Completion([QuizCompletion(0, 4), QuizCompletion(0, 4), QuizCompletion(0, 4), QuizCompletion(0, 4), QuizCompletion(0, 1), QuizCompletion(0, 1)], [0.0]))
  };
}
