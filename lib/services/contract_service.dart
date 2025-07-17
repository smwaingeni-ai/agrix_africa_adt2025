import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/contracts/contract_offer.dart';

class ContractService {
  static Future<List<ContractOffer>> loadContracts() async {
    final String response = await rootBundle.loadString('lib/data/sample_contracts.json');
    final List<dynamic> data = json.decode(response);
    return data.map((item) => ContractOffer.fromJson(item)).toList();
  }
}
