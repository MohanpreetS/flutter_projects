import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../providers/tasks.dart';
import '../widgets/side_drawer.dart';
import '../widgets/slidable_tile.dart';
import '../widgets/task_tile.dart';
import '../widgets/add_button.dart';
import '../widgets/add_task_sheet.dart';
import '../widgets/edit_task_sheet.dart';
import '../widgets/reward_punishment.dart';
import '../screens/motivators_screen.dart';

class AllTasksScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _AllTasksScreenState createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var tasks = Provider.of<Tasks>(context);
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
                children: [
                  _buildHeader(() {
                    Scaffold.of(context).openEndDrawer();
                  }),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: tasks.allTasks.length,
                        itemBuilder: (_, i) {
                          return _buildTaskTile(i, tasks);
                        },
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     AddButton(() => _showAddTaskSheet(context)),
                  //   ],
                  // )
                  RewardPunishment(
                    () => _showAddTaskSheet(context),
                    () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (c) => MotivatorsScreen(true),
                        ),
                      );
                    },
                    () {
                      print('punishment click');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (c) => MotivatorsScreen(false),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskTile(i, tasks) {
    final currentTask = tasks.allTasks[i];
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 7,
      ),
      child: Slidable(
        child: TaskTile(i),
        actionPane: SlidableScrollActionPane(),
        secondaryActions: [
          SlidableTile(
            bgcolor: Colors.red,
            icon: Icons.delete,
            onTapAction: () => setState(
              () {
                tasks.allTasks.removeAt(i);
              },
            ),
          ),
          if (!currentTask.done)
            SlidableTile(
              bgcolor: Colors.green.shade400,
              icon: Icons.check,
              onTapAction: () => setState(
                () {
                  tasks.toggleTaskDone(i);
                },
              ),
            ),
          if (currentTask.done)
            SlidableTile(
              bgcolor: Colors.grey.shade400,
              icon: Icons.check_box_outline_blank,
              onTapAction: () => setState(
                () {
                  tasks.toggleTaskDone(i);
                },
              ),
            ),
          SlidableTile(
            bgcolor: Colors.blueAccent.shade700,
            icon: Icons.edit,
            onTapAction: () => setState(
              () {
                _showEditTaskSheet(
                  context,
                  currentTask.tid,
                  currentTask.name,
                  currentTask.details,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllTasksTitle() {
    return Text(
      'All Tasks',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildHeader(drawerOpen) {
    return Row(
      children: [
        SizedBox(
          width: 28,
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10),
            child: _buildAllTasksTitle(),
          ),
        ),
        IconButton(
          onPressed: drawerOpen,
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 28,
          ),
        )
      ],
    );
  }

  _showAddTaskSheet(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AnimatedPadding(
          curve: Curves.easeOut,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          duration: Duration(milliseconds: 150),
          child: AddTaskSheet(),
        );
      },
    );
  }

  _showEditTaskSheet(context, taskId, oldName, oldDetails) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AnimatedPadding(
          curve: Curves.easeOut,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          duration: Duration(milliseconds: 150),
          child: EditTaskSheet(
            taskId: taskId,
            oldTaskDetails: oldDetails,
            oldTaskName: oldName,
          ),
        );
      },
    );
  }
}
