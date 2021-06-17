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
    subtasks.add(newSubtask);
    notifyListeners();
  }
}
