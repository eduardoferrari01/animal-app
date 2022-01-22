import 'dart:async';
import 'dart:io';

import 'package:animal_app/components/centered_message.dart';
import 'package:animal_app/components/progress.dart';
import 'package:animal_app/components/response_dialog.dart';
import 'package:animal_app/http/webclients/animal_webclient.dart';
import 'package:animal_app/model/animal.dart';
import 'package:flutter/material.dart';

import '../information/information.dart';

const appBarText = 'Informações do animal idenficado';

class IdentifiesFind extends StatelessWidget {
  final String label;
  final AnimalWebClient _animalWebClient = AnimalWebClient();
  
  IdentifiesFind(this.label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(appBarText),
          backgroundColor: Colors.green[800],
        ),
        body: FutureBuilder<Animal>(
          future: _findByLabel(context),
          builder: (context, snapshot) {
            if (ConnectionState.done == snapshot.connectionState) {
              if (snapshot.hasData && !snapshot.hasError) {
                Animal animal = snapshot.data!;
                return Information(animal);
              }

              return CenteredMessage(
                'Animal não encontrado',
                icon: Icons.warning,
              );
            }

            if (ConnectionState.waiting == snapshot.connectionState) {
              return const Progress(
                message: 'Buscando....',
              );
            }

            return const Text('unknown error');
          },
        ));
  }

  Future<Animal> _findByLabel(BuildContext context) {
   
    return _animalWebClient.findAnimalByLabel(label);
  }

  void _showDialogError(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
  
}
