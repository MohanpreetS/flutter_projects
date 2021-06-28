import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/subtask.dart';
import '../providers/tasks.dart';

class SubtaskTile extends StatefulWidget {
  final Subtask subtask;
  final int taskIndex;

  SubtaskTile(this.subtask, this.taskIndex);
  @override
  _SubtaskTileState createState() => _SubtaskTileState();
}

class _SubtaskTileState extends State<SubtaskTile> {
  @override
  Widget build(BuildContext context) {
    var tasks = Provider.of<Tasks>(context);
    return Container(
      decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     blurRadius: 2,
          //     spreadRadius: 1,
          //     color: Colors.black.withOpacity(0.05),
          //     offset: Offset(-1, 4),
          //   )
          // ],
          ),
      //margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 14,
            sigmaY: 14,
          ),
          child: Container(
            //margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.35),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: 1,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            child: _buildListTile(
              tasks,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(tasks) {
    return ListTile(
      leading: Container(
        child: IconButton(
          icon: widget.subtask.done
              ? Icon(
                  Icons.check_box,
                  color: Colors.pinkAccent,
                )
              : Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.pinkAccent,
                ),
          onPressed: () {
            if (!widget.subtask.done) {
              widget.subtask.toggleDone();
              tasks.reorderSubtasks(widget.taskIndex);
              setState(() {});
            } else {
              widget.subtask.toggleDone();
              tasks.uncheckReorder(widget.taskIndex);
              setState(() {});
            }
          },
        ),
      ),
      title: widget.subtask.done
          ? Text(
              widget.subtask.details,
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.white,
              ),
            )
          : Text(
              widget.subtask.details,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
    );
  }
}
