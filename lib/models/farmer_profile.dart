import 'dart:convert';

class FarmerProfile {
  String farmerId;
  String fullName;
  String idNumber;
  String country;
  String province;
  String district;
  String ward;
  String village;
  String cell;
  double farmSize;
  String farmType;
  bool subsidised;
  String contactNumber;
  String language;
  DateTime createdAt;
  String? qrImagePath;
  String? photoPath;

  FarmerProfile({
    required this.farmerId,
    required this.fullName,
    required this.idNumber,
    required this.country,
    required this.province,
    required this.district,
    required this.ward,
    required this.village,
    required this.cell,
    required this.farmSize,
    required this.farmType,
    required this.subsidised,
    required this.contactNumber,
    required this.language,
    required this.createdAt,
    this.qrImagePath,
    this.photoPath,
  });

  /// Creates an empty profile (useful for form initialization)
  factory FarmerProfile.empty() => FarmerProfile(
        farmerId: '',
        fullName: '',
        idNumber: '',
        country: '',
        province: '',
        district: '',
        ward: '',
        village: '',
        cell: '',
        farmSize: 0.0,
        farmType: '',
        subsidised: false,
        contactNumber: '',
        language: 'English',
        createdAt: DateTime.now(),
        qrImagePath: null,
        photoPath: null,
      );

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'farmerId': farmerId,
      'fullName': fullName,
      'idNumber': idNumber,
      'country': country,
      'province': province,
      'district': district,
      'ward': ward,
      'village': village,
      'cell': cell,
      'farmSize': farmSize,
      'farmType': farmType,
      'subsidised': subsidised,
      'contactNumber': contactNumber,
      'language': language,
      'createdAt': createdAt.toIso8601String(),
      'qrImagePath': qrImagePath,
      'photoPath': photoPath,
    };
  }

  /// Create from JSON
  factory FarmerProfile.fromJson(Map<String, dynamic> json) {
    return FarmerProfile(
      farmerId: json['farmerId'] ?? '',
      fullName: json['fullName'] ?? '',
      idNumber: json['idNumber'] ?? '',
      country: json['country'] ?? '',
      province: json['province'] ?? '',
      district: json['district'] ?? '',
      ward: json['ward'] ?? '',
      village: json['village'] ?? '',
      cell: json['cell'] ?? '',
      farmSize: (json['farmSize'] is int)
          ? (json['farmSize'] as int).toDouble()
          : (json['farmSize'] ?? 0.0),
      farmType: json['farmType'] ?? '',
      subsidised: json['subsidised'] ?? false,
      contactNumber: json['contactNumber'] ?? '',
      language: json['language'] ?? 'English',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      qrImagePath: json['qrImagePath'],
      photoPath: json['photoPath'],
    );
  }

  /// Raw encoding for storage as single string
  String toRawJson() => jsonEncode(toJson());

  /// Raw decoding for single string input
  static FarmerProfile fromRawJson(String str) =>
      FarmerProfile.fromJson(jsonDecode(str));

  /// Encode a list of profiles
  static String encode(List<FarmerProfile> profiles) =>
      jsonEncode(profiles.map((p) => p.toJson()).toList());

  /// Decode a list of profiles from string
  static List<FarmerProfile> decode(String jsonStr) =>
      (jsonDecode(jsonStr) as List)
          .map((item) => FarmerProfile.fromJson(item))
          .toList();
}
