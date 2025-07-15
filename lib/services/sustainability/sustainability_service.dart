import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/sustainability/sustainability_log.dart';

class SustainabilityService {
  final String _key = 'sustainability_logs';

  /// Load all sustainability logs from local storage
  Future<List<SustainabilityLog>> loadLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_key) ?? [];

    return rawList.map((e) {
      try {
        return SustainabilityLog.fromJson(json.decode(e));
      } catch (_) {
        return null; // gracefully skip invalid entries
      }
    }).whereType<SustainabilityLog>().toList();
  }

  /// Save a new sustainability log
  Future<void> saveLog(SustainabilityLog log) async {
    final prefs = await SharedPreferences.getInstance();
    final logs = await loadLogs();

    logs.insert(0, log); // add newest at the top
    final encoded = logs.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }

  /// Clear all sustainability logs
  Future<void> clearLogs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
