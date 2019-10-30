import 'package:flutter/material.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
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
//                        contentPadding: EdgeInsets.all(),
                      ),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10),
                    ImageInput(),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton.icon(
                  onPressed: () {},
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
