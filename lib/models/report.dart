class Report {
  final String id;
  final String reporterId;
  final String reporterName;
  final String targetType; // 'store', 'user', 'review' 등
  final String targetId;
  final String reason;
  final String description;
  final String status; // 'pending', 'investigating', 'resolved', 'dismissed'
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? resolvedAt;
  final String? adminNotes;

  Report({
    required this.id,
    required this.reporterId,
    required this.reporterName,
    required this.targetType,
    required this.targetId,
    required this.reason,
    required this.description,
    this.status = 'pending',
    required this.createdAt,
    required this.updatedAt,
    this.resolvedAt,
    this.adminNotes,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] as String,
      reporterId: json['reporterId'] as String,
      reporterName: json['reporterName'] as String,
      targetType: json['targetType'] as String,
      targetId: json['targetId'] as String,
      reason: json['reason'] as String,
      description: json['description'] as String,
      status: json['status'] as String? ?? 'pending',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      resolvedAt: json['resolvedAt'] != null 
          ? DateTime.parse(json['resolvedAt'] as String) 
          : null,
      adminNotes: json['adminNotes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reporterId': reporterId,
      'reporterName': reporterName,
      'targetType': targetType,
      'targetId': targetId,
      'reason': reason,
      'description': description,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'resolvedAt': resolvedAt?.toIso8601String(),
      'adminNotes': adminNotes,
    };
  }

  Report copyWith({
    String? id,
    String? reporterId,
    String? reporterName,
    String? targetType,
    String? targetId,
    String? reason,
    String? description,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
    String? adminNotes,
  }) {
    return Report(
      id: id ?? this.id,
      reporterId: reporterId ?? this.reporterId,
      reporterName: reporterName ?? this.reporterName,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      reason: reason ?? this.reason,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      adminNotes: adminNotes ?? this.adminNotes,
    );
  }

  bool get isResolved => status == 'resolved' || status == 'dismissed';
}
