import 'package:flutter/material.dart';

import './subtask.dart';
import './punishment.dart';
import './reward.dart';

import 'package:uuid/uuid.dart';

class Task with ChangeNotifier {
  String name;
  String details = '';
  List<Subtask> subtasks = [];
  int doneSubtasks = 0;
  List<Reward> rewards = [
    // Reward('first reward'),
    // Reward('Second reward'),
  ];
  List<Punishment> punishments = [];

  bool done = false;
  var tid;

  Task(this.name, this.tid);

  void addReward(String details) {
    var uid = Uuid();
    uid.v1();
    rewards.add(Reward(details, uid, false));
    notifyListeners();
  }

  void addPunishment(String details) {
    var uid = Uuid();
    uid.v1();
    punishments.add(Punishment(details, uid, false));
    notifyListeners();
  }

  void toggleDoneTask() {
    if (done) {
      done = false;
    } else {
      done = true;
      for (int x = 0; x < subtasks.length; x++) {
        if (!subtasks[x].done) {
          subtasks[x].toggleDone();
        }
      }
    }

    notifyListeners();
  }

  void addSubtask(String name) {
    var uid = Uuid();
    uid.v1();
    var newSubtask = Subtask(name, uid);
    subtasks.insert(subtasks.length - doneSubtasks, newSubtask);
    notifyListeners();
  }

  void editSubtask(uid, newDetails) {
    final sIndex = subtasks.indexWhere((element) => element.uid == uid);
    subtasks[sIndex].details = newDetails;
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
