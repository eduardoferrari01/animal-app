import 'package:animal_app/database/app_database.dart';
import 'package:animal_app/model/animal_identified.dart';
import 'package:sqflite/sqflite.dart';

class AnimalIdentifiedDao {

  static const tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_label TEXT,'
      '$_imagePath TEXT)';

  static const String _tableName = 'identified_animals';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _label = 'label';
  static const String _imagePath = 'image_path';
  
  Future<int> save(AnimalIdentified animalIdentified) async {
    final Database db = await getDatabase();
    Map<String, dynamic> animalIdentifiedMap = _toMap(animalIdentified);
    return db.insert(_tableName, animalIdentifiedMap);
  }

  Map<String, dynamic> _toMap(AnimalIdentified animalIdentified) {
    final Map<String, dynamic> animalIdentifiedMap = Map();
    animalIdentifiedMap[_name] = animalIdentified.name;
    animalIdentifiedMap[_label] = animalIdentified.label;
   animalIdentifiedMap[_imagePath] = animalIdentified.imagePath;
    return animalIdentifiedMap;
  }

  Future<List<AnimalIdentified>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<AnimalIdentified> identifiedAnimals = _toList(result);
    return identifiedAnimals;

  }

  List<AnimalIdentified> _toList(List<Map<String, dynamic>> result) {
    final List<AnimalIdentified> identifiedAnimals = [];
    for (Map<String, dynamic> row in result) {
      final AnimalIdentified animalIdentified = AnimalIdentified(
        row[_id],
        row[_name],
        row[_label],
        row[_imagePath]
      );
      identifiedAnimals.add(animalIdentified);
    }
    return identifiedAnimals;
  }
}
