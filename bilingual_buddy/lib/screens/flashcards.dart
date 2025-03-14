import 'package:flutter/material.dart';
import 'useful_widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'lecture_dashboard.dart';
import 'dart:math';

class Flashcards {
  String frontSide;
  String backSide;

  Flashcards(this.frontSide, this.backSide);
}

class FlashcardViewer extends StatefulWidget {
  final List<Flashcards> flashcards = [Flashcards("Un Cuarto", "One-fourth, 1/4"), Flashcards("Dos-Novenos", "Two-Ninths, 2/4"), Flashcards("Tres-Cuartos", "Three-fourths, 3/4"), Flashcards("Cinco-Sextos", "Five-Sixths, 5/6"), Flashcards("Siete-Octavos", "Seven-Eighths, 7/8")];

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
      context, MaterialPageRoute(builder: (context) => FractionsLecture()));
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
                                    text: widget.flashcards[_currentIndex].frontSide,
                                    fontColor: Color(0xFF0C2D57),
                                    color: Color(0xFFFFF5CD), //White side
                                    borderColor: Colors.black,
                                  ),
                                  back: FlashcardWidget(
                                    text: widget.flashcards[_currentIndex].backSide,
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
  final String text;
  final Color fontColor;
  final Color color;
  final Color borderColor;

  FlashcardWidget({required this.text, required this.fontColor, required this.color, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        text,
        style: TextStyle(
          color: fontColor,
          fontSize: 100, 
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w800,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
