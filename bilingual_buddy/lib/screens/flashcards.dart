import 'package:flutter/material.dart';
import 'useful_widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'lecture_dashboard.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/src/source.dart';
import 'dart:developer';
import 'dart:math' hide log;



class Flashcards {
  String frontSide;
  String backSide;

  Flashcards(this.frontSide, this.backSide);
}

class FlashcardViewer extends StatefulWidget {
  final List<Flashcards> flashcards = [Flashcards("Un Cuarto", "One-fourth\n1/4"), Flashcards("Dos-Novenos", "Two-Ninths\n2/4"), Flashcards("Tres-Cuartos", "Three-fourths\n3/4"), Flashcards("Cinco-Sextos", "Five-Sixths\n5/6"), Flashcards("Siete-Octavos", "Seven-Eighths\n7/8")];

  //FlashcardViewer({required this.flashcards});

  @override
  _FlashcardViewerState createState() => _FlashcardViewerState();
}
 
class _FlashcardViewerState extends State<FlashcardViewer>{
  int _currentIndex = 0;
  GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();
  double _dragThreshold = 500.0; // Minimum drag distance for swipe detection
  double _startDragX = 0.0;

  @override
  void initState() {
    super.initState();
    widget.flashcards.shuffle(Random()); // Shuffle the list of questions
  }

  void fractionsLecture() async{
        Navigator.pushReplacement( 
      context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => FractionsLecture(), 
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

  void _nextFlashcard() {
    setState(() {
      if (_currentIndex < widget.flashcards.length - 1) {
        _currentIndex++;
        _cardKey = GlobalKey<FlipCardState>(); //Makes sure that the card is set to the "white" side
      }
    });
  }

  void _previousFlashcard() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _cardKey = GlobalKey<FlipCardState>(); //Makes sure that the card is set to the "white" side
      }
    });
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
                    backTextMenuBar(fractionsLecture, "Lesson 1 Exercises"),

                    Align(
                      alignment: Alignment(0.0, 0.5),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              GestureDetector(
                                onHorizontalDragStart: (details) {
                                  _startDragX = details.globalPosition.dx; // Track initial position
                                },
                                onHorizontalDragUpdate: (details) {
                                  double dragDistance = details.globalPosition.dx - _startDragX;

                                  if (dragDistance.abs() > _dragThreshold) {
                                    if (dragDistance < 0) {
                                      _nextFlashcard(); // Swipe left → Next card
                                    } else {
                                      _previousFlashcard(); // Swipe right → Previous card
                                    }
                                    _startDragX = details.globalPosition.dx; // Reset drag position
                                  }
                                },

                                child: FlipCard(
                                  key: _cardKey,
                                  direction: FlipDirection.VERTICAL, // Up/Down Swipe to Flip
                                  front: FlashcardWidget(
                                    flashcard: widget.flashcards[_currentIndex], //frontside
                                    fontColor: Color(0xFF0C2D57),
                                    color: Color(0xFFFFF5CD), //White side
                                    borderColor: Colors.black,
                                  ),
                                  back: FlashcardWidget(
                                    flashcard: widget.flashcards[_currentIndex], //backside
                                    fontColor: Color(0xFFFFF5CD),
                                    color: Color(0xFF0C2D57), //Blue Side
                                    borderColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
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

            child: ElevatedButton( //Change this eventually so that 
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
                Icons.volume_up, // Icon inside button
                color: Colors.white,
                size: 24,
              ),
            ),
          
          ),
        
          // Align(
          //   alignment: Alignment(0.0, 0.0),
          //   child: ElevatedButton(
          //     onPressed: () async{
          //       final AudioPlayer audioPlayer = AudioPlayer();
          //       audioPlayer.play(AssetSource('lib/assets/flashcards/sounds/lesson1_Cinco-Sextos.mp3'));//${flashcard.frontSide}.mp3')); // Play the sound
          //     },
          //     style: ElevatedButton.styleFrom(
          //       shape: CircleBorder(),
          //       padding: EdgeInsets.all(16),
          //       backgroundColor: Colors.blue, // Button color
          //     ),
          //     child: Icon(
          //       Icons.volume_up, // Icon inside button
          //       color: Colors.white,
          //       size: 24,
          //     ),
          //   ),
          // ),
      ]
    );
  }
}
