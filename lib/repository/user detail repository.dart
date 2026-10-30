import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/user details service.dart';

class UserDetailsRepository {
  final UserDetailsService _service = UserDetailsService();

  Future<DocumentSnapshot> getUserDetails(String userId) async {
    return await _service.fetchUserDetails(userId);
  }
}