class Coupon {
  final String id;           // 바코드/식별자
  final String title;        // 쿠폰 제목
  final DateTime expiresAt;  // 유효기간
  final String imageUrl;     // 썸네일 이미지

  const Coupon({
    required this.id,
    required this.title,
    required this.expiresAt,
    required this.imageUrl,
  });
}
