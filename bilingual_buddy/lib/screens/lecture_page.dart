import 'package:flutter/material.dart';
import 'useful_widgets.dart';
import 'lessons_page.dart';
//import 'package:pdfrx/pdfrx.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PDFContainerWidget extends StatelessWidget {
  final String pdfPath;

  PDFContainerWidget({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadPDFAsset(context, pdfPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Container(
              width: 1042,
              height: 614,
              decoration: ShapeDecoration(
                color: const Color(0xFFEEEEEE),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(84),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(84),
                child: Container(
                  padding: EdgeInsets.all(16), // Add padding to create space around the PDFView
                  color: const Color(0xFFEEEEEE),
                  child: PDFView(
                    filePath: snapshot.data!,
                    fitPolicy: FitPolicy.BOTH,
                    swipeHorizontal: true, // Fit the PDF to the container
                  ),
                ),
              ),
            );
          } else {
            return Center(child: Text("Failed to load PDF"));
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<String> _loadPDFAsset(BuildContext context, String assetPath) async {
    final ByteData data = await DefaultAssetBundle.of(context).load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();
    final String tempPath = (await getTemporaryDirectory()).path;
    final File file = File('$tempPath/sample.pdf');
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }
}

class LessonPage extends StatefulWidget{ 
  final String pdfPath;

  const LessonPage({required this.pdfPath});

  @override
  _LessonPage createState() => _LessonPage();
}

class _LessonPage extends State<LessonPage>{
  void fractionLessons(){
    Navigator.pushReplacement( 
      context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => FractionsLessons(), 
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
  Widget build(BuildContext context){
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
                    backTextMenuBar(context, fractionLessons, "Lesson"),
                    Align(
                      alignment: Alignment(0.0, 0.8),
                      child: PDFContainerWidget(
                        pdfPath: widget.pdfPath
                      )
                    )
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