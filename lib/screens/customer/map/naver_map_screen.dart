// lib/screens/customer/map/naver_map_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class NaverMapScreen extends StatefulWidget {
  const NaverMapScreen({super.key});

  @override
  State<NaverMapScreen> createState() => _NaverMapScreenState();
}

class _NaverMapScreenState extends State<NaverMapScreen> {
  NaverMapController? _mapController;

  // 데모용 가게 데이터
  final List<_Shop> _shops = const [
    _Shop(
      id: 'shop_1',
      name: '김사장 커피',
      lat: 37.56685,
      lng: 126.9780,
      rating: 4.8,
      reviews: 125,
      imageUrl:
          'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=700&auto=format&fit=crop',
    ),
    _Shop(
      id: 'shop_2',
      name: '동네 빵집',
      lat: 37.5655,
      lng: 126.9772,
      rating: 4.6,
      reviews: 89,
      imageUrl:
          'https://images.unsplash.com/photo-1519681393784-d120267933ba?q=80&w=700&auto=format&fit=crop',
    ),
    _Shop(
      id: 'shop_3',
      name: '수제 파스타',
      lat: 37.5676,
      lng: 126.9762,
      rating: 4.7,
      reviews: 208,
      imageUrl:
          'https://images.unsplash.com/photo-1516100882582-96c3a05fe590?q=80&w=700&auto=format&fit=crop',
    ),
  ];

  // 마커 저장
  final Map<String, NMarker> _markers = {};

  // 초기 카메라 위치 (서울 시청 근처)
  static const NLatLng _center = NLatLng(37.5665, 126.9780);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: const Color(0xFFFEF5EE),
        body: Stack(
          children: [
            // === 지도 ===
            NaverMap(
              options: const NaverMapViewOptions(
                initialCameraPosition: NCameraPosition(
                  target: _center,
                  zoom: 14,
                ),
                logoClickEnable: false,
                locationButtonEnable: true,
                consumeSymbolTapEvents: false,
              ),
              onMapReady: (controller) async {
                _mapController = controller;
                _addMarkers();
              },
            ),

            // === 상단 검색바 & 액션 ===
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              left: 12,
              right: 12,
              child: _TopBar(
                onMenu: () {},
                onAlarm: () {},
                onSearch: () {},
              ),
            ),

            // === 하단 추천 리스트 ===
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _BottomCards(
                shops: _shops,
                onTapCard: _focusToShop,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 마커 추가
  void _addMarkers() {
    if (_mapController == null) return;

    for (final s in _shops) {
      final marker = NMarker(
        id: s.id,
        position: NLatLng(s.lat, s.lng),
        // 색상 랜덤(데모용)
        iconTintColor: HSLColor.fromAHSL(
          1, Random().nextDouble() * 360, .65, .55,
        ).toColor(),
      );
      marker.setOnTapListener((_) => _focusToShop(s));
      _markers[s.id] = marker;
    }

    // ✅ Set<NAddableOverlay> 로 전달 (타입 에러 해결)
    _mapController!
        .addOverlayAll(_markers.values.cast<NAddableOverlay>().toSet());
  }

  // 카드/마커 탭 → 카메라 이동 + 간단한 인포 윈도우
  Future<void> _focusToShop(_Shop s) async {
    if (_mapController == null) return;
    await _mapController!.updateCamera(
      NCameraUpdate.scrollAndZoomTo(
        target: NLatLng(s.lat, s.lng),
        zoom: 15,
      ),
    );

    final info = NInfoWindow.onMarker(id: 'info_${s.id}', text: s.name);
    final m = _markers[s.id];
    if (m != null) m.openInfoWindow(info);
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.onMenu,
    required this.onAlarm,
    required this.onSearch,
  });

  final VoidCallback onMenu;
  final VoidCallback onAlarm;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleIcon(icon: Icons.menu_rounded, onTap: onMenu),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: onSearch,
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black12)],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.black45),
                  SizedBox(width: 8),
                  Text('search', style: TextStyle(color: Colors.black54)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _CircleIcon(icon: Icons.notifications_none_rounded, onTap: onAlarm),
      ],
    );
  }
}

class _CircleIcon extends StatelessWidget {
  const _CircleIcon({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 4,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          width: 42,
          height: 42,
          child: Icon(Icons.circle, color: Colors.black87), // 아이콘은 InkWell 위젯 바깥에서 바꿔줌
        ),
      ),
    );
  }
}

class _BottomCards extends StatelessWidget {
  const _BottomCards({required this.shops, required this.onTapCard});
  final List<_Shop> shops;
  final void Function(_Shop) onTapCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text('추천 음식점 및 카페',
                style: TextStyle(fontWeight: FontWeight.w800)),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 130,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemCount: shops.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) => _ShopCard(
                shop: shops[i],
                onTap: () => onTapCard(shops[i]),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _ShopCard extends StatelessWidget {
  const _ShopCard({required this.shop, required this.onTap});
  final _Shop shop;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: SizedBox(
          width: 220,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(14)),
                child: Image.network(
                  shop.imageUrl,
                  width: 90,
                  height: 130,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 90,
                    height: 130,
                    color: Colors.black12,
                    alignment: Alignment.center,
                    child: const Icon(Icons.image_not_supported),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shop.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              size: 16, color: Color(0xFFFFB300)),
                          const SizedBox(width: 4),
                          Text('${shop.rating}',
                              style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(width: 6),
                          Text('리뷰 ${shop.reviews}',
                              style: const TextStyle(color: Colors.black45)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Shop {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final double rating;
  final int reviews;
  final String imageUrl;

  const _Shop({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
  });
}
