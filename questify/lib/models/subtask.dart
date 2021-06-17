class Subtask {
  String details;
  bool done = false;
  var uid;

  Subtask(this.details, this.uid);

  void toggleDone() {
    done = !done;
  }
}
