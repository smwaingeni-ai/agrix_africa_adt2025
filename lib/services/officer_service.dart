import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/task_model.dart';
import '../models/assessment_model.dart';

class OfficerService {
  static Future<String> _localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _localFile(String fileName) async {
    final path = await _localPath();
    return File('$path/$fileName.json');
  }

  /// 🔹 Save task to file
  static Future<void> saveTask(TaskModel task) async {
    try {
      final file = await _localFile('tasks');
      final tasks = await loadTasks();
      tasks.add(task);
      await file.writeAsString(jsonEncode(tasks.map((t) => t.toJson()).toList()));
      print('✅ Task saved.');
    } catch (e) {
      print('❌ Error saving task: $e');
    }
  }

  /// 🔹 Load tasks
  static Future<List<TaskModel>> loadTasks() async {
    try {
      final file = await _localFile('tasks');
      if (!await file.exists()) return [];
      final contents = await file.readAsString();
      final List<dynamic> decoded = jsonDecode(contents);
      return decoded.map((e) => TaskModel.fromJson(e)).toList();
    } catch (e) {
      print('❌ Error loading tasks: $e');
      return [];
    }
  }

  /// 🔹 Save assessment
  static Future<void> saveAssessment(AssessmentModel assessment) async {
    try {
      final file = await _localFile('assessments');
      final assessments = await loadAssessments();
      assessments.add(assessment);
      await file.writeAsString(jsonEncode(assessments.map((a) => a.toJson()).toList()));
      print('✅ Assessment saved.');
    } catch (e) {
      print('❌ Error saving assessment: $e');
    }
  }

  /// 🔹 Load assessments
  static Future<List<AssessmentModel>> loadAssessments() async {
    try {
      final file = await _localFile('assessments');
      if (!await file.exists()) return [];
      final contents = await file.readAsString();
      final List<dynamic> decoded = jsonDecode(contents);
      return decoded.map((e) => AssessmentModel.fromJson(e)).toList();
    } catch (e) {
      print('❌ Error loading assessments: $e');
      return [];
    }
  }
}
