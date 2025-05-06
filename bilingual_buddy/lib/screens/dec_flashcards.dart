import 'package:flutter/material.dart';
import 'useful_widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'dec_lessons_page.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:developer';
import 'dart:math' hide log;
import 'globals.dart';
import 'chat_assistant.dart'; // Make sure this import is included

class Flashcards {
  String frontSide;
  String backSide;

  Flashcards(this.frontSide, this.backSide);
}

class DecimalsFlashcardViewer extends StatefulWidget {
  final List<Flashcards> flashcards;
  final int lessonNum;

  DecimalsFlashcardViewer({
    required this.flashcards,
    required this.lessonNum,
    Key? key,
  }) : super(key: key);

  @override
  _DecimalsFlashcardViewerState createState() =>
      _DecimalsFlashcardViewerState();
}

class _DecimalsFlashcardViewerState extends State<DecimalsFlashcardViewer> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    widget.flashcards.shuffle(Random());
    _pageController = PageController(viewportFraction: 0.9);
  }

  void decimalsFlashcards() async {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            DecimalsFlashCards(),
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: backgroundColor),
                child: Stack(
                  children: [
                    backTextMenuBar(
                      context,
                      decimalsFlashcards,
                      "Lesson ${widget.lessonNum} Flashcards",
                    ),
                    Align(
                      alignment: Alignment(0.0, 0.5),
                      child: SizedBox(
                        width: 933,
                        height: 550,
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemCount: widget.flashcards.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 55.0),
                              child: FlipCard(
                                key: GlobalKey<FlipCardState>(),
                                direction: FlipDirection.VERTICAL,
                                front: FlashcardWidget(
                                  flashcard: widget.flashcards[index],
                                  fontColor: Color(0xFF0C2D57),
                                  color: Color(0xFFFFF5CD),
                                  borderColor: Colors.black,
                                ),
                                back: FlashcardWidget(
                                  flashcard: widget.flashcards[index],
                                  fontColor: Color(0xFFFFF5CD),
                                  color: Color(0xFF0C2D57),
                                  borderColor: Colors.transparent,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const ChatAssistant(), // 👈 Added floating chat assistant
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlashcardWidget extends StatelessWidget {
  final Flashcards flashcard;
  final Color fontColor;
  final Color color;
  final Color borderColor;

  FlashcardWidget({
    required this.flashcard,
    required this.fontColor,
    required this.color,
    required this.borderColor,
  });

  String text() {
    return (color.value == 0xFF0C2D57)
        ? flashcard.backSide
        : flashcard.frontSide;
  }

  String audioFileName() {
    return "lesson1_${flashcard.frontSide}.mp3";
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
      if (color.value == 0xFF0C2D57)
        Positioned(
          bottom: 50,
          right: 50,
          child: ElevatedButton(
            onPressed: () async {
              try {
                final AudioPlayer audioPlayer = AudioPlayer();
                audioPlayer.setVolume(1.0);
                await audioPlayer.play(
                  AssetSource(
                    'flashcards/sounds/lesson1_${flashcard.frontSide}.mp3',
                  ),
                );
              } catch (e) {
                log("Error playing audio: $e");
              }
            },
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(16),
              backgroundColor: Colors.blue,
            ),
            child: Icon(
              Icons.hearing,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
    ]);
  }
}
