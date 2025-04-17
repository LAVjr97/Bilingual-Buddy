import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Call this right after the user finishes a quiz
Future<void> saveQuizResult({
  required String quizName,
  required int correctAnswers,
  required int totalQuestions,
}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final percent = ((correctAnswers / totalQuestions) * 100).round();

  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('quizzes')
      .add({
    'quizName': quizName,
    'score': percent,
    'completedAt': FieldValue.serverTimestamp(),
  });
}
