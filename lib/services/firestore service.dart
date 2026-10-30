import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot?> getDocument(String collection, String docId) async {
    try {
      return await _firestore.collection(collection).doc(docId).get();
    } catch (e) {
      debugPrint("Firestore fetch error: $e");
      return null;
    }
  }

  Future<bool> setDocument(String collection, String docId, Map<String, dynamic> data, {bool merge = true}) async {
    try {
      await _firestore.collection(collection).doc(docId).set(data, SetOptions(merge: merge));
      return true;
    } catch (e) {
      debugPrint("Firestore write error: $e");
      return false;
    }
  }

  Stream<QuerySnapshot> streamCollection(String collection, {String? orderBy, bool descending = false}) {
    Query query = _firestore.collection(collection);
    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }
    return query.snapshots();
  }
}