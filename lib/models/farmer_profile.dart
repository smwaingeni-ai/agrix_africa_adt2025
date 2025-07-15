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

  /// 🔹 Friendly accessors
  String get id => farmerId;
  String get name => fullName;
  bool get govtAffiliated => subsidised;
  double get farmSizeHectares => farmSize;

  /// 🔹 Default empty profile
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

  /// 🔹 Convert to JSON
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

  /// 🔹 Create from JSON
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
        createdAt:
            DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
        qrImagePath: json['qrImagePath'],
        photoPath: json['photoPath'],
      );

  /// 🔹 Encode to raw JSON string
  String toRawJson() => jsonEncode(toJson());

  /// 🔹 Decode from raw JSON string
  static FarmerProfile fromRawJson(String str) =>
      FarmerProfile.fromJson(jsonDecode(str));

  /// 🔹 Encode a list of FarmerProfiles
  static String encode(List<FarmerProfile> profiles) =>
      jsonEncode(profiles.map((p) => p.toJson()).toList());

  /// 🔹 Decode a list of FarmerProfiles
  static List<FarmerProfile> decode(String jsonStr) =>
      (jsonDecode(jsonStr) as List)
          .map((item) => FarmerProfile.fromJson(item))
          .toList();

  /// 🔹 Create a modified copy
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
    String? contactNumber,
    String? language,
    DateTime? createdAt,
    String? qrImagePath,
    String? photoPath,
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
      contactNumber: contactNumber ?? this.contactNumber,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
      qrImagePath: qrImagePath ?? this.qrImagePath,
      photoPath: photoPath ?? this.photoPath,
    );
  }

  @override
  String toString() =>
      'FarmerProfile(fullName: $fullName, idNumber: $idNumber, country: $country)';
}
