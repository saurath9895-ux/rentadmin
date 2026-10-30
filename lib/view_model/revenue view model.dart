import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../repository/revenue.dart';

class RevenueViewModel extends ChangeNotifier {
  final RevenueRepository _revenueRepository = RevenueRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Stream<QuerySnapshot> getRevenueBookingsStream() {
    return _revenueRepository.getRevenueBookingsStream();
  }
}