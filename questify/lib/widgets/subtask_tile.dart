import 'package:flutter/material.dart';
import '../models/subtask.dart';

class SubtaskTile extends StatefulWidget {
  Subtask subtask;

  SubtaskTile(this.subtask);
  @override
  _SubtaskTileState createState() => _SubtaskTileState();
}

class _SubtaskTileState extends State<SubtaskTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: widget.subtask.done
            ? Icon(
                Icons.check_box,
                color: Colors.green.shade400,
              )
            : Icon(
                Icons.check_box_outline_blank,
                color: Colors.red.shade300,
              ),
        onPressed: () {
          widget.subtask.toggleDone();
          setState(() {});
        },
      ),
      title: widget.subtask.done
          ? Text(
              widget.subtask.details,
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
              ),
            )
          : Text(widget.subtask.details),
    );
  }
}
