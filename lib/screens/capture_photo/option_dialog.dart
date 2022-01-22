import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animal_app/screens/capture_photo/camera.dart';

class OptionDialog extends StatelessWidget {
  final BuildContext _context;

  const OptionDialog(this._context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Escolha a opção'),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () => _camera(),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              Icon(Icons.camera_alt),
              Padding(padding: EdgeInsets.all(4.0)),
              Text(
                'Câmera',
                style: TextStyle(fontSize: 16.0),
              )
            ],
          ),
        ),
        SimpleDialogOption(
          onPressed: () => _galeria(),
          child: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: const [
            Icon(Icons.add_photo_alternate),
            Padding(padding: EdgeInsets.all(4.0)),
             Text(
              'Galeria',
              style: TextStyle(fontSize: 16.0),
            ),
          ]),
        )
      ],
    );
  }

  void _camera() async {
    WidgetsFlutterBinding.ensureInitialized();

    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    XFile image = await Navigator.of(_context).push(MaterialPageRoute(
        builder: (builder) => Camera(
              camera: firstCamera,
            )));

    Navigator.of(_context).pop(image.path);
  }

  void _galeria() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      Navigator.of(_context).pop(image.path);
    }
  }
}