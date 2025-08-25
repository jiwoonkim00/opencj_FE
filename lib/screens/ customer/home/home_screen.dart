import 'package:flutter/material.dart';
import '../../../models/store.dart';
import '../../../models/promotion.dart';
import '../../customer/receipt/receipt_camera_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 샘플 맛집 데이터
    final List<Store> nearbyStores = [
      Store(
        id: '1',
        name: '반올림피자',
        description: '신선한 재료로 만드는 맛있는 피자',
        imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&h=300&fit=crop&crop=center',
        price: '20,000원',
        rating: 4.5,
        reviewCount: 128,
        category: '피자',
        isFavorite: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Store(
        id: '2',
        name: '면식당',
        description: '정통 면 요리 전문점',
        imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400&h=300&fit=crop&crop=center',
        price: '14,000원',
        rating: 4.3,
        reviewCount: 95,
        category: '면요리',
        isFavorite: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Store(
        id: '3',
        name: '자연을 담은 돈까스',
        description: '바삭한 돈까스와 신선한 샐러드',
        imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400&h=300&fit=crop&crop=center',
        price: '12,000원',
        rating: 4.7,
        reviewCount: 156,
        category: '돈까스',
        isFavorite: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             // 🔸 배너 (20% 할인)
Container(
  width: double.infinity,
  decoration: BoxDecoration(
    color: Colors.orange[300],
    borderRadius: BorderRadius.circular(12),
  ),
  padding: const EdgeInsets.all(20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // 왼쪽 텍스트 영역
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "20%",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "근처 맛집 방문시\n즉시 할인!",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12),
          // 버튼
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                "자세히 보기",
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ),
          ),
        ],
      ),

      // 오른쪽 이미지 영역
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          "assets/images/banner.png", // 업로드한 이미지 경로
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    ],
  ),
),
              const SizedBox(height: 24),

              // 🔸 오늘의 미션 (탭 시 상세 모달)
              Center(
                child: InkWell(
                  onTap: () {
                    _showMissionDialog(context);
                  },
                  child: const Text(
                    "오늘의 미션!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 🔸 근처 맛집 타이틀
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "근처 맛집",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("더보기",
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold)),
                ],
              ),

              const SizedBox(height: 12),

              // 🔸 맛집 리스트 (가로 스크롤)
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: nearbyStores.length,
                  itemBuilder: (context, index) {
                    return _buildFoodCard(nearbyStores[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMissionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            bool isChecked = false;
            int cafeSteps = 0; // 0 -> 1 -> 2 (완료)
            return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(20),
                    children: [
                  // 헤더
                  Row(
                    children: const [
                      Icon(Icons.event_available, color: Colors.orange, size: 28),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '오늘의 미션을 완료하고\n쿠폰 받아가세요!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 출석 체크 카드
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('📌', style: TextStyle(fontSize: 20)),
                            const SizedBox(width: 8),
                            const Text(
                              '오늘 출석 체크하기',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Text(
                              '${(isChecked ? 1 : 0) + (cafeSteps == 2 ? 1 : 0)} / 2 완료',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text('버튼을 눌러 출석을 체크하세요'),
                        const Text('(( 스탬프 증정 ))', style: TextStyle(color: Colors.grey)),
                        const SizedBox(height: 12),
                        // 진행 바
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: isChecked ? 1 : 0,
                            minHeight: 12,
                            backgroundColor: Colors.orange[100],
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (!isChecked) {
                                setState(() {
                                  isChecked = true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('출석이 완료되었습니다.')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isChecked ? Colors.orange : Colors.grey[300],
                              foregroundColor: isChecked ? Colors.white : Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text(
                              isChecked ? '출석완료' : '출석하기',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 근처 카페 방문하기 카드 (2단계 진행)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.local_cafe, color: Colors.brown),
                            const SizedBox(width: 8),
                            const Text(
                              '근처 카페 방문하기',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Text(
                              '${(isChecked ? 1 : 0) + (cafeSteps == 2 ? 1 : 0)} / 2 완료',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text('버튼을 눌러 미션을 수행해보세요.'),
                        const SizedBox(height: 12),
                        // 진행 바
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: cafeSteps / 2,
                            minHeight: 12,
                            backgroundColor: Colors.orange[100],
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (cafeSteps < 2) {
                                setState(() {
                                  cafeSteps += 1;
                                });
                                if (cafeSteps == 2) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('카페 방문 미션이 완료되었습니다.')),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cafeSteps == 2 ? Colors.orange : Colors.grey[300],
                              foregroundColor: cafeSteps == 2 ? Colors.white : Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text(
                              cafeSteps == 0
                                  ? '1/2 진행하기'
                                  : (cafeSteps == 1 ? '2/2 진행하기' : '미션완료'),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 영수증 인증샷 이벤트 카드
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.photo_camera, color: Colors.black87),
                            SizedBox(width: 8),
                            Text('영수증 인증샷 이벤트', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text('방문 인증으로 스탬프를 모아보세요!'),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _MissionSquareButton(
                              icon: Icons.image_outlined,
                              label: '영수증',
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const ReceiptCameraScreen(),
                                  ),
                                );
                              },
                            ),
                            _MissionSquareButton(
                              icon: Icons.edit_outlined,
                              label: '리뷰작성',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  // 카드 위젯
  Widget _buildFoodCard(Store store) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(store.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            store.rating.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (store.isFavorite)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            store.name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            store.price,
            style: const TextStyle(fontSize: 13, color: Colors.redAccent),
          ),
          Text(
            store.description,
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _MissionSquareButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MissionSquareButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: const Color(0xFFF4D37B),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black87),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
