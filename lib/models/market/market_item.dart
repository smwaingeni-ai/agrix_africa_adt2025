import 'dart:convert';

/// Represents an item listed in the AgriX marketplace.
class MarketItem {
  /// Unique identifier for the market item.
  final String id;

  /// Title of the item, e.g., 'Fresh Tomatoes', 'Goat for Sale'.
  final String title;

  /// Detailed item description.
  final String description;

  /// Type of item: 'crop', 'livestock', 'equipment', 'service', etc.
  final String type;

  /// Location where the item is available (e.g., 'Lusaka, Zambia').
  final String location;

  /// Local path or URL to the item's image.
  final String imagePath;

  /// Price of the item in local currency.
  final double price;

  /// Contact details of the seller (phone or email).
  final String contact;

  /// True if the item is listed for sale; false for barter, lease, or donation.
  final bool isForSale;

  /// Timestamp indicating when the item was listed.
  final DateTime postedAt;

  /// Optional: Accepted payment option (e.g., 'cash', 'loan').
  final String? paymentOption;

  /// Optional: Investment term (e.g., 'short', 'mid', 'long').
  final String? investmentTerm;

  /// Optional: True if the seller accepts loans.
  final bool? isLoanAccepted;

  /// Optional: True if the seller is open to investment.
  final bool? isInvestorOpen;

  /// Optional: Unique identifier for the item's owner.
  final String? ownerId;

  /// Optional: Item category or sub-type (e.g., 'vegetable', 'poultry').
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

  /// Serializes the object to a JSON-compatible map.
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

  /// Creates a MarketItem instance from a JSON map.
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

  /// Returns true if the item qualifies as an investment opportunity.
  bool get isInvestment =>
      (investmentTerm != null && investmentTerm!.isNotEmpty) ||
      (isInvestorOpen ?? false);

  @override
  String toString() => 'MarketItem(${jsonEncode(toJson())})';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarketItem && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
