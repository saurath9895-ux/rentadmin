import 'package:flutter/material.dart';
import '../model/admin login model.dart';
import '../repository/adminloginrepository.dart';

class AdminLoginViewModel extends ChangeNotifier {
  final AdminLoginRepository _repository = AdminLoginRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> handleAdminSignIn({
    required BuildContext context,
    required AdminLoginModel model,
    required VoidCallback onSuccess,
  }) async {
    if (model.isUnauthorizedAdmin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login failed: Unauthorized admin email"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    String? error = await _repository.loginAdmin(model.email, model.password);

    _isLoading = false;
    notifyListeners();

    if (!context.mounted) return;

    if (error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login successful"),
          backgroundColor: Colors.green,
        ),
      );
      onSuccess();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login failed: $error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}