import 'dart:convert';

class InvestmentOffer {
  final String id;
  final String listingId;
  final String investorId;
  final double amount;
  final String currency;
  final int durationMonths;
  final String message;
  final DateTime offerDate;
  final bool isAccepted;

  const InvestmentOffer({
    required this.id,
    required this.listingId,
    required this.investorId,
    required this.amount,
    required this.currency,
    required this.durationMonths,
    required this.message,
    required this.offerDate,
    this.isAccepted = false,
  });

  factory InvestmentOffer.fromJson(Map<String, dynamic> json) {
    return InvestmentOffer(
      id: json['id'] ?? '',
      listingId: json['listingId'] ?? '',
      investorId: json['investorId'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'USD',
      durationMonths: json['durationMonths'] ?? 0,
      message: json['message'] ?? '',
      offerDate: DateTime.tryParse(json['offerDate'] ?? '') ?? DateTime.now(),
      isAccepted: json['isAccepted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'listingId': listingId,
      'investorId': investorId,
      'amount': amount,
      'currency': currency,
      'durationMonths': durationMonths,
      'message': message,
      'offerDate': offerDate.toIso8601String(),
      'isAccepted': isAccepted,
    };
  }

  static String encode(List<InvestmentOffer> offers) =>
      jsonEncode(offers.map((e) => e.toJson()).toList());

  static List<InvestmentOffer> decode(String jsonStr) =>
      (jsonDecode(jsonStr) as List<dynamic>)
          .map<InvestmentOffer>((e) => InvestmentOffer.fromJson(e))
          .toList();

  @override
  String toString() => 'InvestmentOffer(id: $id, listingId: $listingId, investorId: $investorId)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvestmentOffer &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          listingId == other.listingId &&
          investorId == other.investorId &&
          amount == other.amount &&
          currency == other.currency &&
          durationMonths == other.durationMonths &&
          message == other.message &&
          offerDate == other.offerDate &&
          isAccepted == other.isAccepted;

  @override
  int get hashCode =>
      id.hashCode ^
      listingId.hashCode ^
      investorId.hashCode ^
      amount.hashCode ^
      currency.hashCode ^
      durationMonths.hashCode ^
      message.hashCode ^
      offerDate.hashCode ^
      isAccepted.hashCode;
}
