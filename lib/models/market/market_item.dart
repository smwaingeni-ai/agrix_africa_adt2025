import 'dart:convert';

/// Model class representing an item listed in the AgriX market.
class MarketItem {
  final String id;                 // Unique identifier
  final String title;             // Item title/name
  final String description;       // Detailed description
  final double price;             // Asking price
  final String category;          // Category (e.g., Crops, Livestock, etc.)
  final String contact;           // Contact info for buyer/seller
  final String imagePath;         // Local path to image file (optional)
  final String postedAt;          // ISO timestamp of posting

  /// Constructor with all required fields
  MarketItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.contact,
    required this.imagePath,
    required this.postedAt,
  });

  /// Convert MarketItem instance to a Map (for JSON encoding)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'category': category,
      'contact': contact,
      'imagePath': imagePath,
      'postedAt': postedAt,
    };
  }

  /// Factory method to create MarketItem from a JSON map
  factory MarketItem.fromJson(Map<String, dynamic> json) {
    return MarketItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : (json['price'] as num),
      category: json['category'] ?? '',
      contact: json['contact'] ?? '',
      imagePath: json['imagePath'] ?? '',
      postedAt: json['postedAt'] ?? '',
    );
  }

  /// Optional: encode list of items to JSON string
  static String encodeList(List<MarketItem> items) =>
      json.encode(items.map((item) => item.toJson()).toList());

  /// Optional: decode JSON string to list of MarketItems
  static List<MarketItem> decodeList(String jsonString) =>
      (json.decode(jsonString) as List<dynamic>)
          .map<MarketItem>((json) => MarketItem.fromJson(json))
          .toList();
}
