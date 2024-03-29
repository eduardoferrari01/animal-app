import 'package:flutter/material.dart';
import 'package:animal_app/model/animal.dart';

class Information extends StatelessWidget {
  final Animal _animal;

  const Information(this._animal, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: const EdgeInsets.all(8.0), child: Image.network(_animal.urlImage)),
          _InformationWidget('Nome cientifico', _animal.species),
          _InformationWidget('Nomes populares', _animal.popularNames),
          _InformationWidget('Família', _animal.family),
          _InformationWidget('Genero', _animal.genre),
          _InformationWidget('Peçonhenta/Venenosa', _animal.venomous),
          _InformationWidget('Pode causar acidente grave', _animal.canCauseSeriousAccident),
          _InformationWidget('Sintomas do acidente', _animal.accidentSymptom),
          _InformationWidget('Tratamento específico', _animal.antivenom),
          _InformationWidget('Dentição', _animal.dentition),
          _InformationWidget('Hábitat', _animal.habitat),
          _InformationWidget('Status de conservação', _animal.conservationState),
          _InformationWidget('Características', _animal.characteristics),
          _InformationWidget('Etimologia', _animal.etymology)
        ],
      ),
    );
  }
}

class _InformationWidget extends StatelessWidget {
  final String _title;
  final String _subtitle;
  final bool visible;

  const _InformationWidget(this._title, this._subtitle, {this.visible = true});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: Card(
        child: ListTile(
          title: Text(_title),
          subtitle: Text(_subtitle),
        ),
      ),
      visible: this._subtitle.isNotEmpty ? true : false,
    );
  }
}
