import 'dart:convert';
import 'farmer_profile.dart'; // ✅ Ensure this exists and matches your FarmerProfile

/// Represents a user in the AgriX system.
class UserModel {
  final String id;
  final String name;
  final String role;     // e.g., Farmer, Officer, Admin, etc.
  final String passcode; // Optional login PIN or code

  const UserModel({
    required this.id,
    required this.name,
    required this.role,
    required this.passcode,
  });

  /// 🔹 Empty user (for forms or drafts)
  factory UserModel.empty() => const UserModel(
        id: '',
        name: '',
        role: 'Farmer',
        passcode: '',
      );

  /// 🔁 Create from raw JSON string
  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  /// 🔁 Convert to raw JSON string
  String toRawJson() => json.encode(toJson());

  /// 🔁 Create from JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? 'Farmer',
      passcode: json['passcode'] ?? '',
    );
  }

  /// 🔁 Convert to JSON map
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'role': role,
        'passcode': passcode,
      };

  /// 🔄 Create UserModel from FarmerProfile
  factory UserModel.fromFarmer(FarmerProfile profile) {
    return UserModel(
      id: profile.idNumber,
      name: profile.fullName,
      role: profile.subsidised ? 'Subsidised Farmer' : 'Farmer',
      passcode: '', // optional; handled externally
    );
  }

  /// 🔄 Create a modified copy
  UserModel copyWith({
    String? id,
    String? name,
    String? role,
    String? passcode,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      passcode: passcode ?? this.passcode,
    );
  }

  @override
  String toString() =>
      'UserModel(id: $id, name: $name, role: $role, passcode: $passcode)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          role == other.role &&
          passcode == other.passcode;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ role.hashCode ^ passcode.hashCode;
}
