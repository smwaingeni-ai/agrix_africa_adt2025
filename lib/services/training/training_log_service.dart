import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/training/training_log.dart';

class TrainingLogService {
  static const String _key = 'training_logs';

  /// Load all saved training logs
  Future<List<TrainingLog>> loadLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((e) {
      try {
        return TrainingLog.fromJson(json.decode(e));
      } catch (_) {
        return null;
      }
    }).whereType<TrainingLog>().toList();
  }

  /// Save a new training log
  Future<void> saveLog(TrainingLog log) async {
    final prefs = await SharedPreferences.getInstance();
    final logs = await loadLogs();
    logs.insert(0, log); // newest first
    final encoded = logs.map((l) => json.encode(l.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }

  /// Optional: clear all training logs (admin/debug)
  Future<void> clearLogs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
