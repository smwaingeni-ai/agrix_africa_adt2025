class MarketItem {
  final String id;
  final String title;
  final String description;
  final String category; // ✅ Add this
  final String type;
  final String listingType;
  final String location;
  final double price;
  final List<String> imagePaths;
  final List<String> contactMethods;
  final List<String> paymentOptions;
  final bool isAvailable;
  final bool isLoanAccepted;
  final bool isInvestmentOpen;
  final String investmentStatus;
  final String investmentTerm;
  final String ownerName;
  final String ownerContact;
  final DateTime postedAt;

  MarketItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category, // ✅ Add this
    required this.type,
    required this.listingType,
    required this.location,
    required this.price,
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

  factory MarketItem.fromJson(Map<String, dynamic> json) {
    return MarketItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'] ?? 'Uncategorized', // ✅ Defensive default
      type: json['type'],
      listingType: json['listingType'],
      location: json['location'],
      price: (json['price'] as num).toDouble(),
      imagePaths: List<String>.from(json['imagePaths']),
      contactMethods: List<String>.from(json['contactMethods']),
      paymentOptions: List<String>.from(json['paymentOptions']),
      isAvailable: json['isAvailable'],
      isLoanAccepted: json['isLoanAccepted'],
      isInvestmentOpen: json['isInvestmentOpen'],
      investmentStatus: json['investmentStatus'],
      investmentTerm: json['investmentTerm'],
      ownerName: json['ownerName'],
      ownerContact: json['ownerContact'],
      postedAt: DateTime.parse(json['postedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category, // ✅ Add this
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
  }
}
