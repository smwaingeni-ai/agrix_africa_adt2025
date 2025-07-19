import 'dart:convert';
import 'package:agrix_africa_adt2025/models/farmer_profile.dart' as model;

/// Represents a user in the AgriX system.
class UserModel {
  final String id;
  final String name;
  final String role;
  final String passcode;

  const UserModel({
    required this.id,
    required this.name,
    required this.role,
    required this.passcode,
  });

  /// Returns an empty user model with default values
  factory UserModel.empty() => const UserModel(
        id: '',
        name: '',
        role: 'Farmer',
        passcode: '',
      );

  /// Creates a UserModel from a raw JSON string
  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  /// Converts UserModel to a raw JSON string
  String toRawJson() => json.encode(toJson());

  /// Creates a UserModel from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        role: json['role'] ?? 'Farmer',
        passcode: json['passcode'] ?? '',
      );

  /// Converts UserModel to a JSON map
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'role': role,
        'passcode': passcode,
      };

  /// Converts a FarmerProfile into a UserModel
  factory UserModel.fromFarmer(model.FarmerProfile profile) => UserModel(
        id: profile.idNumber,
        name: profile.fullName,
        role: profile.subsidised ? 'Subsidised Farmer' : 'Farmer',
        passcode: '',
      );

  /// Returns a new UserModel with updated fields
  UserModel copyWith({
    String? id,
    String? name,
    String? role,
    String? passcode,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        role: role ?? this.role,
        passcode: passcode ?? this.passcode,
      );

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
