import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/sellerlist.dart';
import '../repository/seller list reposiitiry.dart';

class SellerListViewModel extends ChangeNotifier {
  final SellerRepository _repository = SellerRepository();

  Stream<List<SellerListModel>> getSellersByStatusStream(String status) {
    return _repository.getSellersStream().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return SellerListModel.fromMap(data, doc.id);
      }).where((seller) {
        String docStatus = seller.status.trim().toLowerCase();
        String targetStatus = status.trim().toLowerCase();

        if (targetStatus == "active") {
          return docStatus == "active" || docStatus == "verified" || docStatus == "approved";
        } else if (targetStatus == "pending") {
          return docStatus == "pending" || docStatus == "unverified" || docStatus == "" || docStatus == "submitted";
        } else if (targetStatus == "rejected") {
          return docStatus == "rejected" || docStatus == "declined";
        }

        return docStatus == targetStatus;
      }).toList();
    });
  }
}