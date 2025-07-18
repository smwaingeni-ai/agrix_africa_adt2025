import 'dart:convert';

class InvestmentOffer {
  final String id;
  final String listingId; // ✅ Required for all offers
  final String investorId;
  final String investorName;
  final String contact;
  final double amount;
  final String currency;
  final int durationMonths;
  final String term;
  final double interestRate;
  final String message;
  final DateTime offerDate;
  final DateTime timestamp;
  final bool isAccepted;

  const InvestmentOffer({
    required this.id,
    required this.listingId,
    required this.investorId,
    required this.investorName,
    required this.contact,
    required this.amount,
    required this.currency,
    required this.durationMonths,
    required this.term,
    required this.interestRate,
    required this.message,
    required this.offerDate,
    required this.timestamp,
    this.isAccepted = false,
  });

  /// Creates an empty InvestmentOffer
  factory InvestmentOffer.empty() => InvestmentOffer(
        id: '',
        listingId: '',
        investorId: '',
        investorName: '',
        contact: '',
        amount: 0.0,
        currency: 'USD',
        durationMonths: 0,
        term: '',
        interestRate: 0.0,
        message: '',
        offerDate: DateTime.now(),
        timestamp: DateTime.now(),
        isAccepted: false,
      );

  /// Deserialize from JSON
  factory InvestmentOffer.fromJson(Map<String, dynamic> json) {
    final now = DateTime.now();
    return InvestmentOffer(
      id: json['id'] ?? '',
      listingId: json['listingId'] ?? '',
      investorId: json['investorId'] ?? '',
      investorName: json['investorName'] ?? '',
      contact: json['contact'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'USD',
      durationMonths: json['durationMonths'] ?? 0,
      term: json['term'] ?? '',
      interestRate: (json['interestRate'] ?? 0).toDouble(),
      message: json['message'] ?? '',
      offerDate: DateTime.tryParse(json['offerDate'] ?? '') ?? now,
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? now,
      isAccepted: json['isAccepted'] ?? false,
    );
  }

  /// Serialize to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'listingId': listingId,
        'investorId': investorId,
        'investorName': investorName,
        'contact': contact,
        'amount': amount,
        'currency': currency,
        'durationMonths': durationMonths,
        'term': term,
        'interestRate': interestRate,
        'message': message,
        'offerDate': offerDate.toIso8601String(),
        'timestamp': timestamp.toIso8601String(),
        'isAccepted': isAccepted,
      };

  /// Encode list to JSON string
  static String encode(List<InvestmentOffer> offers) =>
      jsonEncode(offers.map((e) => e.toJson()).toList());

  /// Decode list from JSON string
  static List<InvestmentOffer> decode(String jsonStr) =>
      (jsonDecode(jsonStr) as List)
          .map((e) => InvestmentOffer.fromJson(e))
          .toList();

  @override
  String toString() =>
      'InvestmentOffer($id, $listingId, $investorName, $amount $currency)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvestmentOffer &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          listingId == other.listingId &&
          investorId == other.investorId &&
          investorName == other.investorName &&
          contact == other.contact &&
          amount == other.amount &&
          currency == other.currency &&
          durationMonths == other.durationMonths &&
          term == other.term &&
          interestRate == other.interestRate &&
          message == other.message &&
          offerDate == other.offerDate &&
          timestamp == other.timestamp &&
          isAccepted == other.isAccepted;

  @override
  int get hashCode =>
      id.hashCode ^
      listingId.hashCode ^
      investorId.hashCode ^
      investorName.hashCode ^
      contact.hashCode ^
      amount.hashCode ^
      currency.hashCode ^
      durationMonths.hashCode ^
      term.hashCode ^
      interestRate.hashCode ^
      message.hashCode ^
      offerDate.hashCode ^
      timestamp.hashCode ^
      isAccepted.hashCode;
}
