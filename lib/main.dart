import 'package:animal_app/screens/menu/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:animal_app/database/app_database.dart';

import 'dao/animal_identified_dao.dart';
void main() {
  runApp(const AnimalApp());
}

class AnimalApp extends StatelessWidget {
  const AnimalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(

      home: BottomNavigation(),
    );
  }
}