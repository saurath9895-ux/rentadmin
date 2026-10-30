import 'package:flutter/material.dart';
import '../repository/user detail repository.dart';

class UserDetailsViewModel extends ChangeNotifier {
  final UserDetailsRepository _repository = UserDetailsRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadUserDetails(String userId) async {
    _isLoading = true;
    notifyListeners();

    await _repository.getUserDetails(userId);

    _isLoading = false;
    notifyListeners();
  }
}