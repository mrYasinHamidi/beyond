import 'dart:convert';

import 'package:beyond/features/auth/domain/entities/country_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
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

  Future<List<CountryInfo>> loadCountries() async {
    final jsonString = await rootBundle.loadString('assets/country_phone_name.json');

    final Map<String, dynamic> raw = jsonDecode(jsonString);

    final list = raw.entries.map((e) => CountryInfo.fromMap(e.key, e.value)).toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    return list;
  }

  Future<void> signOut() => _firebaseAuth.signOut();
}
