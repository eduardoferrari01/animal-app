import 'dart:async';
import 'dart:io';

import 'package:animal_app/components/centered_message.dart';
import 'package:animal_app/components/progress.dart';
import 'package:animal_app/components/response_dialog.dart';
import 'package:animal_app/dao/animal_identified_dao.dart';
import 'package:animal_app/http/exception/not_found_exception.dart';
import 'package:animal_app/http/webclients/classification_webclient.dart';
import 'package:animal_app/model/animal.dart';
import 'package:animal_app/model/animal_identified.dart';
import 'package:flutter/material.dart';

import '../information/information.dart';

const appBarText = 'Informações';

class Identifies extends StatelessWidget {
  final String _imagePath;
  final IdentifiesWebClient _identifiesWebClient = IdentifiesWebClient();
  final AnimalIdentifiedDao animalIdentifiedDao = AnimalIdentifiedDao();
  bool _itWasIdentified = false;
  String _label = '';
  String _name = '';

  Identifies(this._imagePath, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(appBarText),
          actions: <Widget>[saveInformationButton(context)],
          backgroundColor: Colors.green[800],
        ),
        body: FutureBuilder<Animal>(
          future: _identify(context),
          builder: (context, snapshot) {
            if (ConnectionState.done == snapshot.connectionState) {
              if (snapshot.hasData && !snapshot.hasError) {
                Animal animal = snapshot.data!;
                _label = animal.label;
                _name = animal.species;
                _itWasIdentified = true;
                return Information(animal);
              }

              return CenteredMessage(
                'Animal não identificado',
                icon: Icons.warning,
              );
            }

            if (ConnectionState.waiting == snapshot.connectionState) {
              return const Progress(
                message: 'Identificando....',
              );
            }

            return const Text('unknown error');
          },
        ));
  }

  IconButton saveInformationButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.storage),
      tooltip: 'Salvar informações',
      onPressed: () {
        if (_itWasIdentified) {
          scaffoldMessenger(context, 'Salvando informações...');
          animalIdentifiedDao.save(AnimalIdentified(0, _name, _label, _imagePath));
          Navigator.pop(context);
        } else {
          scaffoldMessenger(context, 'Não é possível salvar, pois nenhum animal foi identificado');
        }
      },
    );
  }

  void scaffoldMessenger(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: const Duration(seconds: 3), content: Text(message)));
  }

  Future<Animal> _identify(BuildContext context) {
    return _identifiesWebClient.identifyAnimal(File(_imagePath)).catchError((e) {
      _showDialogError(context, 'Tempo limite atingido');
    }, test: (e) => e is TimeoutException).catchError((e) {
      debugPrint(e.message);
    }, test: (e) => e is NotFoundException).catchError((e) {
      _showDialogError(context, e.message);
    }, test: (e) => e is HttpException).catchError((e) {
      _showDialogError(context, 'Ocorreu um erro desconhecido');
    }, test: (e) => e is Exception);
  }

  void _showDialogError(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}