import 'package:flutter/material.dart';
import 'student_info.dart';
import 'globals.dart';

class ProfilePage extends StatelessWidget {
  final Student student; //Passes the student object to the profile page

const ProfilePage({required this.student, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${student.info.firstName} ${student.info.lastName}'),
        // title: Text('${student.info.firstName} ${student.info.lastName}'),
        backgroundColor: textColor,
        foregroundColor: buttonColor,
        // title: const Text('Profile'),
      ),
      body: Container(
        // crossAxisAlignment: CrossAxisAlignment.start,
        color: backgroundColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Welcome, ${student.info.firstName} ${student.info.lastName}!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Your Quiz Progress:",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
            SizedBox(height: 10),

            //Quiz Progress
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: student.quizCompletion.completedQuizzes.length,
                  itemBuilder: (context, index){
                    final quizCompleted = student.quizCompletion.completedQuizzes[index];
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          "Quiz ${index + 1}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),  
                        trailing: Text(
                          (quizCompleted.percentCompleted == 100.0) ? "Completed": "Incomplete",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: (quizCompleted.percentCompleted == 100.0) ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),  
            ],
          ),
        ),
      ),
    );
  }
}