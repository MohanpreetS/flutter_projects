import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/reward_punishment.dart';
import '../providers/tasks.dart';
import '../widgets/subtask_tile.dart';
import '../widgets/add_task_dialog.dart';

class TaskScreen extends StatefulWidget {
  var taskIndex = 0;
  static const routeName = '/task_screen';
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    var tasks = Provider.of<Tasks>(context);
    var size = MediaQuery.of(context).size;
    var random = Random();
    void showAddDialog(context) {
      showDialog(
        context: context,
        builder: (context) {
          return AddTaskDialog(
            taskIndex: widget.taskIndex,
          );
        },
      ).then((value) {
        setState(() {});
      });
    }

    Widget _buildSubtaskList() {
      return Expanded(
        child: Container(
          child: ListView.builder(
            itemBuilder: (c, i) {
              return SubtaskTile(tasks.allTasks[widget.taskIndex].subtasks[i],
                  widget.taskIndex);
            },
            itemCount: tasks.allTasks[widget.taskIndex].subtasks.length,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Task1'),
        actions: [
          IconButton(
            onPressed: () {
              // tasks.allTasks[0]
              //     .addSubtask('Random Task number ${random.nextInt(100)}');
              showAddDialog(context);
              tasks.allTasks[widget.taskIndex].reorderSubtasks();
              setState(() {});
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/luke-chesser-PHtp0cDBJSM-unsplash.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 8,
              ),
              _buildSubtaskList(),
              RewardPunishment(),
            ],
          ),
        ),
      ),
    );
  }
}
