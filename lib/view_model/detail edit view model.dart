import 'package:flutter/material.dart';
import '../model/product edit model.dart';
import '../repository/product edit repository.dart';

class DetailEditViewModel extends ChangeNotifier {
  final DetailEditRepository _repository = DetailEditRepository();

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  Future<void> handleUpdateProduct({
    required BuildContext context,
    required DetailEdit model,
    required VoidCallback onSuccess,
  }) async {
    if (model.productName.trim().isEmpty ||
        model.category.trim().isEmpty ||
        model.pickupLocation.trim().isEmpty ||
        model.description.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill all required fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _isSaving = true;
    notifyListeners();

    bool success = await _repository.updateProduct(model);

    _isSaving = false;
    notifyListeners();

    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Product updated successfully"),
          backgroundColor: Colors.green,
        ),
      );
      onSuccess();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to update product"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}