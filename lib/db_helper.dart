import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import "models/task.dart";

class DB_Manager {
  Database _database;

  Future openDB() async {
    if (_database == null) {
      _database = await openDatabase(join(await getDatabasesPath(), 'task.db'),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE task (id INTEGER NOT NULL PRIMARY KEY autoincrement, taskText TEXT, isDone BOOLEAN)');
      });
    }
  }

  Future insertTask(Task task) async {
    await openDB();
    return await _database.insert('task', task.toMap());
  }

  Future<List<Task>> getTaskList() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await _database.query('task');
    return List.generate(
      maps.length,
      (i) {
        return Task(id: maps[i]['id'], taskText: maps[i]['taskText'], isDone: (maps[i]['isDone'] == 0 ? false : true));
      },
    );
  }

  Future<void> deleteTask(int id) async {
    await openDB();
    await _database.delete('task', where: "id= ?", whereArgs: [id]);
  }


  Future<int> updateTask(Task task) async {
    await openDB();
    return await _database.update('task', task.toMap(),
        where: "id = ?", whereArgs: [task.id]);
  }


}
