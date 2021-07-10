import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:questify/widgets/punishment_sheet.dart';

import '../widgets/reward_punishment.dart';
import '../providers/tasks.dart';
import '../widgets/subtask_tile.dart';
import '../widgets/add_subtask_dialog.dart';
import '../widgets/side_drawer.dart';
import '../widgets/slidable_tile.dart';
import '../widgets/reward_sheet.dart';
import '../widgets/punishment_sheet.dart';
import '../widgets/edit_subtask_dialog.dart';

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
    final currentTask = tasks.allTasks[widget.taskIndex];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      endDrawer: SideDrawer(),
      body: Builder(
        builder: (context) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background1.jpg'),
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
                    child: _buildHeader(
                      () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      currentTask,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  if (currentTask.details != '')
                    Text(
                      currentTask.details,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  if (currentTask.details != '')
                    SizedBox(
                      height: 8,
                    ),
                  _buildSubtaskList(currentTask),
                  RewardPunishment(
                      () => addNewSubtask(currentTask),
                      () => _showRewardSheet(context, currentTask),
                      () => _showPunishmentSheet(context, currentTask)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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

  void addNewSubtask(currentTask) {
    showAddDialog(context);
    currentTask.reorderSubtasks();
    setState(() {});
  }

  void showEditDialog(context, initialValue, subtaskId) {
    showDialog(
      context: context,
      builder: (context) {
        return EditSubtaskDialog(
          taskIndex: widget.taskIndex,
          initialVal: initialValue,
          subtaskId: subtaskId,
        );
      },
    ).then((value) {
      setState(() {});
    });
  }

  Widget _buildSubtaskList(currentTask) {
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
                child: SubtaskTile(currentTask.subtasks[i], widget.taskIndex),
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
                  SlidableTile(
                    bgcolor: Colors.blueAccent.shade700,
                    icon: Icons.edit,
                    onTapAction: () => setState(
                      () {
                        showEditDialog(
                          context,
                          currentTask.subtasks[i].details,
                          currentTask.subtasks[i].uid,
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
          itemCount: currentTask.subtasks.length,
        ),
      ),
    );
  }

  Widget _buildTaskTitle(currentTask) {
    return Text(
      currentTask.name,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildHeader(drawer_open, currentTask) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10),
            child: _buildTaskTitle(currentTask),
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

  _showRewardSheet(context, currentTask) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AnimatedPadding(
          curve: Curves.easeOut,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          duration: Duration(milliseconds: 150),
          child: RewardSheet(currentTask),
        );
      },
    );
  }

  _showPunishmentSheet(context, currentTask) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AnimatedPadding(
          curve: Curves.easeOut,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          duration: Duration(milliseconds: 150),
          child: PunishmentSheet(currentTask),
        );
      },
    );
  }
}
