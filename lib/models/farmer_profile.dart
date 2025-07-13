import 'dart:convert';

class FarmerProfile {
  final String farmerId;
  final String fullName;
  final String idNumber;
  final String country;
  final String province;
  final String district;
  final String ward;
  final String village;
  final String cell;
  final double farmSize;
  final String farmType;
  final bool subsidised;
  final String contactNumber;
  final String language;
  final DateTime createdAt;
  final String? qrImagePath;
  final String? photoPath;

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

  /// ✅ Virtual aliases for compatibility with scoring and other screens
  String get id => farmerId;
  String get name => fullName;
  bool get govtAffiliated => subsidised;
  double get farmSizeHectares => farmSize;

  /// ✅ Factory for empty object
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

  /// ✅ JSON serialization
  Map<String, dynamic> toJson() => {
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

  /// ✅ JSON deserialization
  factory FarmerProfile.fromJson(Map<String, dynamic> json) => FarmerProfile(
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

  /// ✅ Encode single instance to raw JSON string
  String toRawJson() => jsonEncode(toJson());

  /// ✅ Decode single instance from raw JSON string
  static FarmerProfile fromRawJson(String str) =>
      FarmerProfile.fromJson(jsonDecode(str));

  /// ✅ Encode list of profiles
  static String encode(List<FarmerProfile> profiles) =>
      jsonEncode(profiles.map((p) => p.toJson()).toList());

  /// ✅ Decode list of profiles
  static List<FarmerProfile> decode(String jsonStr) =>
      (jsonDecode(jsonStr) as List)
          .map((item) => FarmerProfile.fromJson(item))
          .toList();
}
