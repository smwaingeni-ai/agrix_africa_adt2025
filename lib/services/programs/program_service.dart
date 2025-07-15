import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/programs/program_log.dart';

class ProgramService {
  final String _key = 'program_logs';

  /// Load all saved program logs from local storage
  Future<List<ProgramLog>> loadLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];

    return data.map((e) {
      try {
        return ProgramLog.fromJson(json.decode(e));
      } catch (_) {
        return null; // skip invalid entries
      }
    }).whereType<ProgramLog>().toList();
  }

  /// Save a new program log to local storage
  Future<void> saveProgramLog(ProgramLog log) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await loadLogs();

    existing.add(log);
    final encoded = existing.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }

  /// Clear all program logs from local storage
  Future<void> clearAllLogs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
