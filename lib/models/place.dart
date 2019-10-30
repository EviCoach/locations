import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address, // not required because lat. & long. are the key info for finding a location, it's the human readable part
  });
}
