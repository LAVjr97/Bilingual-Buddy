import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'useful_widgets.dart';
import 'lecture_dashboard.dart';
import 'dec_lecture_dashboard.dart';
import 'globals.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashboardScreen>{

  void fractionsPage() async{
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => FractionsLecture()));  
    return;
  }

  void decimalPage() async{
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => DecimalsLecture()));  
    return;
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
                decoration: BoxDecoration(color: backgroundColor),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(0.893, -0.833),
                      child: menuButton(context),
                    ),

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

                    Align( //Top row of text
                      alignment: Alignment(0.0, -0.9),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 220,
                                height: 190,
                                child: Text(
                                  '👋',
                                  style: GoogleFonts.notoColorEmoji(
                                    color: Colors.black,
                                    fontSize: 150,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 911,
                                height: 130,
                                child: Text(
                                  'Welcome Back!',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 115,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]
                      ),
                    ),
                    
                    Align( //Middle line of text 
                      alignment: Alignment(-0.75, -0.3),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 700,
                            height: 130,
                            child: Text(
                              'Choose your lesson:',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 75,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ]
                      )
                    ),


                    Align( //Widget that holds the two "buttons" for fraction and deciaml
                      alignment: Alignment(0.0, 0.75),
                      child: buttonPairEmojiText('➗', 'Fraction', fractionsPage, '🔢', 'Decimal', decimalPage),
                    )

                    
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
}
