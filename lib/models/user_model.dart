class UserModel {
  final String id;
  final String name;
  final String role; // e.g., Farmer, AREX Officer, Government Official, Admin
  final String passcode;

  UserModel({
    required this.id,
    required this.name,
    required this.role,
    required this.passcode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      passcode: json['passcode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'passcode': passcode,
    };
  }
}
