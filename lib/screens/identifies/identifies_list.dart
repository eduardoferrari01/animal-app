import 'package:animal_app/components/centered_message.dart';
import 'package:animal_app/components/progress.dart';
import 'package:animal_app/dao/animal_identified_dao.dart';
import 'package:animal_app/model/animal_identified.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'identifies_find.dart';

const capturaImagemButtonText = 'Identificar';

class Identifie_list extends StatefulWidget {
  const Identifie_list({Key? key}) : super(key: key);

  @override
  State<Identifie_list> createState() => _Identifie_listState();
}

class _Identifie_listState extends State<Identifie_list> {
  final AnimalIdentifiedDao dao = AnimalIdentifiedDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<AnimalIdentified>>(
          initialData: List.empty(),
          future: dao.findAll(),
          builder: (context, snapshot) {

            if (ConnectionState.done == snapshot.connectionState) {
              if (snapshot.hasData && !snapshot.hasError) {
                List<AnimalIdentified> identifiedAnimals = snapshot.data as List<AnimalIdentified>;

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final AnimalIdentified animalIdentified = identifiedAnimals[index];
                    return AnimalCard(animalIdentified);
                  },
                  itemCount: identifiedAnimals.length,
                );
              }

              return CenteredMessage(
                'Lista vazia',
                icon: Icons.warning,
              );
            }

            if (ConnectionState.waiting == snapshot.connectionState) {
              return const Progress(
                message: 'Listando....',
              );
            }

            return Text("Unknown error");
          }),
    );
  }
}

class AnimalCard extends StatelessWidget {
  final AnimalIdentified animalIdentified;

  AnimalCard(this.animalIdentified);

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(File(animalIdentified.imagePath),  height: 190, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  animalIdentified.name,
                  style: TextStyle(fontSize: 16.0),
                ),
                IconButton(
                  onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => IdentifiesFind(animalIdentified.label)   ,
                    ));
                  },
                  icon: const Icon(Icons.tab),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
