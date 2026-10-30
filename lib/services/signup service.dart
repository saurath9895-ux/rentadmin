import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class SignupService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> registerAdminUser({
    required String email,
    required String password,
    required Map<String, dynamic> userData,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await _firestore.collection("admins").doc(credential.user!.uid).set({
          ...userData,
          "uid": credential.user!.uid,
          "createdAt": FieldValue.serverTimestamp(),
        });
      }
      return null;
    } catch (e) {
      debugPrint("Signup error: $e");
      return e.toString();
    }
  }
}