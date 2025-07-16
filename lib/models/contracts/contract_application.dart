class ContractApplication {
  String id;
  String contractOfferId;
  String farmerName;
  String farmerId;
  String location;
  String phoneNumber;
  String email;
  String farmSize;
  String experience;
  String motivation;
  DateTime appliedAt;
  String status;

  // ✅ Newly added fields
  String farmLocation;
  String contactInfo;
  String notes;

  ContractApplication({
    required this.id,
    required this.contractOfferId,
    required this.farmerName,
    required this.farmerId,
    required this.location,
    required this.phoneNumber,
    required this.email,
    required this.farmSize,
    required this.experience,
    required this.motivation,
    required this.appliedAt,
    this.status = 'Pending',
    this.farmLocation = '',
    this.contactInfo = '',
    this.notes = '',
  });

  /// 🔹 Empty template for initial use (e.g., forms)
  factory ContractApplication.empty() {
    return ContractApplication(
      id: '',
      contractOfferId: '',
      farmerName: '',
      farmerId: '',
      location: '',
      phoneNumber: '',
      email: '',
      farmSize: '',
      experience: '',
      motivation: '',
      appliedAt: DateTime.now(),
      status: 'Pending',
      farmLocation: '',
      contactInfo: '',
      notes: '',
    );
  }

  /// 🔹 JSON Deserialization
  factory ContractApplication.fromJson(Map<String, dynamic> json) {
    return ContractApplication(
      id: json['id'] ?? '',
      contractOfferId: json['contractOfferId'] ?? '',
      farmerName: json['farmerName'] ?? '',
      farmerId: json['farmerId'] ?? '',
      location: json['location'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      farmSize: json['farmSize'] ?? '',
      experience: json['experience'] ?? '',
      motivation: json['motivation'] ?? '',
      appliedAt: DateTime.tryParse(json['appliedAt'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? 'Pending',
      farmLocation: json['farmLocation'] ?? '',
      contactInfo: json['contactInfo'] ?? '',
      notes: json['notes'] ?? '',
    );
  }

  /// 🔹 JSON Serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contractOfferId': contractOfferId,
      'farmerName': farmerName,
      'farmerId': farmerId,
      'location': location,
      'phoneNumber': phoneNumber,
      'email': email,
      'farmSize': farmSize,
      'experience': experience,
      'motivation': motivation,
      'appliedAt': appliedAt.toIso8601String(),
      'status': status,
      'farmLocation': farmLocation,
      'contactInfo': contactInfo,
      'notes': notes,
    };
  }
}
