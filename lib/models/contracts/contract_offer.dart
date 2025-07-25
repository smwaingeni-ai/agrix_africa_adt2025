import 'dart:convert';

class ContractOffer {
  final String id;
  final String title;
  final String description;
  final String location;
  final String duration;
  final String paymentTerms;
  final String contact;
  final List<String> parties;
  final bool isActive;
  final DateTime postedAt;
  final double amount;
  final String cropOrLivestockType;
  final String terms;

  ContractOffer({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.duration,
    required this.paymentTerms,
    required this.contact,
    required this.parties,
    required this.isActive,
    required this.postedAt,
    required this.amount,
    required this.cropOrLivestockType,
    required this.terms,
  });

  ContractOffer copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    String? duration,
    String? paymentTerms,
    String? contact,
    List<String>? parties,
    bool? isActive,
    DateTime? postedAt,
    double? amount,
    String? cropOrLivestockType,
    String? terms,
  }) {
    return ContractOffer(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      duration: duration ?? this.duration,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      contact: contact ?? this.contact,
      parties: parties ?? this.parties,
      isActive: isActive ?? this.isActive,
      postedAt: postedAt ?? this.postedAt,
      amount: amount ?? this.amount,
      cropOrLivestockType: cropOrLivestockType ?? this.cropOrLivestockType,
      terms: terms ?? this.terms,
    );
  }

  factory ContractOffer.fromJson(Map<String, dynamic> json) {
    return ContractOffer(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      duration: json['duration'] ?? '',
      paymentTerms: json['paymentTerms'] ?? '',
      contact: json['contact'] ?? '',
      parties: List<String>.from(json['parties'] ?? []),
      isActive: json['isActive'] ?? false,
      postedAt: DateTime.tryParse(json['postedAt'] ?? '') ?? DateTime.now(),
      amount: (json['amount'] is num)
          ? (json['amount'] as num).toDouble()
          : double.tryParse(json['amount']?.toString() ?? '') ?? 0.0,
      cropOrLivestockType: json['cropOrLivestockType'] ?? '',
      terms: json['terms'] ?? '',
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
      'parties': parties,
      'isActive': isActive,
      'postedAt': postedAt.toIso8601String(),
      'amount': amount,
      'cropOrLivestockType': cropOrLivestockType,
      'terms': terms,
    };
  }

  static List<ContractOffer> listFromJson(String jsonString) {
    final data = json.decode(jsonString) as List<dynamic>;
    return data.map((e) => ContractOffer.fromJson(e)).toList();
  }
}
