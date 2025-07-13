import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/sustainability/sustainability_log.dart';

class SustainabilityService {
  final String _key = 'sustainability_logs';

  Future<List<SustainabilityLog>> loadLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_key) ?? [];
    return rawList
        .map((e) => SustainabilityLog.fromJson(json.decode(e)))
        .toList();
  }

  Future<void> saveLog(SustainabilityLog log) async {
    final prefs = await SharedPreferences.getInstance();
    final logs = await loadLogs();
    logs.insert(0, log);
    final encoded = logs.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }

  Future<void> clearLogs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
