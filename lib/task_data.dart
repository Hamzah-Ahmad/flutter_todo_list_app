//import 'package:provider/provider.dart';
import "package:flutter/material.dart";
import 'package:flutter/foundation.dart';
import "models/task.dart";
import 'db_helper.dart';

class TaskData extends ChangeNotifier {
  static DB_Manager db = DB_Manager();

  List<Task> taskList = [];
  void getTasks() async {
    taskList = await db.getTaskList();
  }

  TaskData() {
    getTasks();
  }

  void addTask(Task task) {
    db.insertTask(task).then((id) {
      task.id = id;
      taskList.add(task);
      notifyListeners();
    });
  }

  void toggleTaskDone(Task task) {

    task.toggleIsDone();
    notifyListeners();
    db.updateTask(task);


  }

  void deleteTask(Task task) {
    db.deleteTask(task.id).then((id) {
      taskList.remove(task);
      notifyListeners();
    });
  }
}
