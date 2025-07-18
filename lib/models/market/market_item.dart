import 'dart:convert';

class MarketItem {
  final String id;
  final String title;
  final String description;
  final String type; // e.g., 'crop', 'livestock', 'equipment'
  final String location;
  final String imagePath; // Local or network image path
  final double price;
  final String contact;
  final bool isForSale;
  final DateTime postedAt;

  // Optional extended fields
  final String? paymentOption;      // e.g., 'cash', 'loan', 'bank transfer'
  final String? investmentTerm;     // e.g., 'short', 'mid', 'long'
  final bool? isLoanAccepted;
  final bool? isInvestorOpen;

  MarketItem({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.location,
    required this.imagePath,
    required this.price,
    required this.contact,
    required this.isForSale,
    required this.postedAt,
    this.paymentOption,
    this.investmentTerm,
    this.isLoanAccepted,
    this.isInvestorOpen,
  });

  /// ✅ Convert MarketItem to JSON Map for storage
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'type': type,
        'location': location,
        'imagePath': imagePath,
        'price': price,
        'contact': contact,
        'isForSale': isForSale,
        'postedAt': postedAt.toIso8601String(),
        'paymentOption': paymentOption,
        'investmentTerm': investmentTerm,
        'isLoanAccepted': isLoanAccepted,
        'isInvestorOpen': isInvestorOpen,
      };

  /// ✅ Create MarketItem from JSON Map
  factory MarketItem.fromJson(Map<String, dynamic> json) => MarketItem(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        type: json['type'] ?? '',
        location: json['location'] ?? '',
        imagePath: json['imagePath'] ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        contact: json['contact'] ?? '',
        isForSale: json['isForSale'] ?? false,
        postedAt: DateTime.tryParse(json['postedAt'] ?? '') ?? DateTime.now(),
        paymentOption: json['paymentOption'],
        investmentTerm: json['investmentTerm'],
        isLoanAccepted: json['isLoanAccepted'],
        isInvestorOpen: json['isInvestorOpen'],
      );

  /// ✅ Debug-friendly string representation
  @override
  String toString() => jsonEncode(toJson());
}
