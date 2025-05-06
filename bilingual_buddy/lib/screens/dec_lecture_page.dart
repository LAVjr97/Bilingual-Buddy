import 'package:flutter/material.dart';
import 'useful_widgets.dart';
import 'dec_lessons_page.dart';
import 'globals.dart';
import 'package:pdfx/pdfx.dart';
import 'chat_assistant.dart'; // 👈 Added import

class DecimalsLessonPage extends StatefulWidget {
  final String pdfPath;
  final int lessonNum;

  const DecimalsLessonPage({
    required this.pdfPath,
    required this.lessonNum,
    Key? key,
  }) : super(key: key);

  @override
  _DecimalsLessonPage createState() => _DecimalsLessonPage();
}

class _DecimalsLessonPage extends State<DecimalsLessonPage> {
  late final PdfController pdfController;

  @override
  void initState() {
    super.initState();
    pdfController = PdfController(document: PdfDocument.openAsset(widget.pdfPath));
  }

  void decimalsLessons() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            DecimalsLessons(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve));
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
                      decimalsLessons,
                      "Lesson ${widget.lessonNum}",
                    ),
                    Align(
                      alignment: Alignment(0.0, 0.8),
                      child: Container(
                        width: 1042,
                        height: 614,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          color: textColor,
                          child: PdfView(
                            controller: pdfController,
                            builders: PdfViewBuilders<DefaultBuilderOptions>(
                              options: DefaultBuilderOptions(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const ChatAssistant(), // 👈 Added chat assistant floating button
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
