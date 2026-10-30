import '../model/admin profile model.dart';
import '../services/admin  profile service.dart';

class AdminProfileRepository {
  final AdminProfileService _service = AdminProfileService();

  AdminProfileModel getAdminProfileData() {
    return _service.fetchInitialProfile();
  }

  Future<bool> signOut() async {
    return await _service.signOutAdmin();
  }
}