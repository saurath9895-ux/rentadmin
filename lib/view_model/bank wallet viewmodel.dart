import 'package:flutter/material.dart';
import '../model/bank model.dart';
import '../repository/bank repository.dart';

class WalletViewModel extends ChangeNotifier {
  final BankDetailsRepository _repository = BankDetailsRepository();

  bool _isProcessing = false;
  bool get isProcessing => _isProcessing;

  Future<void> handleSaveBankDetails({
    required BuildContext context,
    required String holder,
    required String bank,
    required String accountNumber,
    required String confirmAccountNumber,
    required String ifsc,
    required String branch,
    required String accountType,
    required VoidCallback onSuccess,
  }) async {
    if (holder.trim().isEmpty ||
        bank.trim().isEmpty ||
        accountNumber.trim().isEmpty ||
        confirmAccountNumber.trim().isEmpty ||
        ifsc.trim().isEmpty ||
        branch.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill all details"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (accountNumber.trim() != confirmAccountNumber.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Account numbers do not match"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _isProcessing = true;
    notifyListeners();

    BankDetailsModel model = BankDetailsModel(
      holderName: holder.trim(),
      bankName: bank.trim(),
      accountNumber: accountNumber.trim(),
      ifscCode: ifsc.trim(),
      branchName: branch.trim(),
      accountType: accountType,
    );

    bool success = await _repository.saveBankDetails(model);

    _isProcessing = false;
    notifyListeners();

    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Bank details saved successfully"),
          backgroundColor: Colors.green,
        ),
      );
      onSuccess();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error saving bank details"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}