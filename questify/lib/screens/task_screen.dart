import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/reward_punishment.dart';
import '../providers/tasks.dart';
import '../widgets/subtask_tile.dart';
import '../widgets/add_task_dialog.dart';

class TaskScreen extends StatefulWidget {
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
          return AddTaskDialog();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Task1'),
        actions: [
          IconButton(
              onPressed: () {
                tasks.allTasks[0]
                    .addSubtask('Random Task number ${random.nextInt(100)}');
                //showAddDialog(context);
                tasks.allTasks[0].reorderSubtasks();
                setState(() {});
              },
              icon: Icon(Icons.add))
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
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemBuilder: (c, i) {
                      return SubtaskTile(tasks.allTasks[0].subtasks[i], 0);
                    },
                    itemCount: tasks.allTasks[0].subtasks.length,
                  ),
                ),
              ),
              RewardPunishment(),
            ],
          ),
        ),
      ),
    );
  }
}
