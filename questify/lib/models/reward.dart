class Reward {
  String details;
  final uid;
  bool isReason = false;
  //enum level;
  Reward(this.details, this.uid, this.isReason);

  void makeReason() {
    isReason = true;
  }

  void makeActual() {
    isReason = false;
  }
}
