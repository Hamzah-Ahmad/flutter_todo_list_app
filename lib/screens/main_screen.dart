import 'package:flutter/material.dart';
import 'task_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todo_list_app/task_data.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String date = DateFormat('d').format(now);
    String month = DateFormat('MMMM').format(now);
    String day = DateFormat('EEEE').format(now);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        day,
                        style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            month,
                            style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            date,
                            style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w500),
                          ),

                        ],
                      ),
                      SizedBox(height: 10,),
                      Text(
                          'Tasks: ${Provider.of<TaskData>(context).taskList.length.toString()}',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],

                  ),
                ),
                margin: EdgeInsets.only(top: 10, bottom: 5),
              ),
              Expanded(
                child: Container(
                  child: TaskList(),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0))),
                ),
              ),
            ]),
      ),
    );
  }
}
