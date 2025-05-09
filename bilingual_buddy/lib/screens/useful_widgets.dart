import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_page.dart';
import 'login_page.dart';
import 'globals.dart';


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

Widget leftArrowButton(VoidCallback onPressed){
  return IconButton(
    onPressed: onPressed,
    icon: Icon(
      Icons.arrow_back_ios_new, // Icon inside button
      color: backTextMenuBarColor,
      size: 80,
      weight: 0.8
    ), 
  );
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
                    color: textColor,
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

Widget singleText(String text, double width, double fontSize, {Color? textC}){
  width = width - 50;
  assert(width > 1);
  double height = fontSize + 45;

  textC ??= textColor;

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
                    color: textC,
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

Widget buttonText(String text, VoidCallback pressed, {double? x, double? y, double? width, double? height, double? fontSize, Color? backColor, Color? textC}){
  x ??= 0.0;
  y ??= 0.0;

  width ??= 536.48;
  height ??= 385;

  fontSize ??= 75;
  textC ??= textColor;

  backColor ??= buttonColor;
  
  return Align(
    alignment: Alignment(x, y),
    child: SizedBox( //Left button
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: pressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1),
            borderRadius: BorderRadius.circular(84),
          ),
        ),
        child: singleText(text, width, fontSize, textC: textC),
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
              backgroundColor: buttonColor,
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
              backgroundColor: buttonColor,
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
          backgroundColor: buttonColor,
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
                  backgroundColor: buttonColor,
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
                  backgroundColor: buttonColor,
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


Widget backTextMenuBar(BuildContext context, VoidCallback pressed, String label, [double x = 0.0, double y = -0.85]) { //A row of widgets, back button labeled as fraction, and 3 stack button
  return Align( //A row of widgets, back button labeled as fraction, and 3 stack button
    alignment: Alignment(x, y), 
    child: SizedBox( 
      width: 1150,
      height: 105,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          leftArrowButton(pressed),

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
                color: backTextMenuBarColor,
                fontSize: 75,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w800,
              ),
            )
          ), 
          Spacer(),
          menuButton(context), //3 stack button
        ],
      ),
    ),
  );
}

// Widget boxText(String text, {double? x, double? y, double? width, double? height, double? fontSize, int? boxColor}) {
Widget boxText(String text, {double? x, double? y, double? width, double? height, double? fontSize, Color? backColor}) {
  x ??= -0.85;
  y ??= 0.85;

  width ??= 733;
  height ??= 614;

  fontSize ??= 64;
  // boxColor ??= 0xFFFFCFB3;


  return Align(
    alignment: Alignment(x, y),
    child: Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: backColor ?? textBackgroundColor,
        //color: buttonColor,
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
              color: textColor,
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
        backgroundColor: dialogBackgroundColor,
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
                    color: textColor,
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
          backgroundColor: dialogBackgroundColor, 
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
                      color: textColor,
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



Widget menuButton(BuildContext context){
  return StatefulBuilder(
    builder:(BuildContext context, StateSetter setState){
      bool isHovered = false;

      return StatefulBuilder(
        builder: (context, innerSetState){
          return MouseRegion(
              onEnter: (_) => innerSetState(() => isHovered = true),
              onExit: (_) => innerSetState(() => isHovered = false),
              child: PopupMenuButton<String>(
                splashRadius: 1,
                padding: EdgeInsets.zero,
                offset: Offset(0, 50),
                color: buttonColor, //The following 4 lines change the look of the hamburger menu button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: textColor, width: 1),
                ),
                onSelected: (value){
                  if (value == 'Profile') {
                    // Sends user to the profile screen
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          student: currentStudent
                        )
                      ),
                      );
                  } else if (value == 'Sign Out') {
                    // Signs the user out, but also now asks whether or not they want to sign out
                    showCustomDialog(
                      context,
                      "Are You Sure You Want to Sign Out?",
                      [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),                              
                            );
                          },
                          child: Text(
                            "Yes",
                            style: TextStyle(
                              color: textColor,
                              fontSize: 36,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "No",
                            style: TextStyle(
                              color: textColor,
                              fontSize: 36,
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'Profile',
                      child: Text(
                        'Profile', 
                        style: TextStyle(
                          fontSize: 30,
                          color: textColor
                        ),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Sign Out',
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                          fontSize: 30,
                          color: textColor
                        ),
                      ),
                    ),
                  ];
                },
                child: SvgPicture.asset(
                  isHovered
                    ? 'assets/images/hover_menu_button.svg'
                    : 'assets/images/menu_button.svg',
                  width: 102,
                  height: 78,
                ),
              ),
            );
          
        },
      );
    },
  );
}

Widget boxInput(TextEditingController inputController, String hint, {double? x, double? y, double? width, double? height, double? fontSize, Color? backColor}){
  x ??= -0.85;
  y ??= 0.85;

  width ??= 562;
  height ??= 91;

  fontSize ??= 48;
  // boxColor ??= 0xFFFFF5CD;
  backColor ??= textBackgroundColor;

  return Align( 
    alignment: Alignment(x, y),
    child: Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: backColor ?? textBackgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(84),
        ),
      ),

      child:Padding(
        padding: EdgeInsets.symmetric(vertical: 17), //Horizonal adds padding to the left of the hint text
        child: TextField(
          controller: inputController,
          textAlign: TextAlign.center,
          style: TextStyle(           //Actual input text
            color: textColor,// Color(0xFF0C2D57),
            fontSize: fontSize,
            fontFamily: 'Outfit',
            fontWeight: FontWeight.w800,
          ),
          decoration: InputDecoration( //"hint" text
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.w800,
            )
          ),
        )
      ),
    ),
  );
}

//Useful Functions
Color getColorForPercentage(double percentage) {
  percentage = percentage.clamp(0, 100);

  // Define base colors
  const bronze = Color(0xFFFFD700);   
  const silver = Color(0xFFC0C0C0);   
  const gold   = Color.fromARGB(255, 15, 189, 15);   
  const red = Color.fromARGB(255, 214, 18, 18); 

  if (percentage < 50) {
    // 0% → 50%: Red solid
    return red;
  } else if (percentage < 75) {
    // 50% → 75%: Red → Bronze
    double t = (percentage - 50) / 25; // Normalize to 0-1
    return Color.lerp(red, bronze, t)!;
  } else if (percentage < 90) {
    // 75% → 90%: Bronze → Silver
    double t = (percentage - 75) / 15; // Normalize to 0-1
    return Color.lerp(bronze, silver, t)!;
  } else {
    // 90% → 100%: Silver → Gold
    double t = (percentage - 90) / 10; // Normalize to 0-1
    return Color.lerp(silver, gold, t)!;
  }
}