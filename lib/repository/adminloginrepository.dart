import '../services/admin login service.dart';

class AdminLoginRepository {
  final AdminLoginService _service = AdminLoginService();

  Future<String?> loginAdmin(String email, String password) async {
    return await _service.authenticateAdmin(email, password);
  }
}