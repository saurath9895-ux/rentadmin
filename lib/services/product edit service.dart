import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../model/product edit model.dart';

class DetailEditService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> updateProductData(DetailEdit model) async {
    try {
      await _firestore.collection("products").doc(model.productId).update(model.toMap());
      return true;
    } catch (e) {
      debugPrint("Error updating product: $e");
      return false;
    }
  }
}