import 'dart:convert';

/// 🧑‍🌾 Farmer Profile Model
class FarmerProfile {
  /// Unique ID for the farmer
  final String farmerId;

  /// Full name of the farmer
  final String fullName;

  /// Contact number (phone)
  final String contactNumber;

  /// National ID or similar identifier
  final String idNumber;

  /// Regional and location info
  final String? region;
  final String? province;
  final String? district;
  final String? ward;
  final String? village;
  final String? cell;

  /// Farm details
  final double? farmSizeHectares;
  final String? farmType;
  final String? farmLocation;

  /// Whether the farmer is on a subsidy program
  final bool subsidised;

  /// Language preference
  final String? language;

  /// Created timestamp
  final String? createdAt;

  /// Optional: paths for profile image and QR code
  final String? qrImagePath;
  final String? photoPath;

  FarmerProfile({
    required this.farmerId,
    required this.fullName,
    required this.contactNumber,
    required this.idNumber,
    this.region,
    this.province,
    this.district,
    this.ward,
    this.village,
    this.cell,
    this.farmSizeHectares,
    this.farmType,
    required this.subsidised,
    this.language,
    this.createdAt,
    this.qrImagePath,
    this.photoPath,
    this.farmLocation,
  });

  /// ✅ From JSON
  factory FarmerProfile.fromJson(Map<String, dynamic> json) {
    return FarmerProfile(
      farmerId: json['farmerId'] ?? '',
      fullName: json['fullName'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
      idNumber: json['idNumber'] ?? '',
      region: json['region'],
      province: json['province'],
      district: json['district'],
      ward: json['ward'],
      village: json['village'],
      cell: json['cell'],
      farmSizeHectares: (json['farmSizeHectares'] as num?)?.toDouble(),
      farmType: json['farmType'],
      subsidised: json['subsidised'] ?? false,
      language: json['language'],
      createdAt: json['createdAt'],
      qrImagePath: json['qrImagePath'],
      photoPath: json['photoPath'],
      farmLocation: json['farmLocation'],
    );
  }

  /// ✅ To JSON
  Map<String, dynamic> toJson() => {
        'farmerId': farmerId,
        'fullName': fullName,
        'contactNumber': contactNumber,
        'idNumber': idNumber,
        'region': region,
        'province': province,
        'district': district,
        'ward': ward,
        'village': village,
        'cell': cell,
        'farmSizeHectares': farmSizeHectares,
        'farmType': farmType,
        'subsidised': subsidised,
        'language': language,
        'createdAt': createdAt,
        'qrImagePath': qrImagePath,
        'photoPath': photoPath,
        'farmLocation': farmLocation,
      };

  /// ✅ JSON string decoding
  factory FarmerProfile.fromRawJson(String str) =>
      FarmerProfile.fromJson(jsonDecode(str));

  /// ✅ JSON string encoding
  String toRawJson() => jsonEncode(toJson());

  /// ✅ List encoding
  static String encode(List<FarmerProfile> profiles) => jsonEncode(
        profiles.map((p) => p.toJson()).toList(),
      );

  /// ✅ List decoding
  static List<FarmerProfile> decode(String jsonStr) =>
      (jsonDecode(jsonStr) as List<dynamic>)
          .map((item) => FarmerProfile.fromJson(item))
          .toList();

  /// ✅ Create empty template
  static FarmerProfile empty() => FarmerProfile(
        farmerId: '',
        fullName: '',
        contactNumber: '',
        idNumber: '',
        subsidised: false,
      );

  /// ✅ Copy with override
  FarmerProfile copyWith({
    String? farmerId,
    String? fullName,
    String? contactNumber,
    String? idNumber,
    String? region,
    String? province,
    String? district,
    String? ward,
    String? village,
    String? cell,
    double? farmSizeHectares,
    String? farmType,
    bool? subsidised,
    String? language,
    String? createdAt,
    String? qrImagePath,
    String? photoPath,
    String? farmLocation,
  }) {
    return FarmerProfile(
      farmerId: farmerId ?? this.farmerId,
      fullName: fullName ?? this.fullName,
      contactNumber: contactNumber ?? this.contactNumber,
      idNumber: idNumber ?? this.idNumber,
      region: region ?? this.region,
      province: province ?? this.province,
      district: district ?? this.district,
      ward: ward ?? this.ward,
      village: village ?? this.village,
      cell: cell ?? this.cell,
      farmSizeHectares: farmSizeHectares ?? this.farmSizeHectares,
      farmType: farmType ?? this.farmType,
      subsidised: subsidised ?? this.subsidised,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
      qrImagePath: qrImagePath ?? this.qrImagePath,
      photoPath: photoPath ?? this.photoPath,
      farmLocation: farmLocation ?? this.farmLocation,
    );
  }

  /// ✅ Equatable override for comparison
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FarmerProfile &&
          runtimeType == other.runtimeType &&
          farmerId == other.farmerId &&
          fullName == other.fullName &&
          contactNumber == other.contactNumber &&
          idNumber == other.idNumber;

  @override
  int get hashCode =>
      farmerId.hashCode ^
      fullName.hashCode ^
      contactNumber.hashCode ^
      idNumber.hashCode;
}
