import 'package:flutter/material.dart';
import 'useful_widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:developer';
import 'dart:math' hide log;
import 'lessons_page.dart';
import 'globals.dart';

class Flashcards {
  String frontSide;
  String backSide;

  Flashcards(this.frontSide, this.backSide);
}

class FlashcardViewer extends StatefulWidget {
  late List<Flashcards> flashcards = [Flashcards("Un Cuarto", "One-fourth\n1/4"), Flashcards("Dos-Novenos", "Two-Ninths\n2/9"), Flashcards("Tres-Cuartos", "Three-fourths\n3/4"), Flashcards("Cinco-Sextos", "Five-Sixths\n5/6"), Flashcards("Siete-Octavos", "Seven-Eighths\n7/8")];
  final int lessonNum;

  FlashcardViewer({required this.flashcards, required this.lessonNum, Key? key}) : super(key: key);

  @override
  _FlashcardViewerState createState() => _FlashcardViewerState();
}
 
class _FlashcardViewerState extends State<FlashcardViewer>{
  int _currentIndex = 0;

  PageController _pageController = PageController(viewportFraction: 0.9);
  @override
  void initState() {
    super.initState();
    widget.flashcards.shuffle(Random()); // Shuffle the list of questions
  }

  void fractionsLecture() async{
        Navigator.pushReplacement( 
      context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => FractionsFlashCards(), 
        transitionsBuilder: (context,  animation, secondaryAnimation, child) {
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
      )
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
                decoration: BoxDecoration(color: backgroundColor),
                child: Stack(
                  children: [
                    backTextMenuBar(context, fractionsLecture, "Lesson ${widget.lessonNum} Flashcards"),
                    Align(
                      alignment: Alignment(0.0, 0.5),
                      child: SizedBox(//Size for PageView 
                        width: 933, 
                        height: 550, 
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index; //Update the current index
                            });
                          },
                          itemCount: widget.flashcards.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 55.0),
                              child: FlipCard(
                                key: GlobalKey<FlipCardState>(),
                                direction: FlipDirection.VERTICAL, // Up/Down Swipe to Flip
                                front: FlashcardWidget(
                                  flashcard: widget.flashcards[index], // Front side
                                  fontColor: Color(0xFF0C2D57),
                                  color: Color(0xFFFFF5CD), // White side
                                  borderColor: Colors.black,
                                ),
                                back: FlashcardWidget(
                                  flashcard: widget.flashcards[index], // Back side
                                  fontColor: Color(0xFFFFF5CD),
                                  color: Color(0xFF0C2D57), // Blue side
                                  borderColor: Colors.transparent,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )
              )
            )
          ]
        )
      )
    );
  }
}

class FlashcardWidget extends StatelessWidget {
  final Flashcards flashcard;
  final Color fontColor;
  final Color color;
  final Color borderColor;

  FlashcardWidget({required this.flashcard, required this.fontColor, required this.color, required this.borderColor});

  String text(){
    if(color.value == 0xFF0C2D57){
      return flashcard.backSide;
    } else { 
      return flashcard.frontSide;
    }
  }

  String audioFileName(){
    return "lesson1_${flashcard.frontSide}.mp3";
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 933,
          height: 550,
          decoration: ShapeDecoration(
            color: color,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: borderColor),
              borderRadius: BorderRadius.circular(84),
            ),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(16),
          child: Text(
            text(),
            style: TextStyle(
              color: fontColor,
              fontSize: 100, 
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        if(color.value == 0xFF0C2D57)
          Positioned(
            bottom: 50,
            right: 50,
            child: ElevatedButton( 
              onPressed: () async{
                try {
                  final AudioPlayer audioPlayer = AudioPlayer();
                  audioPlayer.setVolume(1.0);
                  await audioPlayer.play(AssetSource('flashcards/sounds/lesson1_${flashcard.frontSide}.mp3'));
                } catch (e) {
                  log("Error playing audio: $e"); 
                }
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(16),
                backgroundColor: Colors.blue, // Button color
              ),
              child: Icon(
                Icons.hearing, // Icon inside button
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
      ]
    );
  }
}
