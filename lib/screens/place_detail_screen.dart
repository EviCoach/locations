import 'package:flutter/material.dart';
import 'package:location_app/providers/great_places.dart';
import 'package:location_app/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;

    // we could fetch all items and do the logic here
    // but it is always a good idea to outsource logic
    // and get it out of your widget
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    // return a Scaffold since this
    // is a standalone page
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(children: <Widget>[
        Container(
          height: 250,
          width: double.infinity,
          child: Image.file(
            selectedPlace.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          selectedPlace.location.address,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 10),
        FlatButton(
          child: Text('View on Map'),
          textColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog:
                    true, // to change the appearance, display an 'x'
                builder: (ctx) => MapScreen(
                      initialLocation: selectedPlace.location,
                    )));
          },
        )
      ]),
    );
  }
}
