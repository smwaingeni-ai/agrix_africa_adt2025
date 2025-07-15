import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/log_entry.dart';

class LogService {
  /// 🔹 Get reference to the logbook file
  static Future<File> _getLogFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/logbook.json');
  }

  /// 🔹 Load log entries from file
  static Future<List<LogEntry>> loadLogs() async {
    try {
      final file = await _getLogFile();
      if (!await file.exists()) return [];
      final content = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(content);
      return jsonList.map((e) => LogEntry.fromJson(e)).toList();
    } catch (e) {
      print('❌ Error loading logs: $e');
      return [];
    }
  }

  /// 🔹 Save a new log entry
  static Future<void> saveLog(LogEntry entry) async {
    try {
      final file = await _getLogFile();
      List<LogEntry> logs = await loadLogs();
      logs.add(entry);
      final updatedJson = jsonEncode(logs.map((e) => e.toJson()).toList());
      await file.writeAsString(updatedJson, flush: true);
      print('✅ Log saved at ${file.path}');
    } catch (e) {
      print('❌ Error saving log: $e');
    }
  }

  /// 🔹 Clear all logs
  static Future<void> clearLogs() async {
    try {
      final file = await _getLogFile();
      if (await file.exists()) {
        await file.delete();
        print('🗑️ Logs cleared.');
      }
    } catch (e) {
      print('❌ Error clearing logs: $e');
    }
  }
}
