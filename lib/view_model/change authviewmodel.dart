import 'package:flutter/material.dart';
import '../repository/change repository.dart';

class AuthViewModel extends ChangeNotifier {
  final ChangePasswordRepository _repository = ChangePasswordRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> signIn({
    required BuildContext context,
    required String email,
    required String password,
    required VoidCallback onSuccess,
  }) async {
    String trimmedEmail = email.trim();
    if (trimmedEmail.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please fill in all fields"),
        ),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    // Add your sign-in repository/service call here when ready
    await Future.delayed(Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();

    if (!context.mounted) return;
    onSuccess();
  }

  Future<void> handlePasswordReset({
    required BuildContext context,
    required String email,
    required VoidCallback onSuccess,
  }) async {
    String trimmedEmail = email.trim();
    if (!trimmedEmail.contains("@")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please enter a valid email address"),
        ),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    String? error = await _repository.requestPasswordReset(trimmedEmail);

    _isLoading = false;
    notifyListeners();

    if (!context.mounted) return;

    if (error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text("Reset link sent"),
        ),
      );
      onSuccess();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(error),
        ),
      );
    }
  }
}