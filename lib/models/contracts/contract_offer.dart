import 'dart:convert'; // Only needed if you're decoding raw JSON strings

class ContractOffer {
  String id;
  String title;
  String parties;
  double amount;
  String duration;
  String cropOrLivestockType;
  String location;
  String terms;
  DateTime postedAt;

  ContractOffer({
    required this.id,
    required this.title,
    required this.parties,
    required this.amount,
    required this.duration,
    required this.cropOrLivestockType,
    required this.location,
    required this.terms,
    required this.postedAt,
  });

  /// 🔹 Factory constructor for empty object
  factory ContractOffer.empty() {
    return ContractOffer(
      id: '',
      title: '',
      parties: '',
      amount: 0.0,
      duration: '',
      cropOrLivestockType: '',
      location: '',
      terms: '',
      postedAt: DateTime.now(),
    );
  }

  /// 🔹 Deserialize from JSON
  factory ContractOffer.fromJson(Map<String, dynamic> json) {
    return ContractOffer(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      parties: json['parties'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      duration: json['duration'] ?? '',
      cropOrLivestockType: json['cropOrLivestockType'] ?? '',
      location: json['location'] ?? '',
      terms: json['terms'] ?? '',
      postedAt: DateTime.tryParse(json['postedAt'] ?? '') ?? DateTime.now(),
    );
  }

  /// 🔹 Serialize to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'parties': parties,
      'amount': amount,
      'duration': duration,
      'cropOrLivestockType': cropOrLivestockType,
      'location': location,
      'terms': terms,
      'postedAt': postedAt.toIso8601String(),
    };
  }

  @override
  String toString() =>
      'ContractOffer(title: $title, amount: $amount, postedAt: $postedAt)';
}
