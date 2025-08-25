import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // 현재 사용자 상태 스트림
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  
  // 현재 로그인된 사용자
  User? get currentUser => _auth.currentUser;
  
  // 이메일/비밀번호로 회원가입
  Future<UserCredential> signUpWithEmailAndPassword(
    String email, 
    String password,
    String name,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // 사용자 프로필 업데이트
      await credential.user?.updateDisplayName(name);
      
      return credential;
    } catch (e) {
      throw Exception('회원가입 실패: $e');
    }
  }
  
  // 이메일/비밀번호로 로그인
  Future<UserCredential> signInWithEmailAndPassword(
    String email, 
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('로그인 실패: $e');
    }
  }
  
  // 로그아웃
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('로그아웃 실패: $e');
    }
  }
  
  // 비밀번호 재설정 이메일 전송
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('비밀번호 재설정 이메일 전송 실패: $e');
    }
  }
  
  // 사용자 프로필 업데이트
  Future<void> updateProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      await _auth.currentUser?.updateDisplayName(displayName);
      if (photoURL != null) {
        await _auth.currentUser?.updatePhotoURL(photoURL);
      }
    } catch (e) {
      throw Exception('프로필 업데이트 실패: $e');
    }
  }
  
  // 사용자 삭제
  Future<void> deleteUser() async {
    try {
      await _auth.currentUser?.delete();
    } catch (e) {
      throw Exception('계정 삭제 실패: $e');
    }
  }
}
