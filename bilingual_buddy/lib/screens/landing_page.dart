import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'globals.dart';
import 'chat_assistant.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPage createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  void loginPage() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset:
          false, // makes sure that the keyboard popping up from the bottom doesn't mess with the size of the page
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: backgroundColor,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment(0.0, -0.65),
                          child: Image.asset(
                            'assets/images/landing_page_logo.png',
                            width: 326,
                            height: 329,
                            errorBuilder: (context, error, stackTrace) {
                              return Text(
                                'Image failed to load',
                                style: TextStyle(color: Colors.red),
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment(0.0, 0.2),
                          child: Text(
                            'BILINGUAL BUDDY',
                            style: GoogleFonts.sniglet(
                              color: textColor,
                              fontSize: 96,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment(0.0, 0.65),
                          child: ElevatedButton(
                            onPressed: loginPage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(84),
                              ),
                              fixedSize: const Size(473, 136.5),
                            ),
                            child: Text(
                              "START",
                              style: GoogleFonts.sniglet(
                                color: textColor,
                                fontSize: 80,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Floating Chat Assistant
        //ChatAssistant(),
      ],
    );
  }
}
