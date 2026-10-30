import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class WalletRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> saveBankDetails({
    required String holder,
    required String bank,
    required String accountNumber,
    required String ifscCode,
    required String branch,
    required String accountType,
  }) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return false;

    try {
      await _firestore.collection("sellers").doc(currentUser.uid).set({
        "bankDetails": {
          "holderName": holder,
          "bankName": bank,
          "accountNumber": accountNumber,
          "ifscCode": ifscCode,
          "branchName": branch,
          "accountType": accountType,
          "updatedAt": FieldValue.serverTimestamp(),
        }
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      debugPrint("Error saving bank details: $e");
      return false;
    }
  }

  Future<Map<String, dynamic>?> fetchWalletDetails() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return null;

    try {
      DocumentSnapshot doc = await _firestore.collection("sellers").doc(currentUser.uid).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>?;
      }
    } catch (e) {
      debugPrint("Error fetching wallet details: $e");
    }
    return null;
  }
}