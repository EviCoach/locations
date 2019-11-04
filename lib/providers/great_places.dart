/*
* managing all the great places we collected
* */
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:location_app/helpers/location_helper.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  void addPlace(
      String pickTitle, File pickImage, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    // create a new place from the title and image
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickImage,
      title: pickTitle,
      location: updatedLocation,
    );
    _items.add(newPlace);
    notifyListeners(); // let everyone listening that there's a change
    // insert the place into the device database
    DBHelper.insert('userplaces', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address
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
            location: PlaceLocation(
                latitude: data['loc_lat'],
                longitude: data['loc_lng'],
                address: data['address']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
