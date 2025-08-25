import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart' as app_models;
import '../models/store.dart';
import '../models/mission.dart';
import '../models/coupon.dart';
import '../models/promotion.dart';
import '../models/report.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // 사용자 관련
  Future<void> createUser(app_models.User user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      throw Exception('사용자 생성 실패: $e');
    }
  }
  
  Future<app_models.User?> getUser(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return app_models.User.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('사용자 조회 실패: $e');
    }
  }
  
  Future<void> updateUser(app_models.User user) async {
    try {
      await _firestore.collection('users').doc(user.id).update(user.toJson());
    } catch (e) {
      throw Exception('사용자 업데이트 실패: $e');
    }
  }
  
  // 가게 관련
  Future<List<Store>> getStores() async {
    try {
      final querySnapshot = await _firestore.collection('stores').get();
      return querySnapshot.docs
          .map((doc) => Store.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('가게 목록 조회 실패: $e');
    }
  }
  
  Future<Store?> getStore(String storeId) async {
    try {
      final doc = await _firestore.collection('stores').doc(storeId).get();
      if (doc.exists) {
        return Store.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('가게 조회 실패: $e');
    }
  }
  
  // 미션 관련
  Future<List<Mission>> getUserMissions(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('missions')
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs
          .map((doc) => Mission.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('사용자 미션 조회 실패: $e');
    }
  }
  
  Future<void> createMission(Mission mission) async {
    try {
      await _firestore.collection('missions').doc(mission.id).set(mission.toJson());
    } catch (e) {
      throw Exception('미션 생성 실패: $e');
    }
  }
  
  // 쿠폰 관련
  Future<List<Coupon>> getUserCoupons(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('coupons')
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs
          .map((doc) => Coupon.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('사용자 쿠폰 조회 실패: $e');
    }
  }
  
  // 프로모션 관련
  Future<List<Promotion>> getActivePromotions() async {
    try {
      final querySnapshot = await _firestore
          .collection('promotions')
          .where('isActive', isEqualTo: true)
          .get();
      return querySnapshot.docs
          .map((doc) => Promotion.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('활성 프로모션 조회 실패: $e');
    }
  }
  
  // 신고 관련
  Future<void> createReport(Report report) async {
    try {
      await _firestore.collection('reports').doc(report.id).set(report.toJson());
    } catch (e) {
      throw Exception('신고 생성 실패: $e');
    }
  }
  
  // 실시간 업데이트 리스너
  Stream<List<Store>> getStoresStream() {
    return _firestore
        .collection('stores')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Store.fromJson(doc.data()))
            .toList());
  }
  
  Stream<List<Mission>> getUserMissionsStream(String userId) {
    return _firestore
        .collection('missions')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Mission.fromJson(doc.data()))
            .toList());
  }
}
