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
                    // Screen borders for the background color
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: backgroundColor),
                    child: Stack(
                      children: [
                        Align(
                          // Logo
                          alignment: Alignment(0.0, -0.65),
                          child: Image.asset(
                            'lib/assets/images/landing_page_logo.png',
                            width: 326,
                            height: 329,
                          ),
                        ),
                        Align(
                          // Middle line of text
                          alignment: Alignment(0.0, 0.2),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 735,
                                height: 130,
                                child: Text(
                                  'BILINGUAL BUDDY',
                                  style: GoogleFonts.sniglet(
                                    color: textColor,
                                    fontSize: 96,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          // Start Button
                          alignment: Alignment(0.0, 0.65),
                          child: SizedBox(
                            width: 473,
                            height: 136.50,
                            child: ElevatedButton(
                              onPressed: loginPage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1),
                                  borderRadius: BorderRadius.circular(84),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment(0.0, -0.5),
                                child: SizedBox(
                                  width: 290,
                                  height: 90,
                                  child: Align(
                                    alignment: Alignment(0.0, 2.0),
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
        ChatAssistant(),
      ],
    );
  }
}
