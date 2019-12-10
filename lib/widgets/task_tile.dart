import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';

class TaskTile extends StatelessWidget {
  final String taskText;
  final bool taskIsDone;
  final Function toggleTaskDone;
  final Function deleteTask;
  TaskTile({this.taskText, this.taskIsDone, this.toggleTaskDone, this.deleteTask});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(taskText, style: TextStyle(decoration: (taskIsDone ? TextDecoration.lineThrough: null)),),
      trailing: CircularCheckBox(
        value: taskIsDone,
        onChanged: toggleTaskDone,
      ),
      onLongPress: deleteTask,
      onTap: (){
        //the toggle task state requires a boolean argument. In the onChanged above, the boolean value of the checkbox is automatically passed to the function, so we didn't have to use it there.
        toggleTaskDone(!taskIsDone);
      }
    );
  }
}
