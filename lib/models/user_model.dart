import 'dart:convert';
import 'farmer_profile.dart'; // ✅ Ensure this file exists and is correctly implemented

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

  /// Create a UserModel from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? 'Farmer',
      passcode: json['passcode'] ?? '',
    );
  }

  /// Create a UserModel directly from a FarmerProfile instance
  factory UserModel.fromFarmer(FarmerProfile profile) {
    return UserModel(
      id: profile.idNumber ?? 'unknown_id',
      name: profile.fullName,
      role: profile.subsidised ? 'Subsidised Farmer' : 'Farmer',
      passcode: '', // Optional: you can assign from elsewhere
    );
  }

  /// Convert this object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'passcode': passcode,
    };
  }

  /// Create from a raw JSON string
  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  /// Convert to raw JSON string
  String toRawJson() => json.encode(toJson());

  /// Copy the user with optional override values
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
