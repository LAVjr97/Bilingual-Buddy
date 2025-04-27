import 'dart:collection';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'student_info.dart';

const String STUDENTID_COLLECTION_REF = "studentID";

/*

class DataBase {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference<Student> _studentIDRef;

  DataBase(){
    _studentIDRef = _firestore.collection(STUDENTID_COLLECTION_REF).withConverter<Student>(
      fromFirestore: (snapshots, _) => Student.fromJson(snapshots.data()!,), 
      toFirestore: (Student, _) => Student.toJson());
  }

  Stream<QuerySnapshot> getStudentID(){

    return _studentIDRef.snapshots();
  }

  // Stream to get all student documents
  Stream<QuerySnapshot<Student>> getStudentIDs() {
    return _studentIDRef.snapshots();
  }

  // Get a specific student's document by UID
  DocumentReference<Student> getStudentDocument(String uid) {
    return _studentIDRef.doc(uid).withConverter<Student>(
      fromFirestore: (snapshots, _) => Student.fromJson(snapshots.data()!),
      toFirestore: (student, _) => student.toJson(),
    );
  }

    // Get a nested collection within a student's document
  CollectionReference getNestedCollection(String uid, String nestedCollectionName) {
    return _studentIDRef.doc(uid).collection(nestedCollectionName);
  }

  // Add a new student document
  Future<void> addStudent(String uid, Student student) async {
    await _studentIDRef.doc(uid).set(student);
  }

  // Update a specific field in a student's document
  Future<void> updateStudentField(String uid, Map<String, dynamic> data) async {
    await _studentIDRef.doc(uid).update(data);
  }

  // Add a document to a nested collection
  Future<void> addToNestedCollection(String uid, String nestedCollectionName, Map<String, dynamic> data) async {
    await _studentIDRef.doc(uid).collection(nestedCollectionName).add(data);
  }

  Future<Student?> getStudentByUID(String uid) async {
    try {
      // Reference the specific document using the UID
      DocumentReference studentDocRef = FirebaseFirestore.instance
          .collection('studentID')
          .doc(uid);

      // Fetch the document snapshot
      DocumentSnapshot studentDoc = await studentDocRef.get();

      // Check if the document exists
      if (studentDoc.exists) {
        // Convert the document data to a Student object
        Map<String, dynamic> data = studentDoc.data() as Map<String, dynamic>;
        return Student.fromFirebase(data);
      } else {
        // Document does not exist
        print("No student found with UID: $uid");
        return null;
      }
    } catch (e) {
      // Handle errors
      print("Error fetching student: $e");
      return null;
    }
  }
} */