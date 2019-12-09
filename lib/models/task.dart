class Task {
  int id;
  String taskText;
  bool isDone;

  Task({this.id, this.taskText, this.isDone = false});

  void toggleIsDone() {
    isDone = !isDone;
  }

  Map<String, dynamic> toMap() {
    return {"taskText": taskText, "isDone": isDone};
  }
}