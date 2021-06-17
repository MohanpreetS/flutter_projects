import 'package:flutter/material.dart';

import './subtask.dart';

import 'package:uuid/uuid.dart';

class Task with ChangeNotifier {
  String name;
  String details = '';
  List<Subtask> subtasks = [];
  var tid;

  Task(this.name, this.tid);

  void addSubtask(String details) {
    var uid = Uuid();
    uid.v1();
    var newSubtask = Subtask(details, uid);
    subtasks.insert(0, newSubtask);
    notifyListeners();
  }

  void reorderSubtasks() {
    for (int i = 0; i < subtasks.length; i++) {
      if (subtasks[i].done) {
        final tmp = subtasks.removeAt(i);
        subtasks.add(tmp);
      }
    }
    notifyListeners();
  }
}
