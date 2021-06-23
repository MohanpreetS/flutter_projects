import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/task_screen.dart';
import './screens/all_tasks_screen.dart';
import './providers/tasks.dart';
import './models/task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => Tasks()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          //TaskScreen.routeName: (_) => TaskScreen(),
          AllTasksScreen.routeName: (_) => AllTasksScreen(),
        },
      ),
    );
  }
}
