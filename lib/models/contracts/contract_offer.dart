import 'package:flutter/foundation.dart';

class ContractOffer {
  String id;
  String title;
  String description;
  String category;
  String sponsorName;
  String location;
  double fundingAmount;
  String duration;
  String requirements;
  String paymentTerms;
  String contactPhone;
  String contactEmail;
  DateTime createdAt;
  bool isVerified;
  String status;

  ContractOffer({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.sponsorName,
    required this.location,
    required this.fundingAmount,
    required this.duration,
    required this.requirements,
    required this.paymentTerms,
    required this.contactPhone,
    required this.contactEmail,
    required this.createdAt,
    this.isVerified = false,
    this.status = "Open",
  });

  /// ✅ Default empty for forms
  factory ContractOffer.empty() {
    return ContractOffer(
      id: UniqueKey().toString(),
      title: '',
      description: '',
      category: '',
      sponsorName: '',
      location: '',
      fundingAmount: 0.0,
      duration: '',
      requirements: '',
      paymentTerms: '',
      contactPhone: '',
      contactEmail: '',
      createdAt: DateTime.now(),
      isVerified: false,
      status: 'Open',
    );
  }

  factory ContractOffer.fromJson(Map<String, dynamic> json) => ContractOffer(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        category: json['category'] ?? '',
        sponsorName: json['sponsorName'] ?? '',
        location: json['location'] ?? '',
        fundingAmount: (json['fundingAmount'] ?? 0).toDouble(),
        duration: json['duration'] ?? '',
        requirements: json['requirements'] ?? '',
        paymentTerms: json['paymentTerms'] ?? '',
        contactPhone: json['contactPhone'] ?? '',
        contactEmail: json['contactEmail'] ?? '',
        createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
        isVerified: json['isVerified'] ?? false,
        status: json['status'] ?? "Open",
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'sponsorName': sponsorName,
        'location': location,
        'fundingAmount': fundingAmount,
        'duration': duration,
        'requirements': requirements,
        'paymentTerms': paymentTerms,
        'contactPhone': contactPhone,
        'contactEmail': contactEmail,
        'createdAt': createdAt.toIso8601String(),
        'isVerified': isVerified,
        'status': status,
      };
}
