import 'package:flutter/material.dart';
import '../repository/seller detail repository.dart';

class SellerDetailsViewModel extends ChangeNotifier {
  final SellerDetailsRepository _repository = SellerDetailsRepository();

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;

  Future<void> handleAcceptSeller({
    required BuildContext context,
    required String sellerId,
    required VoidCallback onSuccess,
  }) async {
    _isUpdating = true;
    notifyListeners();

    bool success = await _repository.updateSellerStatus(sellerId, "Verified");

    _isUpdating = false;
    notifyListeners();

    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Seller has been verified!"), backgroundColor: Colors.green),
      );
      onSuccess();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating seller status"), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> handleRejectSeller({
    required BuildContext context,
    required String sellerId,
    required VoidCallback onSuccess,
  }) async {
    _isUpdating = true;
    notifyListeners();

    bool success = await _repository.updateSellerStatus(sellerId, "Rejected");

    _isUpdating = false;
    notifyListeners();

    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Seller has been rejected"), backgroundColor: Colors.red),
      );
      onSuccess();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating seller status"), backgroundColor: Colors.red),
      );
    }
  }
}