import 'dart:io';
import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
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
