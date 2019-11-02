import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imageFile =
        await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = imageFile;
    });
    // where this app is allowed to store data
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    // the temporary directory the image was stored, get the base name of the image
    final fileName = path.basename(imageFile.path);

    // copy the image, save the copy of the image | copy it to the given path
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
//      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double
                      .infinity, // make the image take the full width of the surrounding container
                )
              : Text(
                  'No image taken',
                  textAlign: TextAlign
                      .center, // center the text inside of its own container
                ),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
          // makes the child, ie, button take the remaining space in a row
          child: FlatButton.icon(
            onPressed: () {
              // open the device camera
              _takePicture();
            },
            icon: Icon(Icons.camera),
            label: Text(
              'Take Picture',
            ),
            color: Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }
}
