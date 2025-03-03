import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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


Widget emojiText(String topEmoji, String bottomText){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align( //Top Emoji
            alignment: Alignment(0.0, 0.0),
            child: SizedBox(
              width: 187,
              height: 188,
              child: Align(
                alignment: Alignment(0.0, 2.0),
                child: Text(
                  topEmoji,
                  style: GoogleFonts.notoColorEmoji(
                    color: Colors.black,
                    fontSize: 120,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              )
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align( //Bottom Text
            alignment: Alignment(0.5, 0.0),
            child: SizedBox(
              width: 418,
              height: 195,
              child: Align(
                alignment: Alignment(0.0, 0.0),
                child: Text(
                  bottomText,
                  style: TextStyle(
                    color: Color(0xFF0C2D57),
                    fontSize: 75,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              )
            ),
          )
        ],
      )
    ]
  );
}

Widget buttonEmojiText(String topEmoji, String bottomText, VoidCallback pressed){
  return SizedBox( //Left button
    width: 536.48,
    height: 385,
    child: ElevatedButton(
      onPressed: pressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFFF5CD),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(84),
        ),
      ),
      child: emojiText(topEmoji, bottomText),
    )
  );
}

Widget buttonPairEmojiText(String leftTopEmoji, String leftBottomText, VoidCallback leftPressed, String rightTopEmoji, String rightBottomText, VoidCallback rightPressed){
  return Stack(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox( //Left button
            width: 536.48,
            height: 385,
            child: ElevatedButton(
              onPressed: leftPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFF5CD),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(84),
                ),
              ),
              child: emojiText(leftTopEmoji, leftBottomText),
            )
          ),

          SizedBox( //Right button
            width: 536.48,
            height: 385,
            child: ElevatedButton(
              onPressed: rightPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFF5CD),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(84),
                ),
              ),
              child: emojiText(rightTopEmoji, rightBottomText),
            )
          ),
        ]
      )
    ],
  );
}