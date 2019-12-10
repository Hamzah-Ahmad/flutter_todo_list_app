import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_todo_list_app/task_data.dart';
import '../widgets/task_tile.dart';
import 'package:flutter_todo_list_app/models/task.dart';

class TaskList extends StatelessWidget {
  final textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                focusNode: myFocusNode,
                controller: textController,
                decoration: InputDecoration(
                  hintText: "Add Tasks",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {

                        Task newTask = Task(taskText: textController.text);
                        Provider.of<TaskData>(context).addTask(newTask);

                        // Future was used in the following syntax because it is a recommended method to clear the field and dismiss the keyboard.
                        // using textController.clear alone was causing an error. And while using the WidgetBinding method shown below did work, but then the keyboard was not losing focus (the keyboard was not dismissing)
                        Future.delayed(Duration(milliseconds: 50)).then((_) {
                          textController.clear();
                          FocusScope.of(context).unfocus();
                        });
                        //myFocusNode.unfocus();
                        //WidgetsBinding.instance.addPostFrameCallback((_) => textController.clear());
                        //textController.clear();
                      }
                    },
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 0, left: 20, right: 20, bottom: 10),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final task = Provider.of<TaskData>(context).taskList[index];
                  return Card(
                    child: TaskTile(
                      taskText: task.taskText,
                      taskIsDone: task.isDone,
                      toggleTaskDone: (checkboxState) {
                        Provider.of<TaskData>(context).toggleTaskDone(task);
                      },
                      deleteTask: () {
                        Provider.of<TaskData>(context).deleteTask(task);
                      },
                    ),
                  );
                },
                itemCount: Provider.of<TaskData>(context).taskList.length,
                shrinkWrap: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Using this:
// deleteTask: Provider.of<TaskData>(context).deleteTask(task);
// gave me a "The expression here has a type of void and therefore can't be used.
// I've figured out why. In the expression above, I'm trying to assign the deleteTask variable with the result of the Provider...deleteTask function (which is void since the function returns void), not the function itself. The proper way is to done what I did in the main code, because over there I'm assigning the deleteTask variable with a function that calls the Provider....deleteTask function, which is the functionality we actually want.

//onPressed: () {
//              FocusScope.of(context).requestFocus(myFocusNode);
//            },
