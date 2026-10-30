import '../services/signup service.dart';

class SignupRepository {
  final SignupService _service = SignupService();

  Future<String?> signUpAdmin({
    required String email,
    required String password,
    required Map<String, dynamic> userData,
  }) async {
    return await _service.registerAdminUser(
      email: email,
      password: password,
      userData: userData,
    );
  }
}