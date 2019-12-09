import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_todo_list_app/task_data.dart';

class TaskTile extends StatelessWidget {
  final String taskText;
  final bool taskIsDone;
  final Function toggleTaskDone;
  final Function deleteTask;
  TaskTile({this.taskText, this.taskIsDone, this.toggleTaskDone, this.deleteTask});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(taskText),
      trailing: Checkbox(
        value: taskIsDone,
        onChanged: toggleTaskDone,
      ),
      onLongPress: deleteTask,
    );
  }
}
