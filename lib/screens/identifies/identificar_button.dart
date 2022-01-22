import 'package:flutter/material.dart';
import 'package:animal_app/screens/capture_photo/option_dialog.dart';
import 'package:animal_app/screens/capture_photo/preview_screen.dart';

const capturaImagemButtonText = 'Identificar';

class IdentificarButton extends StatefulWidget {
  const IdentificarButton({Key? key}) : super(key: key);

  @override
  State<IdentificarButton> createState() => _IdentificarButtonState();
}

class _IdentificarButtonState extends State<IdentificarButton> {
  String _texto = 'Pressione Identificar';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.all(56),
            child: Text(
              _texto,
              style: TextStyle(fontSize: 24),
            )),
        Padding(
          padding: const EdgeInsets.all(60),
          child: SizedBox(
            width: 210,
            height: 210,
            child: ElevatedButton(
              onPressed: () =>
                  showDialog<String>(context: context, builder: (BuildContext context) => OptionDialog(context)).then(
                (pathImg) => _openPreviewScreen(pathImg ?? ''),
              ),
              child: const Text(capturaImagemButtonText, style: TextStyle(fontSize: 19)),
              style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen.shade600, shape: const CircleBorder(), padding: const EdgeInsets.all(30)),
            ),
          ),
        ),
      ],
    );
  }

  _openPreviewScreen(String pathImg) {
    if (pathImg.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PreviewScreen(
          imagePath: pathImg,
        ),
      ));
    }
  }
}
