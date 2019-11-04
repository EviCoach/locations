import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../widgets/location_input.dart';
import '../widgets/image_input.dart';
import '../providers/great_places.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

// function used to forward the chosen location from other widgets to this one
  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null) {
      return;
    }

    Provider.of<GreatPlaces>(context)
        .addPlace(_titleController.text, _pickedImage, _pickedLocation);
    // go back
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            // takes all available space it
            // vertically or horizontally depending if
            // it's in a column or a row
            child: Container(
              margin: EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        //contentPadding: EdgeInsets.all(),
                      ),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10),
                    ImageInput(_selectImage),
                    SizedBox(height: 10),
                    LocationInput(_selectPlace)
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton.icon(
                  onPressed: _savePlace,
                  elevation: 0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  color: Theme.of(context).accentColor,
                  icon: Icon(Icons.add),
                  label: Text('Add Place'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
