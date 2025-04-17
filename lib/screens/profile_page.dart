import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser!;

  Future<Map<String, dynamic>> getUserData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> getQuizData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('quizzes')
        .get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getUserData(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!userSnapshot.hasData || userSnapshot.data == null) {
            return Center(child: Text('User data not found.'));
          }

          Map<String, dynamic> userData = userSnapshot.data!;

          return FutureBuilder<List<Map<String, dynamic>>>(
            future: getQuizData(),
            builder: (context, quizSnapshot) {
              if (quizSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!quizSnapshot.hasData || quizSnapshot.data == null) {
                return Center(child: Text('No quiz data found.'));
              }

              List<Map<String, dynamic>> quizData = quizSnapshot.data!;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User info
                    Text(
                      'Username: ${userData['username'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Email: ${userData['email']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),

                    // Quiz info
                    Text(
                      'Quiz Progress:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    ...quizData.map((quiz) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Quiz: ${quiz['quizName']} - Score: ${quiz['score']}%',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
