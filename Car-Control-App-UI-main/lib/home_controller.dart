import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  bool isRightDoorLock = true;
  bool isLeftDoorLock = true;
  bool isBonnetLock = true;
  bool isTrunkLock = true;

  int selectedBottomTab = 0;

  void onBottomNavTabChange(int index) {
    selectedBottomTab = index;
    notifyListeners();
  }

  void updateRightDoorLock() {
    isRightDoorLock = !isRightDoorLock;
    notifyListeners();
  }

  void updateLeftDoorLock() {
    isLeftDoorLock = !isLeftDoorLock;
    notifyListeners();
  }

  void updateBonnetLock() {
    isBonnetLock = !isBonnetLock;
    notifyListeners();
  }

  void updateTrunkLock() {
    isTrunkLock = !isTrunkLock;
    notifyListeners();
  }
}
