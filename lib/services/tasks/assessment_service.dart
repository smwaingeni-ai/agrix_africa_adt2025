import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/tasks/officer_assessment.dart';

class AssessmentService {
  final String _key = 'officer_assessments';

  /// Load all saved assessments from local storage
  Future<List<OfficerAssessment>> loadAssessments() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];

    return data.map((e) {
      try {
        return OfficerAssessment.fromJson(json.decode(e));
      } catch (_) {
        return null; // skip invalid/corrupt entries
      }
    }).whereType<OfficerAssessment>().toList();
  }

  /// Save a new officer assessment log
  Future<void> saveAssessment(OfficerAssessment a) async {
    final prefs = await SharedPreferences.getInstance();
    final current = await loadAssessments();

    current.insert(0, a); // most recent first
    final encoded = current.map((a) => json.encode(a.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }

  /// Optional: Clear all assessments (for testing or admin reset)
  Future<void> clearAssessments() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
