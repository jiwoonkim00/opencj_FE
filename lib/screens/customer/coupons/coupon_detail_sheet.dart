import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:opencj_fe/models/coupon.dart'; // ✅ 모델만 import

class CouponDetailSheet extends StatelessWidget {
  final Coupon coupon;
  const CouponDetailSheet({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.82,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ListView(
          controller: controller,
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 4),
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('쿠폰함',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),

            // 쿠폰 카드
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE26B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  Text(
                    coupon.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text('~ ${_fmt(coupon.expiresAt)} 까지'),
                  const SizedBox(height: 10),

                  // ✅ 에셋/네트워크 자동 분기
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _buildCouponImage(coupon.imageUrl),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 12),

            // 바코드
            Center(
              child: Column(
                children: [
                  BarcodeWidget(
                    barcode: Barcode.code128(),
                    data: coupon.id,
                    width: 280,
                    height: 80,
                  ),
                  const SizedBox(height: 8),
                  Text(coupon.id, style: const TextStyle(letterSpacing: 2)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              '• 매장 결제 시 직원에게 바코드를 보여주세요.\n'
              '• 유효기간 내 1회 사용 가능합니다.\n'
              '• 일부 매장 제외/품절 가능.',
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  // 에셋/네트워크 이미지 자동 처리
  Widget _buildCouponImage(String path) {
    const double h = 180;
    if (path.startsWith('http')) {
      return Image.network(
        path,
        height: h,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _imageError(h),
      );
    } else {
      return Image.asset(
        path,
        height: h,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _imageError(h),
      );
    }
  }

  Widget _imageError(double h) => Container(
        height: h,
        color: Colors.black12,
        alignment: Alignment.center,
        child: const Text('이미지를 불러오지 못했습니다'),
      );

  String _fmt(DateTime d) =>
      '${d.year}.${d.month.toString().padLeft(2, '0')}.${d.day.toString().padLeft(2, '0')}';
}
