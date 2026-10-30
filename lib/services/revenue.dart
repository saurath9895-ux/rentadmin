import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class RevenueService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getRevenueBookingsStream() {
    try {
      return _firestore.collection("bookings").snapshots();
    } catch (e) {
      debugPrint("Error fetching revenue bookings stream: $e");
      return const Stream.empty();
    }
  }
}