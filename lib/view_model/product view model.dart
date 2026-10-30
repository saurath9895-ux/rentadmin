import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../repository/product repository.dart';

class ProductViewModel extends ChangeNotifier {
  bool isLoading = false;
  final ProductRepository _repository = ProductRepository();

  Stream<QuerySnapshot> getSellerProductsStream(String statusFilter) {
    return _repository.getSellerProductsStream(statusFilter);
  }

  Future<bool> addProduct({
    required String name,
    required String category,
    required double price,
    required String description,
  }) async {
    isLoading = true;
    notifyListeners();

    bool success = await _repository.addProduct(
      name: name,
      category: category,
      price: price,
      description: description,
    );

    isLoading = false;
    notifyListeners();
    return success;
  }

  Future<bool> deleteProduct(String productId) async {
    isLoading = true;
    notifyListeners();

    bool success = await _repository.deleteProduct(productId);

    isLoading = false;
    notifyListeners();
    return success;
  }

  Future<Map<String, dynamic>?> fetchSellerDetails(String sellerId) async {
    return await _repository.fetchSellerDetails(sellerId);
  }
}