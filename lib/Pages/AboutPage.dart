import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Models/Data.dart';
import 'ContentPage.dart';

class AboutPage extends StatelessWidget {

  // ChapterPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("About"),
          // backgroundColor: Colors.white,
          elevation: 1,
          // foregroundColor: Colors.black,
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Text(

              """ Kohhran Thianghlim, also known as The Holy Church, is a vibrant Christian denomination rooted in the heart of Mizoram, located in the northeastern region of India. This faith community was founded in 1984 by the visionary Dr. L.B. Sailo, a certified veterinary doctor who also serves as the Director of the Animal Husbandry and Veterinary Department under the Government of Mizoram.

Headquartered in the scenic city of Aizawl, specifically at Chawlhhmun, the spiritual and geographical heart of the church is adorned with the magnificent Solomon's Temple, a symbol of faith and devotion. The spiritual guidance and administrative guidance for Kohhran Thianghlim are provided by the dedicated members of the Executive Committee, with various subordinate boards managing the church's diverse activities and initiatives.

Kohhran Thianghlim is not confined to one locality but has spread its spiritual wings across Mizoram, encompassing seven administrative divisions. The distinctive emblem of this faith community proudly features David's star, which can be seen on its flag, emblem, and the majestic Solomon's Temple.

Church Administration:
The spiritual epicenter of Kohhran Thianghlim resides in Aizawl, serving as the general headquarters of the church. It is here that the esteemed Executive Committee convenes to guide the faithful on spiritual and administrative matters, ensuring that the church remains a beacon of light for its members.

Aizawl is often lovingly referred to as the spiritual Jerusalem for the elects, signifying the profound spiritual significance that this city holds for the dedicated members of Kohhran Thianghlim. """, style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
