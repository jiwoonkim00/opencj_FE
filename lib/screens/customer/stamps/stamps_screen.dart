import 'package:flutter/material.dart';
import '../../../models/stamp_status.dart';
import '../../../services/api_service.dart';

class StampsScreen extends StatefulWidget {
  const StampsScreen({super.key});

  @override
  State<StampsScreen> createState() => _StampsScreenState();
}

class _StampsScreenState extends State<StampsScreen> {
  late Future<StampStatus> _future;

  @override
  void initState() {
    super.initState();
    // TODO: 실제론 로그인/프로필에서 userId를 가져오도록!
    _future = ApiFactory.create().fetchStampStatus(userId: 'demo-user-1');
  }

  Future<void> _refresh() async {
    setState(() {
      _future = ApiFactory.create().fetchStampStatus(userId: 'demo-user-1');
    });
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("내 스탬프 현황"),
      ),
      body: FutureBuilder<StampStatus>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return _ErrorView(
              message: '스탬프 정보를 불러오지 못했어요.',
              detail: snap.error.toString(),
              onRetry: _refresh,
            );
          }
          final data = snap.data!;
          return RefreshIndicator(
            onRefresh: _refresh,
            child: _StampBody(data: data),
          );
        },
      ),
    );
  }
}

class _StampBody extends StatelessWidget {
  const _StampBody({required this.data});
  final StampStatus data;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final double progress =
        (data.collected / data.total).clamp(0, 1).toDouble();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 상단 진행도
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${data.collected} / ${data.total}개',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            Text('${(progress * 100).round()}%'),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: progress,
          color: cs.primary,
          backgroundColor: cs.primaryContainer.withOpacity(0.3),
          minHeight: 10,
          borderRadius: BorderRadius.circular(8),
        ),
        const SizedBox(height: 20),

        // 스탬프 그리드
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.total,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, // 한 줄 5칸 → 30칸이면 6줄
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, i) {
            final collected = i < data.collected;
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: collected ? cs.primary : Colors.white,
                border: Border.all(color: cs.primary, width: 1.4),
                boxShadow: const [
                  BoxShadow(blurRadius: 4, color: Colors.black12),
                ],
              ),
              child: Center(
                child: collected
                    ? const Icon(Icons.check_rounded,
                        color: Colors.white, size: 20)
                    : Text('${i + 1}',
                        style: const TextStyle(color: Colors.black54)),
              ),
            );
          },
        ),
        const SizedBox(height: 16),

        // 안내 배너
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cs.primaryContainer.withOpacity(0.25),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.primary.withOpacity(0.3)),
          ),
          child: const Text(
            '스탬프 10개마다 무료 음료 쿠폰 1장을 드려요!',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.detail,
    required this.onRetry,
  });

  final String message;
  final String detail;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 36, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(message, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(detail, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: const Text('다시 시도'),
            ),
          ],
        ),
      ),
    );
    }
}
