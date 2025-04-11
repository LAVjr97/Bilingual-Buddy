import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard_screen.dart'; //Send user to dashboard after login
import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';
import 'landing_page.dart';
import 'useful_widgets.dart';
import 'student_info.dart';
import 'dataBase.dart';


void signOut() async {
  await FirebaseAuth.instance.signOut();
}

Future<void> saveUserData(String uid, String email, String username) async {
  await FirebaseFirestore.instance.collection('users').doc(uid).set({
    'email': email,
    'username': username, //I don't think we need a username so I might remove this
    'createdAt': FieldValue.serverTimestamp(),
  });
}

Future<User?> loginUser(String email, String password) async {
  try {
    String usableEmail = email.split('@')[0]; //Makes sure to remove domain from the email if its been added
    String domain = "@temp.com"; //Makes a dummy domain that we need
    usableEmail = '$usableEmail$domain';
    log("Email given: $usableEmail"); 
    
    //Does the actual login
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: usableEmail, password: password);
    
    String uid = "0RXs9OMJD0QaqgTUduZrgWhbtp82";
    DataBase _DataBase = DataBase();
    Student? student = await _DataBase.getStudentByUID(uid); 

    log(student?.info?.firstName ?? "Student info is null");

    if (student != null) {
      print("Student found: ${student.info.firstName} ${student.info.lastName}");
    } else {
      print("Student not found.");
    }
    
    return userCredential.user;

  } catch (e) {
    log("Login Error: $e");
    return null; //Failed login
  }
} 

// Future<Student?> loginUser(String email, String password) async {
//   try {
//     String usableEmail = email.split('@')[0]; //Makes sure to remove domain from the email
//     String domain = "@temp.com"; //Makes a dummy domain that we need
//     usableEmail = '$usableEmail$domain';
//     log("Email given: $usableEmail"); 
    
//     //Does the actual login 
//     UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: usableEmail, password: password);


//     CollectionReference user = FirebaseFirestore.instance.collection("studentID");
//     log(userCredential.user!.uid);
//     DocumentReference userDocRef = user.doc(userCredential.user!.uid);

//     final DocumentSnapshot userDoc = await userDocRef.get(); // Fetch the document snapshot
//     //0RXs9OMJD0QaqgTUduZrgWhbtp82 <-Most recent User UID
//     if (userDoc.exists) {
//       Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>; //Create a Student object from the data
//       Student student = Student.fromFirebase(data);
//       return student; //Successfully logged in
//     } else {
//       log("User document not found!");
//       return null;
//     }

//   } catch (e) {
//     log("Login Error: $e");
//     return null; // Failed login for other reasons
//   }
// } 


Future<User?> registerUser(String email, String password, String username) async {
  try {
    String usableEmail = email.split('@')[0];
    String domain = "@temp.com";
    usableEmail = '$usableEmail$domain';
    log("Email given: $usableEmail"); 

    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: usableEmail, password: password);

    User? user = userCredential.user;
    if (user != null) {
      await saveUserData(user.uid, email, username);
    }
    return user;
  } catch (e) {
    log("Registration Error: $e");
    return null;
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
} 

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async { 
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(email.isEmpty || password.isEmpty){
      showCustomDialog(
        context, 
        "Please enter a Username and Password!", 
        [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Retry",
              style: TextStyle(
                color: Color(0xFF0C2D57),
                fontSize: 36,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w800,
              )
            ),
          ),
        ],
      );
      return;
    }
    
    //Student? student = await loginUser(email, password);
    User? user = await loginUser(email, password);
    //bool user = true;
    
    if (user != null) {
    //if (student != null){
      log("Login successful: ${email}");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    } else {
      log("Login failed");
      emailController.clear();
      passwordController.clear();
      showCustomDialog(
        context, 
        "Incorrect Username or Password!", 
        [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Retry",
              style: TextStyle(
                color: Color(0xFF0C2D57),
                fontSize: 36,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w800,
              )
            ),
          ),
        ],
      );
    }
  }

  void landingPage() {
    Navigator.pushReplacement(
      context,PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => LandingPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //makes sure that the keyboard popping up from the bottom doesn't mess with the size of the page
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container( //Screen borders for the background color
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Color(0xFFB7E0FF)),
                child: Stack(
                  children: [
                    Positioned(
                      left: 253,
                      top: 1076,
                      child: Container(
                        width: 100,
                        height: 100,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                    Align( //Center background
                      alignment: Alignment.center,
                      child: Container(
                        width: 855.58,
                        height: 614,
                        decoration: ShapeDecoration(
                          color: Color(0xFFFFCFB3),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(84),
                          ),
                        ), 
                        child: Stack( //holds widgets inside of a parent widget (which is the orange center widget)
                          children: [
                            Align( //Username input field (using align because its convenient)
                              alignment: Alignment(0.0, -0.65),
                              child: Container(
                                width: 562,
                                height: 91,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFECECEC),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1),
                                    borderRadius: BorderRadius.circular(84),
                                  ),
                                ),

                                child:Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 155), //Horizonal adds padding to the left of the hint text
                                  child: TextField(
                                    controller: emailController,
                                    style: TextStyle(           //Actual input text
                                      color: Color(0xFF0C2D57),
                                      fontSize: 48,
                                      fontFamily: 'Outfit',
                                    ),
                                    decoration: InputDecoration( //"hint" text
                                      border: InputBorder.none,
                                      hintText: 'Username',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF0C2D57),
                                        fontSize: 48,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w400,
                                      )
                                    ),
                                  )
                                ),
                              ),
                            ),

                            Align( //Password input field
                              alignment: Alignment(0.0, -0.1),
                              child: Container(
                                width: 562,
                                height: 91,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFECECEC),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1),
                                    borderRadius: BorderRadius.circular(84),
                                  ),
                                ),
                                child:Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 155), //Horizonal adds padding to the left of the hint text
                                  child: TextField(
                                    controller: passwordController,
                                    style: TextStyle(           //Actual input text
                                      color: Color(0xFF0C2D57),
                                      fontSize: 48,
                                      fontFamily: 'Outfit',
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF0C2D57),
                                        fontSize: 48,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w400,
                                      )
                                    ),
                                    obscureText: true //Makes the password hidden
                                  )
                                ),
                              ),
                            ),

                            Align( //Login button
                              alignment: Alignment(0.0, 0.65),
                              child: SizedBox(
                                width: 557,
                                height: 145.85,
                                child: ElevatedButton(
                                  onPressed: login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFFFF5CD),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 1),
                                      borderRadius: BorderRadius.circular(84),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Log In',
                                      style: GoogleFonts.sniglet( //For using googlefonts, just follow this format, using the GoogleFonts class
                                        color: Color(0xFF0C2D57), 
                                        fontSize: 96,
                                        fontWeight: FontWeight.w800,
                                      ), 
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]
                        )
                      ),
                    ),

                    Align( //Back arrow
                      alignment: Alignment(-0.9, -0.65),
                      child: Transform(
                        transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-1.57),
                        child: CustomArrowButton(
                          onPressed: landingPage,
                        )
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
