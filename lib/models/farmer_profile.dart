import 'dart:convert';
import 'user_model.dart';

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
  final String language;
  final DateTime createdAt;
  final String? qrImagePath;
  final String? photoPath;
  final String contact;
  final String farmLocation;

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
    required this.language,
    required this.createdAt,
    this.qrImagePath,
    this.photoPath,
    required this.contact,
    required this.farmLocation,
  });

  /// 🔹 Factory constructor to create a default profile from a UserModel
  factory FarmerProfile.fromUser(UserModel user) {
    return FarmerProfile(
      farmerId: '', // will be generated later
      fullName: user.name,
      idNumber: user.id,
      country: '',
      province: '',
      district: '',
      ward: '',
      village: '',
      cell: '',
      farmSize: 0.0,
      farmType: '',
      subsidised: user.role.toLowerCase().contains('subsidised'),
      language: 'English',
      createdAt: DateTime.now(),
      contact: '',
      farmLocation: '',
      qrImagePath: null,
      photoPath: null,
    );
  }

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
        language: 'English',
        createdAt: DateTime.now(),
        qrImagePath: null,
        photoPath: null,
        contact: '',
        farmLocation: '',
      );

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
        'language': language,
        'createdAt': createdAt.toIso8601String(),
        'qrImagePath': qrImagePath,
        'photoPath': photoPath,
        'contact': contact,
        'farmLocation': farmLocation,
      };

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
        language: json['language'] ?? 'English',
        createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
        qrImagePath: json['qrImagePath'],
        photoPath: json['photoPath'],
        contact: json['contact'] ?? '',
        farmLocation: json['farmLocation'] ?? '',
      );

  String toRawJson() => jsonEncode(toJson());

  static FarmerProfile fromRawJson(String str) =>
      FarmerProfile.fromJson(jsonDecode(str));

  static String encode(List<FarmerProfile> profiles) =>
      jsonEncode(profiles.map((p) => p.toJson()).toList());

  static List<FarmerProfile> decode(String jsonStr) =>
      (jsonDecode(jsonStr) as List)
          .map((item) => FarmerProfile.fromJson(item))
          .toList();

  FarmerProfile copyWith({
    String? farmerId,
    String? fullName,
    String? idNumber,
    String? country,
    String? province,
    String? district,
    String? ward,
    String? village,
    String? cell,
    double? farmSize,
    String? farmType,
    bool? subsidised,
    String? language,
    DateTime? createdAt,
    String? qrImagePath,
    String? photoPath,
    String? contact,
    String? farmLocation,
  }) {
    return FarmerProfile(
      farmerId: farmerId ?? this.farmerId,
      fullName: fullName ?? this.fullName,
      idNumber: idNumber ?? this.idNumber,
      country: country ?? this.country,
      province: province ?? this.province,
      district: district ?? this.district,
      ward: ward ?? this.ward,
      village: village ?? this.village,
      cell: cell ?? this.cell,
      farmSize: farmSize ?? this.farmSize,
      farmType: farmType ?? this.farmType,
      subsidised: subsidised ?? this.subsidised,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
      qrImagePath: qrImagePath ?? this.qrImagePath,
      photoPath: photoPath ?? this.photoPath,
      contact: contact ?? this.contact,
      farmLocation: farmLocation ?? this.farmLocation,
    );
  }

  @override
  String toString() =>
      'FarmerProfile(fullName: $fullName, idNumber: $idNumber, country: $country)';
}
