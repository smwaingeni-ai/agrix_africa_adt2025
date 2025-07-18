import 'dart:convert';

class FarmerProfile {
  final String farmerId;
  final String fullName;
  final String idNumber;
  final String contact; // REQUIRED
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
  final String farmLocation;
  final String? photoPath;
  final String? qrImagePath;

  FarmerProfile({
    required this.farmerId,
    required this.fullName,
    required this.idNumber,
    required this.contact,
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
    required this.farmLocation,
    this.photoPath,
    this.qrImagePath,
  });

  factory FarmerProfile.fromJson(Map<String, dynamic> json) {
    return FarmerProfile(
      farmerId: json['farmerId'],
      fullName: json['fullName'],
      idNumber: json['idNumber'],
      contact: json['contact'] ?? '', // Prevents null
      country: json['country'],
      province: json['province'],
      district: json['district'],
      ward: json['ward'],
      village: json['village'],
      cell: json['cell'],
      farmSize: (json['farmSize'] ?? 0).toDouble(),
      farmType: json['farmType'],
      subsidised: json['subsidised'] ?? false,
      language: json['language'] ?? 'English',
      createdAt: DateTime.parse(json['createdAt']),
      farmLocation: json['farmLocation'],
      photoPath: json['photoPath'],
      qrImagePath: json['qrImagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'farmerId': farmerId,
      'fullName': fullName,
      'idNumber': idNumber,
      'contact': contact,
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
      'farmLocation': farmLocation,
      'photoPath': photoPath,
      'qrImagePath': qrImagePath,
    };
  }

  static FarmerProfile fromUser(Map<String, dynamic> user) {
    return FarmerProfile(
      farmerId: user['farmerId'] ?? '',
      fullName: user['fullName'] ?? '',
      idNumber: user['idNumber'] ?? '',
      contact: user['contact'] ?? '', // Ensured here
      country: user['country'] ?? '',
      province: user['province'] ?? '',
      district: user['district'] ?? '',
      ward: user['ward'] ?? '',
      village: user['village'] ?? '',
      cell: user['cell'] ?? '',
      farmSize: (user['farmSize'] ?? 0).toDouble(),
      farmType: user['farmType'] ?? 'Crop',
      subsidised: user['subsidised'] ?? false,
      language: user['language'] ?? 'English',
      createdAt: DateTime.tryParse(user['createdAt'] ?? '') ?? DateTime.now(),
      farmLocation: user['farmLocation'] ?? '',
      photoPath: user['photoPath'],
      qrImagePath: user['qrImagePath'],
    );
  }

  static FarmerProfile empty() {
    return FarmerProfile(
      farmerId: '',
      fullName: '',
      idNumber: '',
      contact: '', // Required placeholder
      country: '',
      province: '',
      district: '',
      ward: '',
      village: '',
      cell: '',
      farmSize: 0.0,
      farmType: 'Crop',
      subsidised: false,
      language: 'English',
      createdAt: DateTime.now(),
      farmLocation: '',
      photoPath: null,
      qrImagePath: null,
    );
  }
}
