import 'dart:convert';

class ContractOffer {
  String id;
  String title;
  List<String> parties; // Multiple parties involved
  double amount;
  String duration;
  String cropOrLivestockType;
  String location;
  String terms;
  DateTime postedAt;
  String description;
  String paymentTerms;
  String contact;
  bool isActive;

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
    required this.description,
    required this.paymentTerms,
    required this.contact,
    required this.isActive,
  });

  factory ContractOffer.empty() {
    return ContractOffer(
      id: '',
      title: '',
      parties: [],
      amount: 0.0,
      duration: '',
      cropOrLivestockType: '',
      location: '',
      terms: '',
      postedAt: DateTime.now(),
      description: '',
      paymentTerms: '',
      contact: '',
      isActive: false,
    );
  }

  factory ContractOffer.fromJson(Map<String, dynamic> json) {
    return ContractOffer(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      parties: List<String>.from(json['parties'] ?? []),
      amount: (json['amount'] ?? 0).toDouble(),
      duration: json['duration'] ?? '',
      cropOrLivestockType: json['cropOrLivestockType'] ?? '',
      location: json['location'] ?? '',
      terms: json['terms'] ?? '',
      postedAt: DateTime.tryParse(json['postedAt'] ?? '') ?? DateTime.now(),
      description: json['description'] ?? '',
      paymentTerms: json['paymentTerms'] ?? '',
      contact: json['contact'] ?? '',
      isActive: json['isActive'] ?? false,
    );
  }

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
      'description': description,
      'paymentTerms': paymentTerms,
      'contact': contact,
      'isActive': isActive,
    };
  }

  @override
  String toString() =>
      'ContractOffer(title: $title, amount: $amount, postedAt: $postedAt, description: $description)';
}
