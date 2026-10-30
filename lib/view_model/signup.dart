import 'package:flutter/material.dart';
import '../model/signup model.dart';
import '../repository/signup.dart';

class SignupViewModel extends ChangeNotifier {
  final SignupRepository _repository = SignupRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> handleSignup({
    required BuildContext context,
    required SignupModel model,
    required VoidCallback onSuccess,
  }) async {
    if (model.passwordsDoNotMatch) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Passwords do not match"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    String? error = await _repository.signUpAdmin(
      email: model.email,
      password: model.password,
      userData: model.toMap(),
    );

    _isLoading = false;
    notifyListeners();

    if (!context.mounted) return;

    if (error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Created successfully"),
          backgroundColor: Colors.green,
        ),
      );
      onSuccess();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Creation failed: $error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}