import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;
  var fontSize = 12.0.obs; // Default font size
  final box = GetStorage(); // Initialize GetStorage

  var titleFontSizeFactor = 1.0.obs;
  var bodyFontSizeFactor = 1.0.obs;
  var sidebarFontSizeFactor = 1.0.obs;


  @override
  void onInit() {
    super.onInit();
    // Retrieve stored values or use defaults
    titleFontSizeFactor.value = box.read('titleFontSizeFactor') ?? 1.0;
    bodyFontSizeFactor.value = box.read('bodyFontSizeFactor') ?? 1.0;

    fontSize.value = box.read('fontSize') ?? 16.0;
    isDarkMode.value = box.read('isDarkMode') ?? false;

  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    box.write('isDarkMode', isDarkMode.value);

    Get.changeTheme(isDarkMode.value ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true));
  }

  void increaseFontSize() {
    titleFontSizeFactor.value += 0.1;
    bodyFontSizeFactor.value += 0.1;

    fontSize.value += 1;

    // Store updated values
    box.write('titleFontSizeFactor', titleFontSizeFactor.value);
    box.write('bodyFontSizeFactor', bodyFontSizeFactor.value);

    box.write('fontSize', fontSize.value);
    update();
  }

  void decreaseFontSize() {
    titleFontSizeFactor.value -= 0.1;
    bodyFontSizeFactor.value -= 0.1;
    sidebarFontSizeFactor.value -= 0.1;
    fontSize.value -= 1;


    // Store updated values
    box.write('titleFontSizeFactor', titleFontSizeFactor.value);
    box.write('bodyFontSizeFactor', bodyFontSizeFactor.value);
    box.write('sidebarFontSizeFactor', sidebarFontSizeFactor.value);
    box.write('fontSize', fontSize.value);

    update();
  }
}
