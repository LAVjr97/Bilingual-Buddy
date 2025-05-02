import 'package:flutter/material.dart';
import 'student_info.dart';

class ProfilePage extends StatelessWidget {
  final Student student; //Passes the student object to the profile page

const ProfilePage({required this.student, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test123'),
        // title: Text('${student.info.firstName} ${student.info.lastName}'),
        backgroundColor: Color(0xFF0C2D57),
        foregroundColor: Color(0xFFFFCFB3),
        // title: const Text('Profile'),
      ),
      body: Container(
        // crossAxisAlignment: CrossAxisAlignment.start,
        color: const Color(0xFFFFF5CD),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  // "Welcome, ${student.info.firstName} ${student.info.lastName}!",
                  "Welcome, test123!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0C2D57),
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
                color: Color(0xFF0C2D57),
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
                            color: Color(0xFF0C2D57),
                          ),
                        ),  
                        trailing: Text(
                          quizCompleted ? "Completed": "Incomplete",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: quizCompleted ? Colors.green : Colors.red,
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