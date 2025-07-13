import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/training/training_log.dart';

class TrainingLogService {
  static const String _key = 'training_logs';

  Future<List<TrainingLog>> loadLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((e) => TrainingLog.fromJson(json.decode(e))).toList();
  }

  Future<void> saveLog(TrainingLog log) async {
    final prefs = await SharedPreferences.getInstance();
    final logs = await loadLogs();
    logs.add(log);
    final encoded = logs.map((l) => json.encode(l.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }
}
