import 'package:flutter/material.dart';

class StampsScreen extends StatelessWidget {
  const StampsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(child: Text('스탬프 화면', style: TextStyle(fontSize: 22))),
    );
  }
}
