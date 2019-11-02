/*
* managing all the great places we collected
* */
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickTitle, File pickImage) {
    // create a new place from the title and image
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickImage,
      title: pickTitle,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners(); // let everyone listening that there's a change
    // insert the place into the device database
    DBHelper.insert('userplaces', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    print('fetchAndSetPlaces() called');
    final dataList = await DBHelper.getData('userplaces');
    _items = dataList
        .map(
          (data) => Place(
            id: data['id'],
            title: data['title'],
            image: File(data['image']), // create a new file from the given path
            location: null,
          ),
        )
        .toList();
    notifyListeners();
  }
}
