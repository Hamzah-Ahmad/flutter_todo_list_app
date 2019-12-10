import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "task_data.dart";
import 'screens/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskData>(
      create: (context) => TaskData(),
      child: MaterialApp(
        title: 'Flutter Demo',
//        theme: ThemeData.dark().copyWith(
//          primaryColor: Color(0xff080a1f),
//        ),

        home: MainScreen(),
      ),
    );
  }
}

