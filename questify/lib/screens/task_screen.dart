import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/reward_punishment.dart';
import '../providers/tasks.dart';
import '../widgets/subtask_tile.dart';

class TaskScreen extends StatefulWidget {
  static const routeName = '/task_screen';
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    var allTasks = Provider.of<Tasks>(context).allTasks;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Task1'),
        actions: [
          IconButton(
              onPressed: () {
                allTasks[0].addSubtask('abc');
                setState(() {});
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RewardPunishment(),
          Container(
            height: size.height * 0.7,
            child: ListView.builder(
              itemBuilder: (c, i) {
                return SubtaskTile(allTasks[0].subtasks[i]);
              },
              itemCount: allTasks[0].subtasks.length,
            ),
          )
        ],
      ),
    );
  }
}
