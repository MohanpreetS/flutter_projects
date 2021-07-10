import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/punishment.dart';
import '../models/reward.dart';

class Motivators with ChangeNotifier {
  List<Reward> rewards = [
    Reward("This is a concrete reward like watching netflix", 'abcd', false),
    Reward("This is a concrete reward like watching netflix 2", 'abc', false),
    Reward("This is a reason reward like passing an exam/course", 'aaa', true),
    Reward(
        "This is a reason reward like passing an exam/course 2", 'bbb', true),
    Reward("This is a concrete reward like watching netflix 3", 'abcde', false),
    Reward(
        "This is a reason reward like passing an exam/course 3", 'ccc', true),
  ];
  List<Punishment> punishments = [
    Punishment(
        "This is a concrete reward like watching netflix", 'abcd', false),
    Punishment(
        "This is a concrete reward like watching netflix 2", 'abc', false),
    Punishment(
        "This is a reason reward like passing an exam/course", 'aaa', true),
    Punishment(
        "This is a reason reward like passing an exam/course 2", 'bbb', true),
    Punishment(
        "This is a concrete reward like watching netflix 3", 'abcde', false),
    Punishment(
        "This is a reason reward like passing an exam/course 3", 'ccc', true),
  ];

  void addReward(details, isReason) {
    var uid = Uuid();
    uid.v1();
    rewards.add(Reward(details, uid, isReason));
    notifyListeners();
  }

  void addPunishment(details, isReason) {
    var uid = Uuid();
    uid.v1();
    punishments.add(Punishment(details, uid, isReason));
    notifyListeners();
  }
}
