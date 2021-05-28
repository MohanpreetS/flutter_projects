import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function chooser;
  final String ansText;
  Answer(this.chooser, this.ansText);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          child: Text(ansText),
          onPressed: chooser,
          style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent, onPrimary: Colors.white)
          //color: Colors.blue,
          //textColor: Colors.white,
          ),
    );
  }
}
