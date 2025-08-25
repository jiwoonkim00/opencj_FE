import 'package:flutter/material.dart';

class CouponBoxScreen extends StatelessWidget {
  const CouponBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('쿠폰함'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCouponItem("20% 할인 쿠폰", "반올림피자", "2024.12.31까지", Colors.orange),
          _buildCouponItem("5,000원 할인", "면식당", "2024.12.25까지", Colors.blue),
          _buildCouponItem("첫 방문 30% 할인", "자연을 담은 돈까스", "2024.12.20까지", Colors.green),
          _buildCouponItem("음료 무료", "커피향", "2024.12.15까지", Colors.purple),
        ],
      ),
    );
  }

  Widget _buildCouponItem(String title, String store, String expiry, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.card_giftcard,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: color,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(store),
            Text(
              expiry,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // TODO: 쿠폰 사용 기능
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
          ),
          child: const Text("사용하기"),
        ),
      ),
    );
  }
}
