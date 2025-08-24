class StampStatus {
  final int collected;  // 현재 모은 스탬프 수
  final int total;      // 총 칸수 (30)
  final int perCoupon;  // 쿠폰 1장 당 스탬프 수 (10)

  const StampStatus({
    required this.collected,
    required this.total,
    required this.perCoupon,
  });

  factory StampStatus.fromJson(Map<String, dynamic> j) => StampStatus(
        collected: j['collected'] as int,
        total: j['total'] as int,
        perCoupon: j['perCoupon'] as int,
      );

  Map<String, dynamic> toJson() => {
        'collected': collected,
        'total': total,
        'perCoupon': perCoupon,
      };
}
