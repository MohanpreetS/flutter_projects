import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tasks.dart';
import '../templates/medium_white_container.dart';
import '../screens/task_screen.dart';

class TaskTile extends StatefulWidget {
  final taskIndex;

  TaskTile(this.taskIndex);
  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    var tasks = Provider.of<Tasks>(context);
    final currentTask = tasks.allTasks[widget.taskIndex];
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => TaskScreen(widget.taskIndex),
          ),
        );
      },
      child: Container(
        // margin: EdgeInsets.symmetric(
        //   vertical: 5,
        //   horizontal: 8,
        // ),
        child: MediumWhiteContainer(
          opacity: 0.4,
          child: Container(
            height: size.height * 0.09,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: currentTask.done
                      ? Icon(
                          Icons.check_box,
                          color: Colors.pinkAccent,
                        )
                      : Icon(
                          Icons.check_box_outline_blank,
                          color: Colors.pinkAccent,
                        ),
                  onPressed: () {
                    if (!currentTask.done) {
                      tasks.toggleTaskDone(widget.taskIndex);
                      setState(() {});
                    } else {
                      tasks.toggleTaskDone(widget.taskIndex);
                      setState(() {});
                    }
                  },
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 8),
                    child: currentTask.done
                        ? Text(
                            tasks.allTasks[widget.taskIndex].name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                          )
                        : Text(
                            tasks.allTasks[widget.taskIndex].name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
