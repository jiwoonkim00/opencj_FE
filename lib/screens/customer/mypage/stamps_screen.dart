import 'package:flutter/material.dart';

class StampsScreen extends StatelessWidget {
  const StampsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('스탬프'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildStampCard("반올림피자", 8, 10, Icons.local_pizza),
          _buildStampCard("면식당", 5, 10, Icons.ramen_dining),
          _buildStampCard("자연을 담은 돈까스", 3, 10, Icons.restaurant),
          _buildStampCard("커피향", 7, 10, Icons.coffee),
        ],
      ),
    );
  }

  Widget _buildStampCard(String storeName, int currentStamps, int totalStamps, IconData icon) {
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Colors.yellow[600]),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        storeName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "$currentStamps / $totalStamps 스탬프",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: List.generate(totalStamps, (index) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: index < currentStamps ? Colors.yellow[400] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: index < currentStamps
                      ? const Icon(Icons.star, color: Colors.white, size: 16)
                      : null,
                );
              }),
            ),
            if (currentStamps >= totalStamps) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green),
                ),
                child: const Text(
                  "🎉 스탬프 완성! 쿠폰을 받으세요!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
