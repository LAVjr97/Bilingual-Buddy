import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashboardScreen>{

  void fractionsPage() async{
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

                    Align( //Waving emoji
                      alignment: Alignment(-0.85, -0.85),
                      child: SizedBox(
                        width: 180,
                        height: 190,
                        child: Text(
                          '👋',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 150,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),

                    Align( //Widget that holds the two "buttons" for fraction and deciaml
                      alignment: Alignment(0.0, 0.0),
                      child: Stack( //Maybe change this to row
                        children: [
                          Align( //Fractions button
                            alignment: Alignment(0.0, 0.0),
                            child: SizedBox(
                              width: 536.48,
                              height: 385,
                              child: ElevatedButton(
                                onPressed: fractionsPage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFFF5CD),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1),
                                    borderRadius: BorderRadius.circular(84),
                                  ),
                                ),

                                child: Column( //Text that will go inside of the button
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align( //Divison Symbol
                                      alignment: Alignment(0.0, 0.0),
                                      child: SizedBox(
                                        width: 187,
                                        height: 188,
                                        child: Text(
                                          '➗',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 180,
                                            fontFamily: 'Outfit',
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),

                                    Align( //Fraction text
                                      alignment: Alignment(0.5, 0.0),
                                      child: SizedBox(
                                        width: 418,
                                        height: 195,
                                        child: Text(
                                          '➗Fraction',
                                          style: TextStyle(
                                            color: Color(0xFF0C2D57),
                                            fontSize: 75,
                                            fontFamily: 'Outfit',
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    )
                                  ]
                                )
                              )

                            ),
                          ),

                        ],
                      )
                    ),

                    
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
