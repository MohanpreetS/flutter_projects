import 'package:flutter/material.dart';

import './subtask.dart';

import 'package:uuid/uuid.dart';

class Task with ChangeNotifier {
  String name;
  String details = '';
  List<Subtask> subtasks = [];
  int doneSubtasks = 0;
  var tid;

  Task(this.name, this.tid);

  void addSubtask(String name) {
    var uid = Uuid();
    uid.v1();
    var newSubtask = Subtask(name, uid);
    subtasks.insert(0, newSubtask);
    notifyListeners();
  }

  void updateDoneSubtasks() {
    int tmp = 0;
    for (int j = 0; j < subtasks.length; j++) {
      if (subtasks[j].done) {
        tmp++;
      }
    }
    doneSubtasks = tmp;
  }

  void reorderSubtasks() {
    updateDoneSubtasks();
    for (int i = 0; i < subtasks.length; i++) {
      if (subtasks[i].done) {
        final tmp = subtasks.removeAt(i);
        subtasks.insert(subtasks.length - doneSubtasks + 1, tmp);
        break;
      }
    }
    notifyListeners();
  }

  void uncheckReorder() {
    updateDoneSubtasks();
    for (int i = subtasks.length - doneSubtasks; i < subtasks.length; i++) {
      if (!subtasks[i].done) {
        final tmp = subtasks.removeAt(i);
        subtasks.insert(0, tmp);
        break;
      }
    }
  }
}
