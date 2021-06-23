import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tasks.dart';
import '../widgets/side_drawer.dart';
import '../templates/medium_white_container.dart';
import '../widgets/task_tile.dart';
import '../widgets/add_button.dart';

class AllTasksScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _AllTasksScreenState createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var task = Provider.of<Tasks>(context);
    Widget _buildTaskTitle() {
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
              child: _buildTaskTitle(),
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
                children: [
                  _buildHeader(() {
                    Scaffold.of(context).openEndDrawer();
                  }),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: task.allTasks.length,
                        itemBuilder: (_, i) {
                          return TaskTile(i);
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AddButton(() {}),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
