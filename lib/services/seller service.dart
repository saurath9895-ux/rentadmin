import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SellerDetailsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> fetchSellerDetails(String sellerId) async {
    return await _firestore.collection("sellers").doc(sellerId).get();
  }

  Future<bool> updateKycStatus(String sellerId, String status) async {
    try {
      await _firestore.collection("sellers").doc(sellerId).update({
        "kycStatus": status,
        "status": status,
      });
      return true;
    } catch (e) {
      debugPrint("Error updating seller status: $e");
      return false;
    }
  }
}