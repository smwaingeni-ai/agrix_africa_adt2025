import 'dart:convert';
import 'farmer_profile.dart'; // ✅ Make sure to import FarmerProfile

/// Represents a user in the AgriX system.
class UserModel {
  final String id;
  final String name;
  final String role; // e.g., Farmer, AREX Officer, Government Official, Admin
  final String passcode;

  const UserModel({
    required this.id,
    required this.name,
    required this.role,
    required this.passcode,
  });

  /// Factory constructor for creating a UserModel from a Map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? 'Farmer',
      passcode: json['passcode'] ?? '',
    );
  }

  /// Factory constructor for creating a UserModel from a FarmerProfile
  factory UserModel.fromFarmer(FarmerProfile profile) {
    return UserModel(
      id: profile.idNumber ?? 'unknown_id',
      name: profile.fullName,
      role: profile.subsidised ? 'Subsidised Farmer' : 'Farmer',
      passcode: '', // Optional: Could be generated or left empty
    );
  }

  /// Converts UserModel to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'passcode': passcode,
    };
  }

  /// Parses a UserModel from a raw JSON string
  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  /// Converts UserModel to raw JSON string
  String toRawJson() => json.encode(toJson());

  /// Returns a copy with overridden fields
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
