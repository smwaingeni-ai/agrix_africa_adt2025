import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/contracts/contract_application.dart';

class ContractApplicationService {
  static const String _key = 'contract_applications';

  Future<List<ContractApplication>> loadApplications(String offerId) async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_key) ?? [];

    return stored
        .map((e) => ContractApplication.fromJson(json.decode(e)))
        .where((a) => a.contractOfferId == offerId)
        .toList();
  }

  Future<void> saveApplication({
    required String offerId,
    required String farmerName,
    required String farmLocation,
    required String contactInfo,
    String farmerId = '',
    String email = '',
    String farmSize = '',
    String experience = '',
    String motivation = '',
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(_key) ?? [];

    final app = ContractApplication(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      contractOfferId: offerId,
      farmerName: farmerName,
      farmerId: farmerId,
      location: farmLocation,
      phoneNumber: contactInfo,
      email: email,
      farmSize: farmSize,
      experience: experience,
      motivation: motivation,
      appliedAt: DateTime.now(),
    );

    existing.add(json.encode(app.toJson()));
    await prefs.setStringList(_key, existing);
  }

  Future<void> clearAllApplications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
