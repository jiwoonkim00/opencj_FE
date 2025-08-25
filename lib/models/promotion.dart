class Promotion {
  final String id;
  final String title;
  final String description;
  final String storeId;
  final String storeName;
  final String imageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  Promotion({
    required this.id,
    required this.title,
    required this.description,
    required this.storeId,
    required this.storeName,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    this.isActive = true,
    this.tags = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
      imageUrl: json['imageUrl'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool? ?? true,
      tags: List<String>.from(json['tags'] as List? ?? []),
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
      'imageUrl': imageUrl,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isActive': isActive,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Promotion copyWith({
    String? id,
    String? title,
    String? description,
    String? storeId,
    String? storeName,
    String? imageUrl,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Promotion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      imageUrl: imageUrl ?? this.imageUrl,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isValid => 
      DateTime.now().isAfter(startDate) && 
      DateTime.now().isBefore(endDate) && 
      isActive;
}
