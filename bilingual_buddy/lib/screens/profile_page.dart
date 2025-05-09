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
        title: Text(
          '${student.info.firstName} ${student.info.lastName}',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
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
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: textColor, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(3),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: fractionOverall,
                minHeight: 24,
                backgroundColor: buttonColor.withOpacity(0.2),
                color: Colors.green,
              ),
            ),
          ),

          const SizedBox(height: 24),
          // Fractions Quiz List
          ...List.generate(fractionList.length, (index) {
            final quiz = fractionList[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                title: Text(
                  "Quiz ${index + 1}",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                trailing: Text(
                  "${quiz.percentCompleted.toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: quiz.percentCompleted == 100.0
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 40),

          // Decimals Section Header
          Text(
            "Decimals Progress",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: textColor, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(3),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: decimalOverall,
                minHeight: 24,
                backgroundColor: buttonColor.withOpacity(0.2),
                color: Colors.green,
              ),
            ),
          ),

          const SizedBox(height: 24),
          // Decimals Quiz List
          ...List.generate(decimalList.length, (index) {
            final quiz = decimalList[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                title: Text(
                  "Quiz ${index + 1}",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                trailing: Text(
                  "${quiz.percentCompleted.toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
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
