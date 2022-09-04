class Animal {
  final String label;
  final String popularNames;
  final String conservationState;
  final String antivenom;
  final String etymology;
  final String venomous;
  final String species;
  final String family;
  final String genre;
  final String dentition;
  final String habitat;
  final String urlImage;
  final String accidentSymptom;
  final String canCauseSeriousAccident;
  final String characteristics;

  Animal(this.label, this.popularNames, this.conservationState, this.antivenom, this.etymology, this.venomous, this.species,
     this.family ,this.genre, this.dentition, this.habitat ,this.accidentSymptom, this.urlImage, this.canCauseSeriousAccident, this.characteristics);

  Animal.fromJson(Map<String, dynamic> json)
      : label = json['label'],
        popularNames =  json['popularNames'],
        conservationState = json['conservationState'],
        antivenom = json['antivenom'],
        etymology = json['etymology'],
        venomous = json['venomous'],
        species = json['species'],
        family = json['family'],
        genre = json['genre'],
        dentition = json['dentition'],
        habitat = json['habitat'],
        urlImage = json['urlImage'],
        accidentSymptom = json['accidentSymptom'],
        canCauseSeriousAccident = json['canCauseSeriousAccident'],
        characteristics = json['characteristics'];

  @override
  String toString() {
    return 'Animal{popularNames: $popularNames, conservationState: $conservationState, antivenom: $antivenom, etymology: $etymology, venomous: $venomous, species: $species, family: $family, genre: $genre, dentition: $dentition, habitat: $habitat, urlImage: $urlImage, accidentSymptom: $accidentSymptom, canCauseSeriousAccident: $canCauseSeriousAccident, characteristics: $characteristics}';
  }
}
