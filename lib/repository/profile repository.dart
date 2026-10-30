import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ProfileRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      debugPrint("Error sending password reset: $e");
      return false;
    }
  }

  Future<String> checkSellerVerificationStatus() async {
    User? user = _auth.currentUser;
    if (user == null) return "Not Verified";

    try {
      DocumentSnapshot doc = await _firestore.collection("sellers").doc(user.uid).get();
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        return data["kycStatus"] ?? "Not Verified";
      }
    } catch (e) {
      debugPrint("Error checking status: $e");
    }
    return "Not Verified";
  }

  Future<Map<String, dynamic>?> fetchProfileData() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return null;

    try {
      DocumentSnapshot doc = await _firestore
          .collection("sellers")
          .doc(currentUser.uid)
          .get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>?;
      }
    } catch (e) {
      debugPrint("Error loading profile: $e");
    }
    return null;
  }

  Future<bool> saveProfileData({
    required String name,
    required String email,
    required String phone,
    required String location,
  }) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return false;

    try {
      await _firestore.collection("sellers").doc(currentUser.uid).set({
        "name": name,
        "email": email,
        "phone": phone,
        "location": location,
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      debugPrint("Error saving profile: $e");
      return false;
    }
  }

  Future<bool> submitForVerification() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return false;

    try {
      await _firestore.collection("sellers").doc(currentUser.uid).set({
        "kycStatus": "Pending",
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      debugPrint("Error submitting documents: $e");
      return false;
    }
  }

  Stream<DocumentSnapshot> getSellerVerificationStream(String userId) {
    if (userId.isEmpty) {
      return const Stream.empty();
    }
    return _firestore
        .collection("sellers")
        .doc(userId)
        .snapshots();
  }
}