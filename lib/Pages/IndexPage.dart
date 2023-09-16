import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:kohhran_thianghlim/Pages/AboutPage.dart';
import 'package:kohhran_thianghlim/Widgets/BookCards.dart';

import '../Models/Data.dart';
import '../Stores/ThemeStates.dart';
import 'ChapterPage.dart';

class HomePage extends StatelessWidget {
  final ThemeController _themeController = Get.put(ThemeController());
  final ThemeController _fontSizeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Kohhran Thianghlim',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: const AppBarTheme().backgroundColor,
          elevation: 1,
          // foregroundColor: Colors.black,
          leading: Container(
            margin: const EdgeInsets.only(left: 8.0),
            child: Image.asset(
              'assets/logo.png',
            ),
          ),
          centerTitle: false,
          leadingWidth: 50,
          titleSpacing: 10,
        ),
        body: Container(
          // color: Colors.white38,
          padding: const EdgeInsets.only(top: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: FutureBuilder(
            future: Hive.openBox<Book>('books'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final box = Hive.box<Book>('books');
                return SingleChildScrollView(
                  // Wrap the GridView.builder with SingleChildScrollView
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: GridView.builder(
                      shrinkWrap: true, // Added shrinkWrap
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        final book = box.getAt(index);
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                                ChapterPage(
                                  book: book,
                                ),
                                transition: Transition.rightToLeft);
                          },
                          child: SizedBox(
                            height: 200,
                            child: Flex(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              direction: Axis.vertical,
                              children: [
                                Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 3,
                                  child: Image.asset(
                                    book!.bookImagePath.toString(),
                                    width: 140,
                                    height: 180,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Obx(
                                  () => SizedBox(
                                    width: 145,
                                    child: Text(
                                      book!.title,
                                      style:_fontSizeController.isDarkMode.value ? null : const TextStyle(
                                        // fontSize: _fontSizeController
                                        //             .fontSize.value >=
                                        //         16
                                        //     ?18: 2.0 +
                                        //         _fontSizeController
                                        //             .fontSize.value
                                        //     ,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                        // overflow:_fontSizeController.fontSize.value >= 18 ?  TextOverflow.ellipsis : null
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        // maxCrossAxisExtent: 300,
                        // childAspectRatio: 2 / 2.8,
                        // crossAxisSpacing: 0,
                        // mainAxisSpacing: 0,
                        crossAxisCount: 2, // Number of cards in a row
                        childAspectRatio: 0.7,
                      ),
                    ),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
        endDrawer: endDrawer(),
      ),
    );
  }

  Widget endDrawer() {
    return Drawer(
      // This is the right drawer

      child: Obx(
         () {
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // const DrawerHeader(
              //   margin: EdgeInsets.,
              //   decoration: BoxDecoration(
              //     // color: ,
              //   ),
              //   child: Text(
              //     'Kohhran Thianghlim',
              //     style: TextStyle(
              //       // color: Colors.white,
              //       fontSize: 20,
              //     ),
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Kohhran",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "Thianghlim",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                    )
                  ],
                ),
              ),
              const Divider(),

              ListTile(
                leading: const Icon(Icons.account_balance_outlined),
                title:  Text(
                  "About",
                  style: TextStyle(fontSize: _fontSizeController.fontSize.value),
                ),
                onTap: () {
                  Get.to(AboutPage());
                },
              ),
              // const Divider(),
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: Row(
                  children: [
                     Expanded(
                       child: Text(
                        'Nigth mode',
                        style: TextStyle(fontSize: _fontSizeController.fontSize.value),
                    ),
                     ),
                   Switch(
                        inactiveThumbColor: Colors.grey.shade600,
                        value: _themeController.isDarkMode.value,
                        onChanged: (value) {
                          _themeController.toggleTheme();
                        },
                      ),

                  ],
                ),
              ),
              // Divider(),
             ListTile(
                    leading: const Icon(Icons.font_download),
                    title: Row(
                      
                      children: [
                         Expanded(
                           child: Text(
                            'Font size',
                             style: TextStyle(fontSize: _fontSizeController.fontSize.value),
                        ),
                         ),
                        Row(
                          children: [
                            // ElevatedButton(
                            //
                            //   child: Text('-'),
                            // ),

                            IconButton(
                                onPressed: () {
                                  _fontSizeController.fontSize.value <= 0 ? null : _fontSizeController.decreaseFontSize();
                                },

                                icon:
                                     Icon(Icons.remove_circle)),
                            Text(_fontSizeController.fontSize.toString()),

                            IconButton(
                                onPressed: () {
                                  _fontSizeController.fontSize.value >= 24 ? null : _fontSizeController.increaseFontSize();
                                },
                                icon: const Icon(Icons.add_circle)),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     _fontSizeController.increaseFontSize();
                            //   },
                            //   child: Text('+'),
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
            ],
          );
        }
      ),
    );
  }
}
