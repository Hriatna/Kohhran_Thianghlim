import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'Data.g.dart';

@HiveType(typeId: 0)
class Book {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late List<Chapter> chapters;

  @HiveField(2)
  late String bookImagePath; // Add the book image path field

  @HiveField(3)
  late String bookId; // Add the book image path field

  Book(this.title, this.chapters, this.bookImagePath,this.bookId); // Modify the constructor
}

@HiveType(typeId: 1)
class Chapter {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String content;

  Chapter(this.title, this.content);
}


