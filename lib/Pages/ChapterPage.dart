import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Models/Data.dart';
import '../Stores/ThemeStates.dart';
import 'ContentPage.dart';

class ChapterPage extends StatelessWidget {
  final Book book;
  final ThemeController _fontSizeController = Get.find();

  ChapterPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(book.title),
          // backgroundColor: Colors.white,
          elevation: 1,
          // foregroundColor: Colors.black,
          centerTitle: false,
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: ListView.separated(
            itemCount: book.chapters.length,
            separatorBuilder: (BuildContext context, int index) => const Divider(),

            itemBuilder: (context, index) {
              final chapter = book.chapters[index];
              return ListTile(
                // leading: SizedBox(),

                title: Text(
                  chapter.title,
                  // style: const TextStyle(fontWeight: FontWeight.w700),
                  style: TextStyle(
                    fontSize: 4.0 + _fontSizeController.fontSize.value,
                  ),
                ),
                onTap: () {
                  Get.to(
                      ContentPage(
                        chapter: chapter,
                        book: book,
                        index: index,
                      ),
                      transition: Transition.rightToLeft);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ContentPage(chapter: chapter, book: book,),
                  //   ),
                  // );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
