import 'dart:convert';

class ContractOffer {
  String id;
  String title;
  String description;
  String location;
  String duration;
  String paymentTerms;
  String contact;
  DateTime postedAt;
  bool isActive;
  List<String> parties;

  ContractOffer({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.duration,
    required this.paymentTerms,
    required this.contact,
    required this.postedAt,
    required this.isActive,
    required this.parties,
  });

  factory ContractOffer.fromJson(Map<String, dynamic> json) {
    return ContractOffer(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      duration: json['duration'] ?? '',
      paymentTerms: json['paymentTerms'] ?? '',
      contact: json['contact'] ?? '',
      postedAt: DateTime.tryParse(json['postedAt'] ?? '') ?? DateTime.now(),
      isActive: json['isActive'] ?? false,
      parties: List<String>.from(json['parties'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'duration': duration,
      'paymentTerms': paymentTerms,
      'contact': contact,
      'postedAt': postedAt.toIso8601String(),
      'isActive': isActive,
      'parties': parties,
    };
  }

  static ContractOffer empty() {
    return ContractOffer(
      id: '',
      title: '',
      description: '',
      location: '',
      duration: '',
      paymentTerms: '',
      contact: '',
      postedAt: DateTime.now(),
      isActive: false,
      parties: [],
    );
  }
}
