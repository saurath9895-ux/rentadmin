import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> getSellerProductsStream(String statusFilter) {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return const Stream.empty();

    Query query = _firestore
        .collection("products")
        .where("sellerId", isEqualTo: currentUser.uid);

    if (statusFilter != "All") {
      query = query.where("status", isEqualTo: statusFilter);
    }

    return query.snapshots();
  }

  Future<bool> addProduct({
    required String name,
    required String category,
    required double price,
    required String description,
  }) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return false;

    try {
      await _firestore.collection("products").add({
        "sellerId": currentUser.uid,
        "name": name,
        "category": category,
        "price": price,
        "description": description,
        "status": "Pending",
        "createdAt": FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      debugPrint("Error adding product: $e");
      return false;
    }
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      await _firestore.collection("products").doc(productId).delete();
      return true;
    } catch (e) {
      debugPrint("Error deleting product: $e");
      return false;
    }
  }

  Future<Map<String, dynamic>?> fetchSellerDetails(String sellerId) async {
    if (sellerId.isEmpty) return null;
    try {
      var doc = await _firestore.collection("sellers").doc(sellerId).get();
      if (doc.exists) {
        return doc.data();
      }
    } catch (e) {
      debugPrint("Error fetching seller details: $e");
    }
    return null;
  }
}