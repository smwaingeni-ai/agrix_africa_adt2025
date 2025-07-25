import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:agrix_africa_adt2025/models/tasks/task_model.dart';

class TaskService {
  static const _key = 'officer_tasks';

  /// Load all tasks from local storage
  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_key) ?? [];
    return rawList.map((e) {
      try {
        return Task.fromJson(json.decode(e));
      } catch (_) {
        return null;
      }
    }).whereType<Task>().toList();
  }

  /// Save a new task
  Future<void> saveTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = await loadTasks();

    if (task.id.isEmpty) {
      task.id = const Uuid().v4();
    }

    tasks.insert(0, task); // Add to top
    final updated = tasks.map((t) => json.encode(t.toJson())).toList();
    await prefs.setStringList(_key, updated);
  }

  /// Delete a task by ID
  Future<void> deleteTask(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = await loadTasks();
    final filtered = tasks.where((t) => t.id != id).toList();
    final updated = filtered.map((t) => json.encode(t.toJson())).toList();
    await prefs.setStringList(_key, updated);
  }

  /// Update a task (match by ID)
  Future<void> updateTask(Task updatedTask) async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = await loadTasks();
    final newList = tasks.map((t) => t.id == updatedTask.id ? updatedTask : t).toList();
    final encoded = newList.map((t) => json.encode(t.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }

  /// Optional: Clear all tasks (for admin reset)
  Future<void> clearTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
