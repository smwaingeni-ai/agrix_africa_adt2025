import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../models/contracts/contract_application.dart';

class ContractApplicationService {
  final String _key = 'contract_applications';

  Future<List<ContractApplication>> loadApplications(String offerId) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((e) {
      try {
        return ContractApplication.fromJson(json.decode(e));
      } catch (_) {
        return null;
      }
    }).whereType<ContractApplication>()
      .where((app) => app.contractOfferId == offerId)
      .toList();
  }

  Future<void> saveApplication({
    required String offerId,
    required String farmerName,
    required String farmLocation,
    required String contactInfo,
    String notes = '',
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(_key) ?? [];

    final application = ContractApplication(
      id: const Uuid().v4(),
      contractOfferId: offerId,
      farmerName: farmerName,
      farmerId: '',
      location: farmLocation,
      phoneNumber: contactInfo,
      email: '',
      farmSize: '',
      experience: '',
      motivation: notes,
      appliedAt: DateTime.now(),
    );

    existing.add(json.encode(application.toJson()));
    await prefs.setStringList(_key, existing);
  }
}
