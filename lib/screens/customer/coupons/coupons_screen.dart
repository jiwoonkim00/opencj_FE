import 'package:flutter/material.dart';
import 'package:opencj_fe/models/coupon.dart';
import 'coupon_detail_sheet.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final coupons = _demoCoupons;

    const panelBg = Color(0xFFFFEBD6); // 연한 살구

    return Scaffold(
      appBar: AppBar(
        title: const Text('쿠폰함'),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          // 상단 안내 섹션
          Container(
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
            decoration: BoxDecoration(
              color: panelBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('나를 위한 맞춤 쿠폰',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                SizedBox(height: 4),
                Text('사용 가능한 쿠폰을 확인해보세요!',
                    style: TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // 쿠폰 리스트
          ...coupons.map(
            (c) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: _CouponTile(
                coupon: c,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => CouponDetailSheet(coupon: c),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 쿠폰 한 개 셀
class _CouponTile extends StatelessWidget {
  const _CouponTile({required this.coupon, this.onTap});

  final Coupon coupon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12)],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: _couponImage(coupon.imageUrl),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(coupon.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _Chip(text: '사용가능', bg: const Color(0xFFECF8EE), fg: const Color(0xFF2E7D32)),
                        const SizedBox(width: 6),
                        _Chip(
                          text: '유효기간 ~ ${_fmt(coupon.expiresAt)}',
                          bg: const Color(0xFFF7F7F7),
                          fg: Colors.black87,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right_rounded, color: Colors.black38),
            ],
          ),
        ),
      ),
    );
  }

  /// 네트워크/에셋 자동 분기
  Widget _couponImage(String path) {
    const size = Size(54, 54);
    if (path.startsWith('http')) {
      return Image.network(
        path,
        width: size.width,
        height: size.height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(size),
      );
    } else {
      // asset
      return Image.asset(
        path,
        width: size.width,
        height: size.height,
        fit: BoxFit.cover,
      );
    }
  }

  static Widget _placeholder(Size size) => Container(
        width: size.width,
        height: size.height,
        color: Colors.black12,
        alignment: Alignment.center,
        child: const Icon(Icons.image_not_supported, size: 20),
      );

  static String _fmt(DateTime d) =>
      '${d.year}.${d.month.toString().padLeft(2, '0')}.${d.day.toString().padLeft(2, '0')}';
}

/// 작은 라운드 칩
class _Chip extends StatelessWidget {
  const _Chip({required this.text, required this.bg, required this.fg});
  final String text;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }
}

/// 데모용 더미 쿠폰 데이터 (asset 경로 사용)
final _demoCoupons = <Coupon>[
  Coupon(
    id: 'C-240801-0001',
    title: '메가커피 아이스 아메리카노 (ICE / HOT) 1잔 쿠폰',
    expiresAt: DateTime(2025, 8, 31),
    imageUrl: 'assets/images/메가커피.jpg', // ✅ asset
  ),
  Coupon(
    id: 'C-240801-0002',
    title: '컴포즈 커피 아이스 아메리카노 (테이크아웃)',
    expiresAt: DateTime(2025, 9, 15),
    imageUrl: 'assets/images/컴포즈.jpg', // ✅ asset
  ),
  Coupon(
    id: 'C-240801-0003',
    title: '디저트 3,000원 할인 쿠폰 (일부 지점 사용 가능)',
    expiresAt: DateTime(2025, 10, 5),
    imageUrl: 'assets/images/디저트.jpg', // ✅ asset
  ),
  Coupon(
    id: 'C-240801-0004',
    title: '네트워크 이미지 예시',
    expiresAt: DateTime(2025, 12, 31),
    imageUrl: 'assets/images/메가커피.jpg', // ✅ network
  ),
];
