import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../repository/bookingrepository.dart';

class BookingViewModel extends ChangeNotifier {
  final BookingDetailsRepository _repository = BookingDetailsRepository();

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;

  Stream<List<Map<String, dynamic>>> getBookingsByStatusStream(String status) {
    return _repository.getBookingsStreamByStatus(status).map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>? ?? {};
        data["id"] = doc.id;
        return data;
      }).toList();
    });
  }

  Stream<List<Map<String, dynamic>>> fetchBookingsByStatusStream(String status) {
    return getBookingsByStatusStream(status);
  }

  Future<Map<String, dynamic>?> fetchUserDetails(String userId) async {
    return await _repository.getUserDetails(userId);
  }

  Future<void> handleMarkAsReturned({
    required BuildContext context,
    required String bookingId,
    required int securityAmount,
    required VoidCallback onSuccess,
  }) async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Complete Booking?"),
        content: Text("Have you inspected the item and confirmed it's returned safely?\n\nRemember to trigger the ₹$securityAmount security deposit refund from your Razorpay dashboard."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Yes, Complete", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ) ?? false;

    if (confirm) {
      _isUpdating = true;
      notifyListeners();

      bool success = await _repository.updateStatus(bookingId, "Completed");

      _isUpdating = false;
      notifyListeners();

      if (!context.mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Booking marked as Completed!"), backgroundColor: Colors.green),
        );
        onSuccess();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error updating status."), backgroundColor: Colors.red),
        );
      }
    }
  }
}