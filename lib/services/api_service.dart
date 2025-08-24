import 'dart:convert';
import 'package:http/http.dart' as http;
import '../common/constants/env.dart';
import '../models/stamp_status.dart';

/// 서비스 공용 인터페이스
abstract class IApiService {
  Future<StampStatus> fetchStampStatus({required String userId});
}

/// 실제 서버용 구현
class ApiService implements IApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<StampStatus> fetchStampStatus({required String userId}) async {
    final uri = Uri.parse('${Env.baseUrl}/api/stamps/status?userId=$userId');
    final res = await _client.get(uri, headers: {
      'Content-Type': 'application/json',
      // 필요시 인증 토큰 헤더 추가
      // 'Authorization': 'Bearer <token>',
    });

    if (res.statusCode != 200) {
      throw Exception('fetchStampStatus failed (${res.statusCode}) ${res.body}');
    }

    final jsonMap = json.decode(res.body) as Map<String, dynamic>;
    return StampStatus.fromJson(jsonMap);
  }
}

/// 임시 목업 구현 (백엔드 준비 전)
class MockApiService implements IApiService {
  @override
  Future<StampStatus> fetchStampStatus({required String userId}) async {
    await Future.delayed(const Duration(milliseconds: 400)); // 로딩 감 만들어주기
    return const StampStatus(
      collected: 12,  // 지금 화면에 보일 데모 데이터
      total: 30,
      perCoupon: 10,
    );
  }
}

/// 스위치 한 줄로 목업/실서버 전환
class ApiFactory {
  static IApiService create() {
    if (Env.useMock) return MockApiService();
    return ApiService();
  }
}
