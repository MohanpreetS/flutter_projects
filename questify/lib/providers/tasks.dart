import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';

class Tasks with ChangeNotifier {
  List<Task> allTasks = [
    Task('First task', 'abcd'),
  ];

  void addTask(name) {
    var uid = Uuid();
    uid.v1();
    var newTask = Task(name, uid);
    allTasks.add(newTask);
    notifyListeners();
  }

  void toggleSubtask(tid, stid) {
    allTasks
        .firstWhere((element) => element.tid == tid)
        .subtasks
        .firstWhere((element) => element.uid == stid)
        .toggleDone();
    notifyListeners();
  }
}
