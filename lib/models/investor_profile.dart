import 'dart:convert';

/// Enum for investment horizon
enum InvestmentHorizon { shortTerm, midTerm, longTerm }

/// Enum for investor openness status
enum InvestorStatus { open, indifferent, notOpen }

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

  /// 🧪 Factory for an empty template
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

  /// 🔁 Convert model to JSON map
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

  /// 🔁 Create model from JSON map
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
          orElse: () => InvestorStatus.open,
        ),
        interests: List<String>.from(json['interests'] ?? []),
        registeredAt: DateTime.tryParse(json['registeredAt'] ?? '') ?? DateTime.now(),
      );

  /// 🔄 Encode List<InvestorProfile> into JSON string
  static String encode(List<InvestorProfile> investors) =>
      json.encode(investors.map((i) => i.toJson()).toList());

  /// 🔄 Decode JSON string into List<InvestorProfile>
  static List<InvestorProfile> decode(String jsonStr) =>
      (json.decode(jsonStr) as List<dynamic>)
          .map((i) => InvestorProfile.fromJson(i))
          .toList();
}
