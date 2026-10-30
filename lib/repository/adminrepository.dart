import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AdminRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> updateUserStatus(String userId, String newStatus) async {
    try {
      await _firestore.collection("users").doc(userId).set({
        "status": newStatus,
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      debugPrint("Error updating user status: $e");
      return false;
    }
  }

  Stream<QuerySnapshot> getUsersFilteredByStatusStream(String statusFilter) {
    Query query = _firestore.collection("users");

    if (statusFilter != "All") {
      query = query.where("status", isEqualTo: statusFilter);
    }

    return query.snapshots();
  }

  Stream<QuerySnapshot> getUsersStream() {
    return _firestore.collection("users").snapshots();
  }

  Stream<QuerySnapshot> getSellersByStatusStream(String statusFilter) {
    Query query = _firestore.collection("sellers");

    if (statusFilter == "Active") {
      query = query.where("kycStatus", whereIn: ["Active", "Verified"]);
    } else {
      query = query.where("kycStatus", isEqualTo: statusFilter);
    }

    return query.snapshots();
  }

  Stream<QuerySnapshot> getCollectionCountStream(String collectionName) {
    return _firestore.collection(collectionName).snapshots();
  }

  Future<bool> updateSellerKycStatus(String sellerId, String newStatus) async {
    try {
      await _firestore.collection("sellers").doc(sellerId).set({
        "kycStatus": newStatus,
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      debugPrint("Error updating seller status: $e");
      return false;
    }
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      debugPrint("Error sending password reset: $e");
      return false;
    }
  }
}