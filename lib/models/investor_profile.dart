import 'dart:convert';
import 'package:agrix_africa_adt2025/models/investments/investment_horizon.dart';
import 'package:agrix_africa_adt2025/models/investments/investor_status.dart';

/// Investor profile model
class InvestorProfile {
  String id;
  String name;
  String contactNumber;
  String email;
  String location;
  List<InvestmentHorizon> preferredHorizons;
  InvestorStatus status;
  List<String> interests;
  DateTime registeredAt;

  InvestorProfile({
    required this.id,
    required this.name,
    required this.contactNumber,
    required this.email,
    required this.location,
    required this.preferredHorizons,
    required this.status,
    required this.interests,
    required this.registeredAt,
  });

  /// 🧪 Empty template
  factory InvestorProfile.empty() => InvestorProfile(
        id: '',
        name: '',
        contactNumber: '',
        email: '',
        location: '',
        preferredHorizons: [],
        status: InvestorStatus.open,
        interests: [],
        registeredAt: DateTime.now(),
      );

  /// 🔁 JSON encoder
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'contactNumber': contactNumber,
        'email': email,
        'location': location,
        'preferredHorizons': preferredHorizons.map((e) => e.name).toList(),
        'status': status.name,
        'interests': interests,
        'registeredAt': registeredAt.toIso8601String(),
      };

  /// 🔁 JSON decoder
  factory InvestorProfile.fromJson(Map<String, dynamic> json) => InvestorProfile(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        contactNumber: json['contactNumber'] ?? '',
        email: json['email'] ?? '',
        location: json['location'] ?? '',
        preferredHorizons: (json['preferredHorizons'] as List<dynamic>?)
                ?.map((e) => InvestmentHorizon.values.firstWhere(
                      (h) => h.name == e,
                      orElse: () => InvestmentHorizon.shortTerm,
                    ))
                .toList() ??
            [],
        status: InvestorStatus.values.firstWhere(
          (s) => s.name == json['status'],
          orElse: () => InvestorStatus.indifferent,
        ),
        interests: List<String>.from(json['interests'] ?? []),
        registeredAt: DateTime.tryParse(json['registeredAt'] ?? '') ?? DateTime.now(),
      );

  /// 🔄 Encode list of investors to JSON string
  static String encode(List<InvestorProfile> investors) =>
      json.encode(investors.map((i) => i.toJson()).toList());

  /// 🔄 Decode JSON string to investor list
  static List<InvestorProfile> decode(String jsonStr) =>
      (json.decode(jsonStr) as List<dynamic>)
          .map((i) => InvestorProfile.fromJson(i))
          .toList();
}
