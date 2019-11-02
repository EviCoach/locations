import 'package:flutter/material.dart';
import 'package:location_app/providers/great_places.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            }, // add the logic later
          )
        ],
      ),
      body: FutureBuilder( 
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: Center(
                  child: Text(
                      'Got no places yet, start adding some'), // static child
                ),
                builder: (ctx, greatPlaces, staticChild) =>
                    // check if list of great places is empty
                    greatPlaces.items.length <= 0
                        ? staticChild
                        : ListView.builder(
                            itemBuilder: (ctx, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.items[index].image),
                              ),
                              title: Text(greatPlaces.items[index].title),
                              onTap: () {
                                // go to the detail page
                              },
                            ),
                            itemCount: greatPlaces.items.length,
                          ),
              ),
      ),
    );
  }
}
