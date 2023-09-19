import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kohhran_thianghlim/Models/Data.dart';
import 'package:kohhran_thianghlim/Pages/IndexPage.dart';
import 'package:kohhran_thianghlim/Widgets/misc.dart';

import 'Stores/ThemeStates.dart';
import 'misc/bookData.dart';

void main() async {
  await Hive.initFlutter();
  // await Hive.deleteFromDisk();
  await GetStorage.init();

  Hive.registerAdapter(BookAdapter());
  Hive.registerAdapter(ChapterAdapter());
  await Hive.openBox<Book>('books');
  insertSampleData();
  // await Hive.deleteFromDisk();

  runApp(MyApp());
}

// Future<void> insertSampleData() async {
//   final booksBox = Hive.box<Book>('books');
//
//   final book1 = Book('Khawvel Ngaihtuahna ah te chuan ho in lang mahse', [
//     Chapter('Chapter 1: Kan ngaihtuahna', Book1C1),
//     Chapter('Chapter 2:Khawvel thil te hi', Book1C2),
//   ]);
//
//   final book2 = Book('Khawvel Lawm nan a lo kal a', [
//     Chapter('Chapter 1', 'Content of Chapter 1'),
//     Chapter('Chapter 2', 'Content of Chapter 2'),
//   ]);
//
//
//   // Check if a book with the same title already exists before adding
//   if (!bookExists(booksBox, book1.title)) {
//     booksBox.add(book1);
//   }
//   if (!bookExists(booksBox, book2.title)) {
//     booksBox.add(book2);
//   }
//   // booksBox.add(book1);
//   // booksBox.add(book2);
// }
//
// bool bookExists(Box<Book> booksBox, String title) {
//   for (var i = 0; i < booksBox.length; i++) {
//     final existingBook = booksBox.getAt(i);
//     if (existingBook != null && existingBook.title == title) {
//       return true;
//     }
//   }
//   return false;
// }

Future<void> insertSampleData() async {
  final booksBox = Hive.box<Book>('books');

  final existingTitles = booksBox.values.map((book) => book.title).toSet();

  for (final bookInfo in bookData) {
    final title = bookInfo['title'] as String;
    final bookId = bookInfo['bookId'] as String;

    // Check if a book with the same title already exists before adding
    if (!existingTitles.contains(title)) {
      final chapters = (bookInfo['chapters'] as List<Chapter>);
      final bookImagePath =
          bookInfo['bookImagePath'] as String ?? ''; // Get the image path

      final book = Book(title, chapters, bookImagePath,bookId);
      booksBox.add(book);
    }
  }
}

class MyApp extends StatelessWidget {
  final ThemeController _themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.brown),

        primaryColor: Colors.purpleAccent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black
        ),

        // textTheme: TextTheme(
        //   displayLarge: TextStyle(fontSize: _themeController.fontSize.value+10,color: Colors.black), // Example: Large headline
        //   displayMedium: TextStyle(fontSize: 30.0,color: Colors.black), // Example: Medium headline
        //   bodyLarge: TextStyle(fontSize: _themeController.fontSize.value+2,color: Colors.black), // Example: Default text size
        //   bodyMedium: TextStyle(fontSize: _themeController.fontSize.value,color: Colors.black), // Example: Small text size
        //   bodySmall: TextStyle(fontSize: _themeController.fontSize.value,color: Colors.black), // Example: Small text size
        //   titleMedium: TextStyle(fontSize: _themeController.fontSize.value,color: Colors.black), // Example: Small text size
        //
        //
        //
        // ),
        // Customize other light theme properties here
      ),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        primaryColor: Colors.indigo,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black, // Set the background color explicitly for dark theme
          foregroundColor: Colors.white, // Adjust the text color for dark theme
        ),

        // Customize other dark theme properties here
      ),
      themeMode: ThemeMode.system,
      home: HomePage(),

    );
  }

}
