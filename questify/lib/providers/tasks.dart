import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';

class Tasks with ChangeNotifier {
  List<Task> allTasks = [];
  int doneTasks = 0;

  void addTask(name) {
    var uid = Uuid();
    uid.v1();
    var newTask = Task(name, uid);
    allTasks.add(newTask);
    notifyListeners();
  }

  void addTaskWithDetails(name, details) {
    var uid = Uuid();
    uid.v1();
    var newTask = Task(name, uid);
    newTask.details = details;
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

  void updateDoneTasks() {
    int tmp = 0;
    for (int j = 0; j < allTasks.length; j++) {
      if (allTasks[j].done) {
        tmp++;
      }
    }
    doneTasks = tmp;
    print(doneTasks);
  }

  void reorderTasks() {
    updateDoneTasks();
    for (int i = 0; i < allTasks.length; i++) {
      if (allTasks[i].done) {
        final tmp = allTasks.removeAt(i);
        allTasks.insert(allTasks.length - doneTasks + 1, tmp);
        //allTasks.add(tmp);
        break;
      }
    }
    notifyListeners();
  }

  void editTask(tid, newName, newDetails) {
    final tIndex = allTasks.indexWhere((element) => element.tid == tid);
    allTasks[tIndex].name = newName;
    allTasks[tIndex].details = newDetails;
    notifyListeners();
  }

  void uncheckReorderTasks() {
    updateDoneTasks();
    for (int i = allTasks.length - doneTasks; i < allTasks.length; i++) {
      if (!allTasks[i].done) {
        final tmp = allTasks.removeAt(i);
        allTasks.insert(0, tmp);
        break;
      }
    }
  }

  void toggleTaskDone(int i) {
    allTasks[i].toggleDoneTask();
    if (allTasks[i].done) {
      reorderTasks();
    } else {
      uncheckReorderTasks();
    }
    notifyListeners();
  }
}
