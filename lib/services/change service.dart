import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';



class ChangePasswordService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      debugPrint("Password reset error: $e");
      return e.toString();
    }
  }
}
