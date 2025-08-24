import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onTapMap});

  /// 하단 중앙의 지도 탭을 열도록 부모(_CustomerTabShell)에게 알리는 콜백
  final VoidCallback onTapMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined),
            onPressed: onTapMap, // ← 페이지 push 말고 탭 전환
          ),
        ],
      ),
      body: Column(
        children: [
          // 지도 목업 영역
          AspectRatio(
            aspectRatio: 1.1,
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text('지도 영역 (추후 연동)')),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '추천 가게',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) => Container(
                width: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(blurRadius: 6, color: Colors.black12)
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: Image.network(
                        'https://picsum.photos/seed/$i/120/120',
                        width: 110,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                          '김사장 커피\n아메리카노 1500원 이벤트',
                          maxLines: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
