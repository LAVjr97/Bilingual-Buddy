import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/dashboard_screen.dart'; //Send user to dashboard after login
import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';
import 'screens/landing_page.dart';

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
    String usableEmail = email.split('@')[0]; //Makes sure to remove domain from the email
    String domain = "@temp.com"; //Makes a dummy domain that we need
    usableEmail = '$usableEmail$domain';
    log("Email given: $usableEmail"); 
    
    //Does the actual login 
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: usableEmail, password: password);
    
    return userCredential.user; //Successfully logged in
  } catch (e) {
    log("Login Error: $e");
    return null; //Failed login
  }
}

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

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xD50C2D57)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CustomArrowButton extends StatelessWidget {
  final VoidCallback onPressed;

  CustomArrowButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        /*shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),*/
        padding: EdgeInsets.zero,
      ),
      child: CustomPaint(
        size: Size(91, 93),
        painter: ArrowPainter(),
      ),
    );
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
    
    User? user = await loginUser(email, password);
    
    if (user != null) {
      log("Login successful: ${user.email}");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    } else {
      log("Login failed");
      emailController.clear();
      passwordController.clear();
    }
  }

  void landingPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LandingPage()));
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
                    
                    /*Align( //Back arrow
                      alignment: Alignment(-0.85, -0.85),
                      child: Transform(
                        transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(0.52),
                        child: Container(
                          width: 91,
                          height: 93,
                          decoration: ShapeDecoration(
                            color: Color(0xD50C2D57),
                            shape: StarBorder.polygon(sides: 3),
                          ),
                        ),
                      ),
                    ),*/

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
