import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AdminLoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> authenticateAdmin(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      debugPrint("Admin login error: $e");
      return e.toString();
    }
  }
}