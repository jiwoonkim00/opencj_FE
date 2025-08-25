import 'package:flutter/material.dart';
import 'wishlist_screen.dart';
import 'coupon_box_screen.dart';
import 'visit_history_screen.dart';
import 'stamps_screen.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              
              // 🔸 상단 프로필 섹션
              Container(
                padding: const EdgeInsets.all(20),
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
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "홍길동 님",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildIconItem(Icons.favorite_border, "찜 목록", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const WishlistScreen()),
                          );
                        }),
                        _buildIconItem(Icons.card_giftcard, "쿠폰함", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CouponBoxScreen()),
                          );
                        }),
                        _buildIconItem(Icons.shopping_cart, "방문내역", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const VisitHistoryScreen()),
                          );
                        }),
                        _buildIconItem(Icons.star_border, "스탬프", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const StampsScreen()),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 🔸 회원정보 섹션
              _buildSection("회원정보", [
                _buildMenuItem("회원정보", () {
                  // TODO: 회원정보 화면으로 이동
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('회원정보 화면으로 이동')),
                  );
                }),
                _buildMenuItem("소셜아이디 연동", () {
                  // TODO: 소셜아이디 연동 화면으로 이동
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('소셜아이디 연동 화면으로 이동')),
                  );
                }),
                _buildMenuItem("위치 정보 추가하기", () {
                  // TODO: 위치 정보 추가 화면으로 이동
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('위치 정보 추가 화면으로 이동')),
                  );
                }),
              ]),

              const SizedBox(height: 24),

              // 🔸 추천 섹션
              _buildSection("추천", [
                _buildMenuItem("추천인 코드", () {
                  // TODO: 추천인 코드 화면으로 이동
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('추천인 코드 화면으로 이동')),
                  );
                }),
                _buildMenuItem("최근 본 가게", () {
                  // TODO: 최근 본 가게 화면으로 이동
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('최근 본 가게 화면으로 이동')),
                  );
                }),
                _buildMenuItem("북마크", () {
                  // TODO: 북마크 화면으로 이동
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('북마크 화면으로 이동')),
                  );
                }),
                _buildMenuItem("FAQ", () {
                  // TODO: FAQ 화면으로 이동
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('FAQ 화면으로 이동')),
                  );
                }),
              ]),

              const SizedBox(height: 24),

              // 🔸 도움말 섹션
              _buildSection("도움말", [
                _buildMenuItem("도움말", () {
                  // TODO: 도움말 화면으로 이동
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('도움말 화면으로 이동')),
                  );
                }),
              ]),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // 아이콘 아이템 위젯
  Widget _buildIconItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              size: 24,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // 섹션 위젯
  Widget _buildSection(String title, List<Widget> items) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...items,
        ],
      ),
    );
  }

  // 메뉴 아이템 위젯
  Widget _buildMenuItem(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey[200]!,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
