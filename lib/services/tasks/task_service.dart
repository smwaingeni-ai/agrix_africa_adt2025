import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../models/tasks/task.dart';

class TaskService {
  static const _key = 'officer_tasks';

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_key) ?? [];
    return rawList.map((e) => Task.fromJson(json.decode(e))).toList();
  }

  Future<void> saveTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = await loadTasks();

    if (task.id.isEmpty) {
      task.id = const Uuid().v4();
    }

    tasks.add(task);
    final updated = tasks.map((t) => json.encode(t.toJson())).toList();
    await prefs.setStringList(_key, updated);
  }

  Future<void> deleteTask(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = await loadTasks();
    final filtered = tasks.where((t) => t.id != id).toList();
    final updated = filtered.map((t) => json.encode(t.toJson())).toList();
    await prefs.setStringList(_key, updated);
  }

  Future<void> updateTask(Task updatedTask) async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = await loadTasks();
    final newList = tasks.map((t) => t.id == updatedTask.id ? updatedTask : t).toList();
    final encoded = newList.map((t) => json.encode(t.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }
}
