import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../model/admin profile model.dart';

class AdminProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AdminProfileModel fetchInitialProfile() {
    return AdminProfileModel.initial();
  }

  Future<bool> signOutAdmin() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      debugPrint("Sign out error: $e");
      return false;
    }
  }
}