import '../model/bank model.dart';
import '../services/bank detail service.dart';

class BankDetailsRepository {
  final BankDetailsService _service = BankDetailsService();

  Future<bool> saveBankDetails(BankDetailsModel model) async {
    return await _service.saveBankData(model);
  }
}