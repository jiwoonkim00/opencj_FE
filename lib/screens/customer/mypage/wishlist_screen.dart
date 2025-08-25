import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('찜 목록'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildWishlistItem("반올림피자", "20,000원", "피자 맛집", Icons.local_pizza),
          _buildWishlistItem("면식당", "14,000원", "면 요리 전문점", Icons.ramen_dining),
          _buildWishlistItem("자연을 담은 돈까스", "12,000원", "돈까스 맛집", Icons.restaurant),
          _buildWishlistItem("커피향", "8,000원", "카페", Icons.coffee),
        ],
      ),
    );
  }

  Widget _buildWishlistItem(String name, String price, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.orange[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.orange[600]),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(description),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              price,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                // TODO: 찜 해제 기능
              },
            ),
          ],
        ),
      ),
    );
  }
}
