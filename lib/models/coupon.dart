class Coupon {
  final String id;
  final String title;
  final String description;
  final String storeId;
  final String storeName;
  final double discountAmount;
  final double minimumPurchaseAmount;
  final DateTime validFrom;
  final DateTime validUntil;
  final bool isUsed;
  final DateTime? usedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Coupon({
    required this.id,
    required this.title,
    required this.description,
    required this.storeId,
    required this.storeName,
    required this.discountAmount,
    required this.minimumPurchaseAmount,
    required this.validFrom,
    required this.validUntil,
    this.isUsed = false,
    this.usedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
      discountAmount: json['discountAmount'] as double,
      minimumPurchaseAmount: json['minimumPurchaseAmount'] as double,
      validFrom: DateTime.parse(json['validFrom'] as String),
      validUntil: DateTime.parse(json['validUntil'] as String),
      isUsed: json['isUsed'] as bool? ?? false,
      usedAt: json['usedAt'] != null 
          ? DateTime.parse(json['usedAt'] as String) 
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'storeId': storeId,
      'storeName': storeName,
      'discountAmount': discountAmount,
      'minimumPurchaseAmount': minimumPurchaseAmount,
      'validFrom': validFrom.toIso8601String(),
      'validUntil': validUntil.toIso8601String(),
      'isUsed': isUsed,
      'usedAt': usedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Coupon copyWith({
    String? id,
    String? title,
    String? description,
    String? storeId,
    String? storeName,
    double? discountAmount,
    double? minimumPurchaseAmount,
    DateTime? validFrom,
    DateTime? validUntil,
    bool? isUsed,
    DateTime? usedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Coupon(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      discountAmount: discountAmount ?? this.discountAmount,
      minimumPurchaseAmount: minimumPurchaseAmount ?? this.minimumPurchaseAmount,
      validFrom: validFrom ?? this.validFrom,
      validUntil: validUntil ?? this.validUntil,
      isUsed: isUsed ?? this.isUsed,
      usedAt: usedAt ?? this.usedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isValid => 
      DateTime.now().isAfter(validFrom) && 
      DateTime.now().isBefore(validUntil) && 
      !isUsed;
}
