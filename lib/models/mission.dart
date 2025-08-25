class Mission {
  final String id;
  final String title;
  final String description;
  final String storeId;
  final String storeName;
  final int requiredStamps;
  final int currentStamps;
  final DateTime startDate;
  final DateTime endDate;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Mission({
    required this.id,
    required this.title,
    required this.description,
    required this.storeId,
    required this.storeName,
    required this.requiredStamps,
    this.currentStamps = 0,
    required this.startDate,
    required this.endDate,
    this.isCompleted = false,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
      requiredStamps: json['requiredStamps'] as int,
      currentStamps: json['currentStamps'] as int? ?? 0,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedAt: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt'] as String) 
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
      'requiredStamps': requiredStamps,
      'currentStamps': currentStamps,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Mission copyWith({
    String? id,
    String? title,
    String? description,
    String? storeId,
    String? storeName,
    int? requiredStamps,
    int? currentStamps,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCompleted,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Mission(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      requiredStamps: requiredStamps ?? this.requiredStamps,
      currentStamps: currentStamps ?? this.currentStamps,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  double get progressPercentage => 
      requiredStamps > 0 ? (currentStamps / requiredStamps) * 100 : 0.0;
}
