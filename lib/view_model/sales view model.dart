import 'package:flutter/material.dart';
import '../model/transaction model.dart';
import '../repository/sales repository.dart';

class SalesViewModel extends ChangeNotifier {
  final SalesRepository _salesRepository = SalesRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TransactionModel? _transactionModel;
  TransactionModel? get transactionModel => _transactionModel;

  Future<void> fetchTransaction(String transactionId) async {
    _isLoading = true;
    notifyListeners();

    _transactionModel = await _salesRepository.getTransactionDetails(transactionId);

    _isLoading = false;
    notifyListeners();
  }
}