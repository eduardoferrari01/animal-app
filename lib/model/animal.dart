class Animal {
  final String label;
  final String popularNames;
  final String conservationState;
  final String antivenom;
  final String etymology;
  final bool venomous;
  final String species;
  final String family;
  final String genre;
  final String dentition;
  final String habitat;
  final String urlImage;
  final String accidentSymptom;
  final bool canCauseSeriousAccident;
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

  String getConservationState() {
    String conservationStateStr = '';

    switch (conservationState) {
      case 'EX':
        conservationStateStr = 'Extinta';
        break;
      case 'EW':
        conservationStateStr = 'Extinta na natureza';
        break;
      case 'CR':
        conservationStateStr = 'Criticamente em perigo';
        break;
      case 'EN':
        conservationStateStr = 'Em perigo';
        break;
      case 'VU':
        conservationStateStr = 'Vulnerável';
        break;
      case 'NT':
        conservationStateStr = 'Quase ameaçada';
        break;
      case 'LC':
        conservationStateStr = 'Pouco preocupante';
        break;
      case 'DD':
        conservationStateStr = 'Dados Deficientes';
        break;
      case 'NE':
        conservationStateStr = 'Não avaliada';
        break;
    }
    return conservationStateStr;
  }

  @override
  String toString() {
    return 'Animal{popularNames: $popularNames, conservationState: $conservationState, antivenom: $antivenom, etymology: $etymology, venomous: $venomous, species: $species, family: $family, genre: $genre, dentition: $dentition, habitat: $habitat, urlImage: $urlImage, accidentSymptom: $accidentSymptom, canCauseSeriousAccident: $canCauseSeriousAccident, characteristics: $characteristics}';
  }
}
