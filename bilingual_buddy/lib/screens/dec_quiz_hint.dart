// File: dec_quiz_hint.dart

import 'package:bilingual_buddy/screens/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'dec_quiz_page.dart' as dec;
import 'globals.dart';

Color getDecimalQuestionColor(dec.Question question) {
  if (question is dec.MCQ) return mcqQuestionColor;
  if (question is dec.TF) return tfQuestionColor;
  if (question is dec.TXT) return txtQuestionColor;
  return textBackgroundColor;
}

TextStyle getDecimalQuestionTextStyle(dec.Question question) {
  if (question is dec.MCQ) return mcqTextStyle;
  if (question is dec.TF) return tfTextStyle;
  if (question is dec.TXT) return txtTextStyle;
  return TextStyle(fontSize: 24, color: textColor);
}

class DecimalsFlipCardQuizCard extends StatefulWidget {
  final dec.Question question;

  const DecimalsFlipCardQuizCard({
    required this.question,
    Key? key,
  }) : super(key: key);

  @override
  State<DecimalsFlipCardQuizCard> createState() =>
      _DecimalsFlipCardQuizCardState();
}

class _DecimalsFlipCardQuizCardState extends State<DecimalsFlipCardQuizCard> {
  late GlobalKey<FlipCardState> cardKey;

  @override
  void initState() {
    super.initState();
    cardKey = GlobalKey<FlipCardState>();
  }

  @override
  void didUpdateWidget(covariant DecimalsFlipCardQuizCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      if (cardKey.currentState?.isFront == false) {
        cardKey.currentState?.toggleCard();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-0.60, 0.60),
      child: SizedBox(
        width: 733,
        height: 550,
        child: FlipCard(
          key: cardKey,
          direction: FlipDirection.VERTICAL,
          front: _buildCard(
            backgroundColor: getDecimalQuestionColor(widget.question),
            textColor: getDecimalQuestionTextStyle(widget.question).color ?? Colors.black ,
            // backgroundColor: const Color(0xFFFFCFB3),
            // textColor: const Color(0xFF0C2D57),
            content: widget.question.question,
            buttonLabel: "Hint",
            buttonColor: Colors.blue,
            buttonTextColor: Colors.white,
            onTap: () => cardKey.currentState?.toggleCard(),
          ),
          back: _buildCard(
            backgroundColor: const Color(0xFF0C2D57),
            textColor: const Color(0xFFFFF5CD),
            content: widget.question.hint,
            buttonLabel: "Back",
            buttonColor: Colors.white,
            buttonTextColor: Colors.black,
            onTap: () => cardKey.currentState?.toggleCard(),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required Color backgroundColor,
    required Color textColor,
    required String content,
    required String buttonLabel,
    required Color buttonColor,
    required Color buttonTextColor,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(84),
          side: const BorderSide(width: 1, color: Colors.black),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                content,
                style: TextStyle(
                  color: textColor,
                  fontSize: 64,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 30,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: buttonTextColor,
                textStyle: const TextStyle(fontSize: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(buttonLabel),
            ),
          ),
        ],
      ),
    );
  }
}
