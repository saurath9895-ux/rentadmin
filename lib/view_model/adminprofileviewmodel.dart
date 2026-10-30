import 'package:flutter/material.dart';
import '../model/admin profile model.dart';
import '../repository/adminprofile.dart';

class AdminProfileViewModel extends ChangeNotifier {
  final AdminProfileRepository _repository = AdminProfileRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late AdminProfileModel _profileModel;
  AdminProfileModel get profileModel => _profileModel;

  AdminProfileViewModel() {
    _profileModel = _repository.getAdminProfileData();
  }

  Future<void> handleSignOut(BuildContext context, VoidCallback onSuccess) async {
    _isLoading = true;
    notifyListeners();

    bool success = await _repository.signOut();

    _isLoading = false;
    notifyListeners();

    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text("Signed out successfully"),
        ),
      );
      onSuccess();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Failed to sign out. Please try again."),
        ),
      );
    }
  }
}