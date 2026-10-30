import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/revenue.dart';

class RevenueRepository {
  final RevenueService _revenueService = RevenueService();

  Stream<QuerySnapshot> getRevenueBookingsStream() {
    return _revenueService.getRevenueBookingsStream();
  }
}