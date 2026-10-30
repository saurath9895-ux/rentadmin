import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class BookingDetailsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> fetchUserDetails(String sellerId) async {
    if (sellerId.isEmpty) return null;
    try {
      DocumentSnapshot doc = await _firestore.collection("sellers").doc(sellerId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>?;
      }
    } catch (e) {
      debugPrint("Error fetching seller/user details: $e");
    }
    return null;
  }

  Future<bool> updateBookingStatus(String bookingId, String newStatus) async {
    if (bookingId.isEmpty) return false;
    try {
      await _firestore.collection("bookings").doc(bookingId).update({
        "status": newStatus,
      });
      return true;
    } catch (e) {
      debugPrint("Error updating booking status: $e");
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