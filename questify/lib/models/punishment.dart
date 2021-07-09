class Punishment {
  String details;
  final uid;
  bool isReason = false;
  Punishment(this.details, this.uid, this.isReason);

  void makeReason() {
    isReason = true;
  }

  void makeActual() {
    isReason = false;
  }
}
