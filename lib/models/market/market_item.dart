import 'dart:convert';

/// 📦 Model representing a market item listed in AgriX
class MarketItem {
  final String id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String contact;
  final String imagePath;
  final String postedAt;

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

  /// 🔁 Convert MarketItem to Map (for JSON encoding)
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'category': category,
        'contact': contact,
        'imagePath': imagePath,
        'postedAt': postedAt,
      };

  /// 🧭 Factory constructor to create a MarketItem from Map
  factory MarketItem.fromJson(Map<String, dynamic> json) => MarketItem(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: (json['price'] as num).toDouble(),
        category: json['category'],
        contact: json['contact'],
        imagePath: json['imagePath'] ?? '',
        postedAt: json['postedAt'],
      );
}
