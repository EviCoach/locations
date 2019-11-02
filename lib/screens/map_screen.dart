import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting; // whether we're showing a place or selecting a place
  MapScreen(this.initialLocation, [this.isSelecting = false])
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
      ),
      // GoogleMap() assumes the width and height of the parent widget
      body: GoogleMap(initialCameraPosition: ,),
    );
  }
}
