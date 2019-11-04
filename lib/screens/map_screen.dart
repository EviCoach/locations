import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

// handle taps on the map and save that
// as a location the user wants to pick
class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting; // whether we're showing a place or selecting a place
  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 6.337, longitude: 3.345),
      this.isSelecting = false});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;
  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Map'), actions: <Widget>[
        // inside of a list if() feature
        if (widget.isSelecting)
          IconButton(
            icon: Icon(
              Icons.check,
            ),
            onPressed: _pickedLocation == null
                ? null
                : () {
                    Navigator.of(context).pop(
                        _pickedLocation); // return some data back to the page we used to open it
                  },
          )
      ]),
      // GoogleMap() assumes the width and height of the parent widget
      // it renders a google map
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_pickedLocation == null && widget.isSelecting)
            ? null
            : {
                Marker(
                    markerId: MarkerId('m1'),
                    position: _pickedLocation ??
                        LatLng(
                          widget.initialLocation.latitude,
                          widget.initialLocation.longitude,
                        )),
              },
      ),
    );
  }
}
