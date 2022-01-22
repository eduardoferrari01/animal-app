import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class ImageTeste{

  void saveFile(String pathImage) async {
    File file = File(await getFilePath()); // 1

    file.writeAsString("This is my demo text that will be saved to : demoTextFile.txt"); // 2
  }

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    return appDocumentsDirectory.path; // 2

  }
}