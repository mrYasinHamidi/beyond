import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthDataSource({required FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;

  String? _verificationId;

  Future<void> sendCode(String phone) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (cred) async => await _firebaseAuth.signInWithCredential(cred),
      verificationFailed: (e) => throw e,
      codeSent: (id, _) => _verificationId = id,
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  Future<UserCredential> verifyCode(String smsCode) async {
    if (_verificationId == null) throw StateError('sendCode not called');
    final cred = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: smsCode);
    return _firebaseAuth.signInWithCredential(cred);
  }

  Future<void> signOut() => _firebaseAuth.signOut();
}
