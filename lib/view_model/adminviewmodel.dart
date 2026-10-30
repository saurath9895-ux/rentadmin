import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../repository/adminrepository.dart';

class AdminViewModel extends ChangeNotifier {
  bool isUpdating = false;
  final AdminRepository _repository = AdminRepository();

  Future<bool> updateUserStatus(String userId, String newStatus) async {
    isUpdating = true;
    notifyListeners();

    bool success = await _repository.updateUserStatus(userId, newStatus);

    isUpdating = false;
    notifyListeners();
    return success;
  }

  Stream<QuerySnapshot> getUsersFilteredByStatusStream(String statusFilter) {
    return _repository.getUsersFilteredByStatusStream(statusFilter);
  }

  Stream<QuerySnapshot> getUsersStream() {
    return _repository.getUsersStream();
  }

  Stream<QuerySnapshot> getSellersByStatusStream(String statusFilter) {
    return _repository.getSellersByStatusStream(statusFilter);
  }

  Stream<QuerySnapshot> getCollectionCountStream(String collectionName) {
    return _repository.getCollectionCountStream(collectionName);
  }

  Future<bool> updateSellerKycStatus(String sellerId, String newStatus) async {
    isUpdating = true;
    notifyListeners();

    bool success = await _repository.updateSellerKycStatus(sellerId, newStatus);

    isUpdating = false;
    notifyListeners();
    return success;
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    isUpdating = true;
    notifyListeners();

    bool success = await _repository.sendPasswordResetEmail(email);

    isUpdating = false;
    notifyListeners();
    return success;
  }
}