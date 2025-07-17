import 'package:flutter_test/flutter_test.dart';
import 'package:agrix_africa_adt2025/models/contracts/contract_offer.dart';

void main() {
  group('ContractOffer Model Test', () {
    test('fromJson and toJson should match', () {
      final contract = ContractOffer(
        id: 'abc123',
        title: 'Maize Contract 2025',
        description: 'Long-term maize delivery contract',
        location: 'Eastern Province',
        duration: '6 months',
        paymentTerms: 'Monthly',
        contact: 'contact@example.com',
        parties: ['Farmer Joe', 'Investor Jane'],
        isActive: true,
        postedAt: DateTime.parse('2025-07-01T10:00:00.000Z'),
        amount: 12500.00,
        cropOrLivestockType: 'Maize',
        terms: 'Delivery every 2 weeks',
      );

      final json = contract.toJson();
      final fromJson = ContractOffer.fromJson(json);

      expect(fromJson.id, contract.id);
      expect(fromJson.title, contract.title);
      expect(fromJson.description, contract.description);
      expect(fromJson.location, contract.location);
      expect(fromJson.duration, contract.duration);
      expect(fromJson.paymentTerms, contract.paymentTerms);
      expect(fromJson.contact, contract.contact);
      expect(fromJson.parties, contract.parties);
      expect(fromJson.isActive, contract.isActive);
      expect(fromJson.postedAt, contract.postedAt);
      expect(fromJson.amount, contract.amount);
      expect(fromJson.cropOrLivestockType, contract.cropOrLivestockType);
      expect(fromJson.terms, contract.terms);
    });
  });
}
