import 'dart:convert';

class MarketItem {
  final String id;
  final String title;
  final String description;
  final String category; // e.g., 'crop', 'livestock', 'equipment'
  final String location;
  final String imagePath; // Local or network image path
  final double price;
  final String contact; // Contact info (e.g., phone or email)
  final bool isForSale; // true = for sale, false = for lease/barter
  final DateTime postedAt;

  MarketItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    required this.imagePath,
    required this.price,
    required this.contact,
    required this.isForSale,
    required this.postedAt,
  });

  // For saving to local JSON or database
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'location': location,
        'imagePath': imagePath,
        'price': price,
        'contact': contact,
        'isForSale': isForSale,
        'postedAt': postedAt.toIso8601String(),
      };

  // For loading from JSON or database
  factory MarketItem.fromJson(Map<String, dynamic> json) => MarketItem(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        category: json['category'],
        location: json['location'],
        imagePath: json['imagePath'],
        price: (json['price'] as num).toDouble(),
        contact: json['contact'],
        isForSale: json['isForSale'],
        postedAt: DateTime.parse(json['postedAt']),
      );

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
