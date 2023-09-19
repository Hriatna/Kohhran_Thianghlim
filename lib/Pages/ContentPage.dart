import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kohhran_thianghlim/Stores/ThemeStates.dart';

import '../Models/Data.dart';

// class ContentPage extends StatelessWidget {
//   final Chapter chapter;
//
//   ContentPage({required this.chapter});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(chapter.title),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Text(chapter.content),
//       ),
//     );
//   }
// }


class ContentPage extends StatefulWidget {
  final Chapter chapter;
  final Book book;
  final int index;

  ContentPage({required this.chapter, required this.book,required this.index});

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  int currentChapterIndex = 0;
  final ScrollController _scrollController = ScrollController();
  final ThemeController _fontSizeController = Get.find();

  bool _showToTopButton = false;
  void goToNextChapter() {
    if (currentChapterIndex < widget.book.chapters.length - 1) {
      setState(() {
        currentChapterIndex++;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      currentChapterIndex = widget.index;
    });
    print("CHAPTER AND BOOK" +  widget.book.title.toString() + widget.chapter.title.toString() );
    _scrollController.addListener(() {
      if (_scrollController.offset > 100) {
        if (!_showToTopButton) {
          setState(() {
            _showToTopButton = true;
          });
        }
      } else {
        if (_showToTopButton) {
          setState(() {
            _showToTopButton = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chapter = widget.book.chapters[currentChapterIndex];




    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(chapter.title),
          // backgroundColor: Colors.white,
          elevation: 1,
          // foregroundColor: Colors.black,
          centerTitle: false,
          // leadingWidth: 30,

        ),
        body: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(chapter.content,style:  TextStyle(
                  fontSize: 4.0 + _fontSizeController.fontSize.value,


                ),textAlign:TextAlign.justify,softWrap: true,),
                if (currentChapterIndex < widget.book.chapters.length - 1)
                  ElevatedButton(
                    onPressed:(){

                      goToNextChapter();
                      _scrollController.animateTo(
                        0.0, // Scroll to the top
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );                },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white
                    ),
                    child: const Text('Next Chapter'),
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton: _showToTopButton
            ? FloatingActionButton(
          // backgroundColor: Colors.black54,
          onPressed: () {
            // Scroll to the top when the button is pressed
            _scrollController.animateTo(
              0.0, // Scroll to the top
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          child: const Icon(Icons.arrow_upward),
        )
            : null,


      ),
    );
  }
}
