import 'package:animal_app/model/animal.dart';

class AnimalIdentified {
  final int id;
  final String name;
  final String label;
  final String imagePath;

  AnimalIdentified(this.id, this.name ,this.label ,this.imagePath);

  @override
  String toString() {
    return 'id: $id, name: $name, label: $label, $imagePath';
  }
}