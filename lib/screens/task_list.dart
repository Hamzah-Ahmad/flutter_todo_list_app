import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_todo_list_app/task_data.dart';
import '../widgets/task_tile.dart';
import 'package:flutter_todo_list_app/models/task.dart';

class TaskList extends StatelessWidget {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: textController,
              ),
              FlatButton(
                color: Colors.blue,
                onPressed: (){
                  Task newTask = Task(taskText: textController.text);
                  Provider.of<TaskData>(context).addTask(newTask);
                  textController.clear();
                },
              ),
              Flexible(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final task = Provider.of<TaskData>(context).taskList[index];
                    return TaskTile(
                      taskText: task.taskText,
                      taskIsDone: task.isDone,
                      toggleTaskDone: (checkboxState) {
                        Provider.of<TaskData>(context).toggleTaskDone(task);
                      },
                      deleteTask: () {
                        Provider.of<TaskData>( context).deleteTask(task);
                      },
                    );
                  },
                  itemCount: Provider.of<TaskData>(context).taskList.length,
                  shrinkWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Using this:
// deleteTask: Provider.of<TaskData>(context).deleteTask(task);
// gave me a "The expression here has a type of void and therefore can't be used.
// I've figured out why. In the expression above, I'm trying to assign the deleteTask variable with the result of the Provider...deleteTask function (which is void since the function returns void), not the function itself. The proper way is to done what I did in the main code, because over there I'm assigning the deleteTask variable with a function that calls the Provider....deleteTask function, which is the functionality we actually want.