import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomArrowButton extends StatelessWidget {
  final VoidCallback onPressed;

  CustomArrowButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: CustomPaint(
          size: Size(91, 93),
          painter: ArrowPainter(),
        ),
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


Widget emojiText(String topEmoji, String bottomText, double width, double fontSize){
  width = width - 50;
  assert(width > 1);
  double height = fontSize + 15;

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align( //Top Emoji
            alignment: Alignment(0.0, 0.0),
            child: SizedBox(
              width: 160,
              height: 160,
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
              width: width,
              height: height,
              child: Align(
                alignment: Alignment(0.0, 0.0),
                child: Text(
                  bottomText,
                  style: TextStyle(
                    color: Color(0xFF0C2D57),
                    fontSize: fontSize,
                    fontFamily: 'a',
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

Widget singleText(String text, double width, double fontSize){
  width = width - 50;
  assert(width > 1);
  double height = fontSize + 45;

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align( //Bottom Text
            alignment: Alignment(0.5, 0.0),
            child: SizedBox(
              width: width,
              height: height,
              child: Align(
                alignment: Alignment(0.0, 0.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Color(0xFF0C2D57),
                    fontSize: fontSize,
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

Widget buttonText(String text, VoidCallback pressed, {double? x, double? y, double? width, double? height, double? fontSize}){
  x ??= 0.0;
  y ??= 0.0;

  width ??= 536.48;
  height ??= 385;

  fontSize ??= 75;
  
  return Align(
    alignment: Alignment(x, y),
    child: SizedBox( //Left button
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: pressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFFF5CD),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1),
            borderRadius: BorderRadius.circular(84),
          ),
        ),
        child: singleText(text, width, fontSize),
      )
    )
  );
}

Widget buttonPairText(String leftText, VoidCallback leftPressed, String rightText, VoidCallback rightPressed, {double? x, double? y, double? width, double? height, double? spacer, double? fontSize}){
  x ??= 0.0;
  y ??= 0.75;

  width ??= 536.48;
  height ??= 385;
  spacer ??= 0;

  fontSize ??= 75;
  return Align(
    alignment: Alignment(x, y),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [ 
        SizedBox( //Left button
          width: width,
          height: height,
          child: ElevatedButton(
            onPressed: leftPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFFF5CD),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1),
                borderRadius: BorderRadius.circular(84),
              ),
            ),
            child: singleText(leftText, width, fontSize),
          )
        ),
        SizedBox(
          width: spacer, 
          height: height,
        ),
        SizedBox( //Right button
          width: width,
          height: height,
          child: ElevatedButton(
            onPressed: rightPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFFF5CD),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1),
                borderRadius: BorderRadius.circular(84),
              ),
            ),
            child: singleText(rightText, width, fontSize),
          )
        )
      ]
    )
  );
}


Widget buttonEmojiText(String topEmoji, String bottomText, VoidCallback pressed, {double? x, double? y, double? width, double? height, double? fontSize}){
  x ??= 0.0;
  y ??= 0.75;

  width ??= 536.48;
  height ??= 385;

  fontSize ??= 75;

  return Align(
    alignment: Alignment(x, y),
    child: SizedBox( //Left button
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: pressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFFF5CD),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1),
            borderRadius: BorderRadius.circular(84),
          ),
        ),
        child: emojiText(topEmoji, bottomText, width, fontSize),
      )
    )
  );
}

Widget buttonPairEmojiText(String leftTopEmoji, String leftBottomText, VoidCallback leftPressed, String rightTopEmoji, String rightBottomText, VoidCallback rightPressed, {double? x, double? y, double? width, double? height, double? fontSize}){
  x ??= 0.0;
  y ??= 0.75;

  width ??= 536.48;
  height ??= 385;

  fontSize ??= 75;
  
  return Align(
    alignment: Alignment(x, y),
    child: Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox( //Left button
              width: width,
              height: height,
              child: ElevatedButton(
                onPressed: leftPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFF5CD),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(84),
                  ),
                ),
                child: emojiText(leftTopEmoji, leftBottomText, width, fontSize),
              )
            ),

            SizedBox( //Right button
              width: width,
              height: height,
              child: ElevatedButton(
                onPressed: rightPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFF5CD),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(84),
                  ),
                ),
                child: emojiText(rightTopEmoji, rightBottomText, width, fontSize),
              )
            ),
          ]
        )
      ],
    )
  );
}


Widget backTextMenuBar(VoidCallback pressed, String label, [double x = 0.0, double y = -0.85]){
  return Align( //A row of widgets, back button labeled as fraction, and 3 stack button
    alignment: Alignment(x, y), 
    child: SizedBox( 
      width: 1150,
      height: 105,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Transform.rotate( //Back button
            angle: -1.57,
            child: CustomArrowButton(
              onPressed: pressed,
            )
          ),

          SizedBox( //Adds space between the arrow and the label
            width: 50,
            height: 105
          ),

          SizedBox( //Label
            width: 800,
            height: 105,
            child: Text(
              label,
              style: TextStyle(
                color: Color(0xFF0C2D57),
                fontSize: 75,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w800,
              ),
            )
          ), 
          Spacer(),
          menuButton() //3 stack button
        ]
      )
    )
  
  );
}

Widget boxText(String text, {double? x, double? y, double? width, double? height, double? fontSize, int? boxColor, int? textColor}) {
  x ??= -0.85;
  y ??= 0.85;

  width ??= 733;
  height ??= 614;

  fontSize ??= 64;
  boxColor ??= 0xFFFFCFB3;
  textColor ??= 0xFF0C2D57;

  return Align(
    alignment: Alignment(x, y),
    child: Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: Color(boxColor),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(84),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Align(
          alignment: Alignment(0.0, 0.0),
          child: Text(
            text, 
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(textColor),
              fontSize: fontSize,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800,
            ),
          )
        ),
      )

    ),
  );
}

void showCustomDialogEmoji(BuildContext context, String title, String emojis, List<Widget> actions) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(84),
        ),
        backgroundColor: Color(0xFFFFF5CD), // Custom background color
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: 712,
            height: 395,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFF0C2D57),
                    fontSize: 96,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  emojis,
                  style: GoogleFonts.notoColorEmoji(
                    color: Colors.black,
                    fontSize: 96,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: actions,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showCustomDialog(BuildContext context, String title, List<Widget> actions, {double? fontSize}) {
    fontSize ??= 55;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1),
            borderRadius: BorderRadius.circular(84),
          ),
          backgroundColor: Color(0xFFFFF5CD), // Custom background color
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 712,
              height: 395,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 60),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0C2D57),
                      fontSize: fontSize,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: actions,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

Widget menuButton(){
  return Align(
    alignment: Alignment(0.0, 0.0),
    child: SvgPicture.asset(
      'lib/assets/images/menu_button.svg',
      width: 102,
      height: 78,
    )
  );
}

