import 'dart:async';
import 'package:animal_app/dao/animal_identified_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'animal_identified_db.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(AnimalIdentifiedDao.tableSql);
    },
    version: 1,
     //onDowngrade: onDatabaseDowngradeDelete,
  );
}
