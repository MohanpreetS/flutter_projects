import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/reward_punishment.dart';
import '../providers/tasks.dart';
import '../widgets/subtask_tile.dart';
import '../widgets/add_task_dialog.dart';
import '../widgets/side_drawer.dart';

class TaskScreen extends StatefulWidget {
  final taskIndex;
  static const routeName = '/task_screen';

  TaskScreen(this.taskIndex);
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

    void addNewSubtask() {
      showAddDialog(context);
      tasks.allTasks[widget.taskIndex].reorderSubtasks();
      setState(() {});
    }

    Widget _buildTaskTitle() {
      return Text(
        tasks.allTasks[widget.taskIndex].name,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }

    Widget _buildHeader(drawer_open) {
      return Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: _buildTaskTitle(),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: drawer_open,
            icon: Icon(
              Icons.menu_rounded,
              color: Colors.white,
              size: 30,
            ),
          )
        ],
      );
    }

    return Scaffold(
      endDrawer: SideDrawer(),
      body: Builder(
        builder: (context) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/luke-chesser-PHtp0cDBJSM-unsplash.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Container(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8, left: 5),
                    child: _buildHeader(() {
                      Scaffold.of(context).openEndDrawer();
                    }),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  _buildSubtaskList(),
                  RewardPunishment(addNewSubtask),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
