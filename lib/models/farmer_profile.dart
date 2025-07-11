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

  factory FarmerProfile.fromJson(Map<String, dynamic> json) {
    return FarmerProfile(
      farmerId: json['farmerId'],
      fullName: json['fullName'],
      idNumber: json['idNumber'],
      country: json['country'],
      province: json['province'],
      district: json['district'],
      ward: json['ward'],
      village: json['village'],
      cell: json['cell'],
      farmSize: json['farmSize'],
      farmType: json['farmType'],
      subsidised: json['subsidised'],
      contactNumber: json['contactNumber'],
      language: json['language'],
      createdAt: DateTime.parse(json['createdAt']),
      qrImagePath: json['qrImagePath'],
      photoPath: json['photoPath'],
    );
  }

  String toRawJson() => jsonEncode(toJson());

  static FarmerProfile fromRawJson(String str) =>
      FarmerProfile.fromJson(jsonDecode(str));
}
