import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableTile extends StatefulWidget {
  final onTapAction;
  final bgcolor;
  final icon;

  SlidableTile({this.bgcolor, this.icon, this.onTapAction});

  @override
  _SlidableTileState createState() => _SlidableTileState();
}

class _SlidableTileState extends State<SlidableTile> {
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IconSlideAction(
          foregroundColor: Colors.white,
          color: widget.bgcolor,
          icon: widget.icon,
          onTap: widget.onTapAction,
        ),
      ),
    );
  }
}
