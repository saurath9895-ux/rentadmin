import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../model/transaction model.dart';

class SalesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getRevenueBookingsStream() {
    return _firestore.collection("bookings").snapshots();
  }

  Stream<QuerySnapshot> getSellerSalesStream(String sellerId) {
    if (sellerId.isEmpty) return Stream.empty();
    return _firestore
        .collection("bookings")
        .where("sellerId", isEqualTo: sellerId)
        .snapshots();
  }

  Future<Map<String, dynamic>?> fetchTransactionDetails(String transactionId) async {
    if (transactionId.isEmpty) return null;
    try {
      DocumentSnapshot doc = await _firestore.collection("bookings").doc(transactionId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>?;
      }
    } catch (e) {
      debugPrint("Error fetching transaction: $e");
    }
    return null;
  }

  Future<TransactionModel?> getTransactionDetails(String transactionId) async {
    var data = await fetchTransactionDetails(transactionId);
    if (data != null) {
      return TransactionModel.fromMap(data, transactionId);
    }
    return null;
  }
}