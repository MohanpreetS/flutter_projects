import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';

class Tasks with ChangeNotifier {
  List<Task> allTasks = [
    Task('First task', 'abcd'),
    Task('Second task', 'details part 2'),
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

  void reorderSubtasks(tindex) {
    allTasks[tindex].reorderSubtasks();
    notifyListeners();
  }

  void uncheckReorder(tindex) {
    allTasks[tindex].uncheckReorder();
    notifyListeners();
  }
}
