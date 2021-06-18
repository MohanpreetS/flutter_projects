import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/subtask.dart';
import '../providers/tasks.dart';

class SubtaskTile extends StatefulWidget {
  Subtask subtask;
  int taskIndex;

  SubtaskTile(this.subtask, this.taskIndex);
  @override
  _SubtaskTileState createState() => _SubtaskTileState();
}

class _SubtaskTileState extends State<SubtaskTile> {
  @override
  Widget build(BuildContext context) {
    var tasks = Provider.of<Tasks>(context);
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
          tasks.reorderSubtasks(widget.taskIndex);
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
