// File: profile_page.dart

import 'package:flutter/material.dart';
import 'student_info.dart';
import 'globals.dart';

class ProfilePage extends StatelessWidget {
  final Student student; // Passes the student object to the profile page

  const ProfilePage({required this.student, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Compute overall progress for each section (0.0–1.0)
    final fractionList = student.quizCompletion.fractionQuizzes;
    final decimalList  = student.quizCompletion.decimalQuizzes;

    final fractionSum = fractionList.fold<double>(
      0.0,
      (sum, q) => sum + q.percentCompleted,
    );
    final decimalSum = decimalList.fold<double>(
      0.0,
      (sum, q) => sum + q.percentCompleted,
    );

    final fractionOverall =
        fractionList.isNotEmpty ? (fractionSum / fractionList.length) / 100.0 : 0.0;
    final decimalOverall =
        decimalList.isNotEmpty ? (decimalSum / decimalList.length) / 100.0 : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('${student.info.firstName} ${student.info.lastName}'),
        backgroundColor: textColor,
        foregroundColor: buttonColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Fractions Section Header
          Text(
            "Fractions Progress",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Container(
              decoration: BoxDecoration(
                border: Border.all(color: textColor, width: 2),    // outline color & width
                borderRadius: BorderRadius.circular(8),               // rounded corners on the outline
              ),
              padding: const EdgeInsets.all(2),                       // space between border and bar
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),               // match inner rounding
                child: LinearProgressIndicator(
                  value: fractionOverall,
                  minHeight: 12,
                  backgroundColor: buttonColor.withOpacity(0.2),
                  color: Colors.green,
                ),
              ),
            ),

          const SizedBox(height: 16),
          // Fractions Quiz List
          ...List.generate(fractionList.length, (index) {
            final quiz = fractionList[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
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
                  "${quiz.percentCompleted.toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: quiz.percentCompleted == 100.0
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 32),

          // Decimals Section Header
          Text(
            "Decimals Progress",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: textColor, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: decimalOverall,
                minHeight: 12,
                backgroundColor: buttonColor.withOpacity(0.2),
                color: Colors.green,
              ),
            ),
          ),

          const SizedBox(height: 16),
          // Decimals Quiz List
          ...List.generate(decimalList.length, (index) {
            final quiz = decimalList[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
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
                  "${quiz.percentCompleted.toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: quiz.percentCompleted == 100.0
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
