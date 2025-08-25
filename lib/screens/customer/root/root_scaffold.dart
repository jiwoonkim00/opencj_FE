import 'package:flutter/material.dart';
// AppColors 사용하려면 필요
// import 'package:프로젝트이름/common/constants/app_colors.dart';

// 탭 화면들
import '../home/home_screen.dart';
import '../stamps/stamps_screen.dart';
import '../map/map_screen.dart';
import '../missions/missions_screen.dart'; // ← '리뷰' 탭으로 사용
import '../mypage/mypage_screen.dart';

class RootScaffold extends StatefulWidget {
  const RootScaffold({super.key});

  @override
  State<RootScaffold> createState() => _RootScaffoldState();
}

class _RootScaffoldState extends State<RootScaffold> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _index = 2; // 기본: 지도 탭

  final List<Widget> _tabs = [
    const HomeScreen(),
    const StampsScreen(),
    const MapScreen(),
    const MissionsScreen(), // ← 라벨은 '리뷰'
    const MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          tooltip: '메뉴',
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              const ListTile(
                title: Text(
                  '메뉴',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('홈'),
                onTap: () => _go(0),
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text('스탬프'),
                onTap: () => _go(1),
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('지도'),
                onTap: () => _go(2),
              ),
              ListTile(
                leading: const Icon(Icons.rate_review), // ✅ 수정
                title: const Text('리뷰'),
                onTap: () => _go(3),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('마이페이지'),
                onTap: () => _go(4),
              ),
            ],
          ),
        ),
      ),
      body: _tabs[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,   // ✅ 기본 색상 사용
        unselectedItemColor: Colors.grey,   // ✅ 기본 색상 사용
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: '스탬프'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: '지도'),
          BottomNavigationBarItem(
              icon: Icon(Icons.rate_review), label: '리뷰'), // ✅ 수정
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  void _go(int i) {
    Navigator.pop(context); // 드로어 닫기
    setState(() => _index = i);
  }
}

