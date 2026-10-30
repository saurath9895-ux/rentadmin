import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../model/bank model.dart';

class BankDetailsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> saveBankData(BankDetailsModel model) async {
    try {
      String uid = _auth.currentUser?.uid ?? "admin_default";
      await _firestore.collection("admin_bank_details").doc(uid).set(model.toMap());
      return true;
    } catch (e) {
      debugPrint("Error saving bank details: $e");
      return false;
    }
  }
  Stream<List<Map<String, dynamic>>> fetchBookingsStreamByStatus(String status) {
    Query query = _firestore.collection("bookings");
    if (status != "All") {
      query = query.where("status", isEqualTo: status);
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data["id"] = doc.id;
        return data;
      }).toList();
    });
  }
}