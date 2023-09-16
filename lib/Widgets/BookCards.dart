import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kohhran_thianghlim/Models/Data.dart';

class BookCard extends StatelessWidget {
  // const BookCard({Key? key}) : super(key: key);
  final Book book;
   BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          child: Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSb0kaeqYsRqBfrKuoppTCfhimmlDkNb3ycw&usqp=CAU"),
        ),
        Text(
            book.title.toString()
        )
      ],
    );
  }
}
