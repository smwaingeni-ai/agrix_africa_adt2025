class ContractOffer {
  final String id;
  final String title;
  final String description;
  final String location;
  final String duration;
  final String paymentTerms;
  final String contact;
  final List<String> parties;
  final bool isActive;
  final DateTime postedAt;
  final double amount;
  final String cropOrLivestockType;
  final String terms;

  ContractOffer({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.duration,
    required this.paymentTerms,
    required this.contact,
    required this.parties,
    required this.isActive,
    required this.postedAt,
    required this.amount,
    required this.cropOrLivestockType,
    required this.terms,
  });

  factory ContractOffer.fromJson(Map<String, dynamic> json) {
    return ContractOffer(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      duration: json['duration'],
      paymentTerms: json['paymentTerms'],
      contact: json['contact'],
      parties: List<String>.from(json['parties']),
      isActive: json['isActive'],
      postedAt: DateTime.parse(json['postedAt']),
      amount: (json['amount'] as num).toDouble(),
      cropOrLivestockType: json['cropOrLivestockType'] ?? '',
      terms: json['terms'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'duration': duration,
      'paymentTerms': paymentTerms,
      'contact': contact,
      'parties': parties,
      'isActive': isActive,
      'postedAt': postedAt.toIso8601String(),
      'amount': amount,
      'cropOrLivestockType': cropOrLivestockType,
      'terms': terms,
    };
  }
}
