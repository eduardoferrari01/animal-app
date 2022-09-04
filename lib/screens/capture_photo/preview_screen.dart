import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../components/centered_message.dart';
import '../../components/progress.dart';
import '../identifies/identifies.dart';
import 'dart:developer' as developer;

class PreviewScreen extends StatelessWidget {
  final String imagePath;
  const PreviewScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String croppedFilePath= "";
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
                child: FutureBuilder(
                    future: _cropSquareImage(imagePath),
                    builder: (context, snapshot) {
                      if (ConnectionState.done == snapshot.connectionState) {
                        String? path = snapshot.data;
                        if (path != null) {
                          croppedFilePath = path;
                          return Padding(padding: const EdgeInsets.all(8.0), child: Image.file(File(path), height: 500, width: double.infinity, fit: BoxFit.cover));

                        } else {
                          developer.log('Erro ao carregar a image: ${snapshot.stackTrace}');

                          return CenteredMessage(
                            'Não foi possìvel carregar a imagem',
                            icon: Icons.warning,
                          );

                        }
                      }
                      return const Progress(
                        message: 'Carregando Imagem....',
                      );
                    })),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (builder) => Identifies(croppedFilePath)))
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

  Future<String> _cropSquareImage(String imagePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.green[800],
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            activeControlsWidgetColor: Colors.greenAccent,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      return croppedFile.path;
    }

    return "";
  }
}
