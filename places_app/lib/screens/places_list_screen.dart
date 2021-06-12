import 'package:flutter/material.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('places'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
