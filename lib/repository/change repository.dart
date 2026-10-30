import '../services/change service.dart';

class ChangePasswordRepository {
  final ChangePasswordService _service = ChangePasswordService();

  Future<String?> requestPasswordReset(String email) async {
    return await _service.sendPasswordResetEmail(email);
  }
}