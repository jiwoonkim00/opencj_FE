import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:package_info_plus/package_info_plus.dart'; // ▲ 추가: 런타임 패키지명 확인

import 'screens/customer/home/home_screen.dart';
import 'screens/customer/stamps/stamps_screen.dart';
import 'screens/customer/coupons/coupons_screen.dart';
import 'screens/customer/map/naver_map_screen.dart';
import 'screens/customer/mypage/mypage_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ▲ 추가: 실행 중 패키지명 로그 (콘솔 등록과 1자도 같아야 함: com.example.opencj_fe)
  final info = await PackageInfo.fromPlatform();
  debugPrint('>> runtime packageName = ${info.packageName}');

  await NaverMapSdk.instance.initialize(
    clientId: 'va7neppws3', // ✅ 네이버 콘솔의 Client ID (API KEY ID)
    onAuthFailed: (e) {
      debugPrint('>> onAuthFailed: $e'); // 실패 사유 콘솔 출력
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OpenCJ FE',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFFFE1B3),
      ),
      home: const _CustomerTabShell(),
    );
  }
}

class _CustomerTabShell extends StatefulWidget {
  const _CustomerTabShell({super.key});
  @override
  State<_CustomerTabShell> createState() => _CustomerTabShellState();
}

class _CustomerTabShellState extends State<_CustomerTabShell> {
  static const int homeIndex = 0;
  static const int stampsIndex = 1;
  static const int mapIndex = 2; // 가운데 FAB (지도)
  static const int couponsIndex = 3;
  static const int myPageIndex = 4;

  int _index = homeIndex;

  late final List<Widget> _pages = [
    HomeScreen(onTapMap: () => setState(() => _index = mapIndex)),
    const StampsScreen(),
    const NaverMapScreen(),
    const CouponsScreen(),
    const MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedColor = const Color(0xFFFF8A00);
    final unselectedColor = Colors.black45;

    return Scaffold(
      body: _pages[_index],

      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        elevation: 4,
        onPressed: () => setState(() => _index = mapIndex),
        child: Icon(
          Icons.place_rounded,
          color: _index == mapIndex ? selectedColor : unselectedColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: SafeArea(
        top: false,
        child: BottomAppBar(
          elevation: 8,
          height: 68,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _BarItem(
                        icon: Icons.home_outlined,
                        label: '홈',
                        selected: _index == homeIndex,
                        onTap: () => setState(() => _index = homeIndex),
                        selectedColor: selectedColor,
                      ),
                      _BarItem(
                        icon: Icons.emoji_events_outlined,
                        label: '스탬프',
                        selected: _index == stampsIndex,
                        onTap: () => setState(() => _index = stampsIndex),
                        selectedColor: selectedColor,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _BarItem(
                        icon: Icons.card_giftcard_outlined,
                        label: '쿠폰함',
                        selected: _index == couponsIndex,
                        onTap: () => setState(() => _index = couponsIndex),
                        selectedColor: selectedColor,
                      ),
                      _BarItem(
                        icon: Icons.person_outline,
                        label: '마이페이지',
                        selected: _index == myPageIndex,
                        onTap: () => setState(() => _index = myPageIndex),
                        selectedColor: selectedColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BarItem extends StatelessWidget {
  const _BarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    required this.selectedColor,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    final color = selected ? selectedColor : Colors.black45;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 60,
          maxWidth: 76,
          minHeight: 36,
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    height: 1.0,
                    color: color,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                  softWrap: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
