import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../widgets/reward_punishment.dart';
import '../providers/tasks.dart';
import '../widgets/subtask_tile.dart';
import '../widgets/add_subtask_dialog.dart';
import '../widgets/side_drawer.dart';
import '../widgets/slidable_tile.dart';
import '../widgets/reward_sheet.dart';

class TaskScreen extends StatefulWidget {
  final taskIndex;
  static const routeName = '/task_screen';

  TaskScreen(this.taskIndex);
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  _showRewardSheet(context, rewards) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return RewardSheet(rewards);
        });
  }

  @override
  Widget build(BuildContext context) {
    var tasks = Provider.of<Tasks>(context);
    var size = MediaQuery.of(context).size;
    var random = Random();
    final currentTask = tasks.allTasks[widget.taskIndex];
    void showAddDialog(context) {
      showDialog(
        context: context,
        builder: (context) {
          return AddSubtaskDialog(
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
              return Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 6,
                  ),
                  child: Slidable(
                    child:
                        SubtaskTile(currentTask.subtasks[i], widget.taskIndex),
                    actionPane: SlidableScrollActionPane(),
                    secondaryActions: [
                      SlidableTile(
                        bgcolor: Colors.red,
                        icon: Icons.delete,
                        onTapAction: () => setState(
                          () {
                            currentTask.subtasks.removeAt(i);
                          },
                        ),
                      ),
                      if (!currentTask.subtasks[i].done)
                        SlidableTile(
                          bgcolor: Colors.green.shade400,
                          icon: Icons.check,
                          onTapAction: () => setState(
                            () {
                              currentTask.subtasks[i].toggleDone();
                            },
                          ),
                        ),
                      if (currentTask.subtasks[i].done)
                        SlidableTile(
                          bgcolor: Colors.grey.shade400,
                          icon: Icons.check_box_outline_blank,
                          onTapAction: () => setState(
                            () {
                              currentTask.subtasks[i].toggleDone();
                            },
                          ),
                        ),
                    ],
                  ));
            },
            itemCount: currentTask.subtasks.length,
          ),
        ),
      );
    }

    void addNewSubtask() {
      showAddDialog(context);
      currentTask.reorderSubtasks();
      setState(() {});
    }

    Widget _buildTaskTitle() {
      return Text(
        currentTask.name,
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
                  RewardPunishment(
                    addNewSubtask,
                    () => _showRewardSheet(context, currentTask.rewards),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// Dismissible(
//                   direction: DismissDirection.endToStart,
//                   background: Container(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 10.0),
//                       child: Icon(
//                         Icons.delete,
//                         color: Colors.white,
//                       ),
//                     ),
//                     alignment: Alignment.centerRight,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16),
//                       color: Colors.red,
//                     ),
//                   ),
//                   key: Key(currentTask.subtasks[i].uid.toString()),
//                   onDismissed: (direction) {
//                     if (direction == DismissDirection.endToStart) {
//                       setState(() {
//                         currentTask.subtasks.removeAt(i);
//                       });
//                     } else if (direction == DismissDirection.startToEnd) {
//                       setState(() {
//                         currentTask.subtasks[i].toggleDone();
//                       });
//                     }
//                   },
//                   child: SubtaskTile(currentTask.subtasks[i], widget.taskIndex),
//                 ),