import 'package:cloud_firestore/cloud_firestore.dart';

class BookingDetailsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getBookingsStreamByStatus(String status) {
    if (status.toLowerCase() == "all") {
      return _firestore.collection('bookings').snapshots();
    }
    return _firestore
        .collection('bookings')
        .where('status', isEqualTo: status)
        .snapshots();
  }

  Future<Map<String, dynamic>?> getUserDetails(String userId) async {
    try {
      var doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        return doc.data();
      }

      var sellerDoc = await _firestore.collection('sellers').doc(userId).get();
      if (sellerDoc.exists && sellerDoc.data() != null) {
        return sellerDoc.data();
      }
    } catch (_) {}
    return null;
  }

  Future<bool> updateStatus(String bookingId, String status) async {
    try {
      await _firestore.collection('bookings').doc(bookingId).update({
        'status': status,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}