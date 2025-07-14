// lib/models/market_item.dart

import 'dart:convert';

class MarketItem {
  final String id;
  final String title;
  final String description;
  final String category;
  final String type;
  final String listingType;
  final String location;
  final double? price;
  final List<String> imagePaths;
  final List<String> contactMethods;
  final List<String> paymentOptions;
  final bool isAvailable;
  final bool isLoanAccepted;
  final bool isInvestmentOpen;
  final String investmentTerm;
  final String investmentStatus;
  final String ownerName;
  final String ownerContact;
  final DateTime postedAt;

  MarketItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.type,
    required this.listingType,
    required this.location,
    this.price,
    required this.imagePaths,
    required this.contactMethods,
    required this.paymentOptions,
    required this.isAvailable,
    required this.isLoanAccepted,
    required this.isInvestmentOpen,
    required this.investmentStatus,
    required this.investmentTerm,
    required this.ownerName,
    required this.ownerContact,
    required this.postedAt,
  });

  // ✅ Convenience Getters for Compatibility
  String get imagePath => imagePaths.isNotEmpty ? imagePaths.first : '';
  String get contact => ownerContact;
  String get paymentOption => paymentOptions.isNotEmpty ? paymentOptions.first : '';

  factory MarketItem.empty() => MarketItem(
        id: '',
        title: '',
        description: '',
        category: '',
        type: '',
        listingType: '',
        location: '',
        price: 0.0,
        imagePaths: [],
        contactMethods: [],
        paymentOptions: [],
        isAvailable: true,
        isLoanAccepted: false,
        isInvestmentOpen: false,
        investmentStatus: 'Open',
        investmentTerm: 'Short',
        ownerName: '',
        ownerContact: '',
        postedAt: DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'type': type,
        'listingType': listingType,
        'location': location,
        'price': price,
        'imagePaths': imagePaths,
        'contactMethods': contactMethods,
        'paymentOptions': paymentOptions,
        'isAvailable': isAvailable,
        'isLoanAccepted': isLoanAccepted,
        'isInvestmentOpen': isInvestmentOpen,
        'investmentStatus': investmentStatus,
        'investmentTerm': investmentTerm,
        'ownerName': ownerName,
        'ownerContact': ownerContact,
        'postedAt': postedAt.toIso8601String(),
      };

  factory MarketItem.fromJson(Map<String, dynamic> json) => MarketItem(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        category: json['category'] ?? '',
        type: json['type'] ?? '',
        listingType: json['listingType'] ?? '',
        location: json['location'] ?? '',
        price: (json['price'] as num?)?.toDouble(),
        imagePaths: List<String>.from(json['imagePaths'] ?? []),
        contactMethods: List<String>.from(json['contactMethods'] ?? []),
        paymentOptions: List<String>.from(json['paymentOptions'] ?? []),
        isAvailable: json['isAvailable'] ?? true,
        isLoanAccepted: json['isLoanAccepted'] ?? false,
        isInvestmentOpen: json['isInvestmentOpen'] ?? false,
        investmentStatus: json['investmentStatus'] ?? 'Open',
        investmentTerm: json['investmentTerm'] ?? 'Short',
        ownerName: json['ownerName'] ?? '',
        ownerContact: json['ownerContact'] ?? '',
        postedAt: DateTime.tryParse(json['postedAt'] ?? '') ?? DateTime.now(),
      );

  static String encodeList(List<MarketItem> items) =>
      json.encode(items.map((item) => item.toJson()).toList());

  static List<MarketItem> decodeList(String jsonString) =>
      (json.decode(jsonString) as List<dynamic>)
          .map((e) => MarketItem.fromJson(e))
          .toList();
}
