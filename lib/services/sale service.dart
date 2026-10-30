import 'package:cloud_firestore/cloud_firestore.dart';

class SalesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> fetchTransactionDetails(String transactionId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection("transactions").doc(transactionId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print("Error fetching transaction details: $e");
    }
    return null;
  }
}