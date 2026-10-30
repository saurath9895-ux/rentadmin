import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/seller service.dart';

class SellerDetailsRepository {
  final SellerDetailsService _service = SellerDetailsService();

  Future<DocumentSnapshot> getSellerDetails(String sellerId) async {
    return await _service.fetchSellerDetails(sellerId);
  }

  Future<bool> updateSellerStatus(String sellerId, String status) async {
    return await _service.updateKycStatus(sellerId, status);
  }
}