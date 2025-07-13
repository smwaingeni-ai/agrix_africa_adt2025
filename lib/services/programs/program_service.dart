import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/programs/program_log.dart';

class ProgramService {
  final String _key = 'program_logs';

  Future<List<ProgramLog>> loadLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((e) {
      try {
        return ProgramLog.fromJson(json.decode(e));
      } catch (_) {
        return null;
      }
    }).whereType<ProgramLog>().toList();
  }

  Future<void> saveProgramLog(ProgramLog log) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await loadLogs();
    existing.add(log);
    final encoded = existing.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }

  Future<void> clearAllLogs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
