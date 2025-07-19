import 'dart:convert';

/// Represents an item listed in the AgriX marketplace.
class MarketItem {
  /// Unique ID for this item.
  final String id;

  /// Title of the item, e.g., 'Fresh Tomatoes', 'Goat for Sale'
  final String title;

  /// Detailed description
  final String description;

  /// Type of item: 'crop', 'livestock', 'equipment', 'service', etc.
  final String type;

  /// Location where the item is based (e.g., 'Lusaka, Zambia')
  final String location;

  /// Path to the item's image (local path or network URL)
  final String imagePath;

  /// Price in local currency
  final double price;

  /// Contact details (phone number or email)
  final String contact;

  /// True if item is for sale; false if for barter, donation, or lease
  final bool isForSale;

  /// Timestamp when item was posted
  final DateTime postedAt;

  // Optional Fields for Financial/Investment Features

  /// Payment option (e.g., 'cash', 'loan', 'bank transfer')
  final String? paymentOption;

  /// Investment term (e.g., 'short', 'mid', 'long')
  final String? investmentTerm;

  /// Whether loans are accepted for this item
  final bool? isLoanAccepted;

  /// Whether the seller is open to investors
  final bool? isInvestorOpen;

  /// Owner ID (usually the farmer or trader)
  final String? ownerId;

  /// Category or sub-type, e.g., 'vegetable', 'poultry'
  final String? category;

  const MarketItem({
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
    this.ownerId,
    this.category,
  });

  /// Converts the object to a JSON map for storage or networking.
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
        'ownerId': ownerId,
        'category': category,
      };

  /// Creates a MarketItem from a JSON map.
  factory MarketItem.fromJson(Map<String, dynamic> json) {
    return MarketItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      location: json['location'] ?? '',
      imagePath: json['imagePath'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      contact: json['contact'] ?? '',
      isForSale: json['isForSale'] ?? true,
      postedAt: DateTime.tryParse(json['postedAt'] ?? '') ?? DateTime.now(),
      paymentOption: json['paymentOption'] as String?,
      investmentTerm: json['investmentTerm'] as String?,
      isLoanAccepted: json['isLoanAccepted'] as bool?,
      isInvestorOpen: json['isInvestorOpen'] as bool?,
      ownerId: json['ownerId'] as String?,
      category: json['category'] as String?,
    );
  }

  /// Returns true if the item is listed for investment.
  bool get isInvestment =>
      (investmentTerm != null && investmentTerm!.isNotEmpty) ||
      (isInvestorOpen ?? false);

  /// Returns a debug-friendly string view of the item.
  @override
  String toString() => 'MarketItem(${jsonEncode(toJson())})';

  /// Equality based on item ID
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarketItem && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
