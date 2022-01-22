import 'package:flutter/material.dart';
import 'dart:io';
import '../identifies/identifies.dart';

class PreviewScreen extends StatelessWidget {
  final String imagePath;

  const PreviewScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pré-visualização'),
        backgroundColor: Colors.green[800],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center, // This is needed
              child: Image.file(File(imagePath),  height: 500, width: double.infinity, fit: BoxFit.cover),

            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (builder) => Identifies(imagePath)))
                  .then((value) => {Navigator.pop(context)});
            },
            style: ElevatedButton.styleFrom(primary: Colors.lightGreen.shade600,),
            child: const Text(
              'Identificar o animal',
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
