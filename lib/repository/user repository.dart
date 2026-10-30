import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/user service.dart';

class UsersRepository {
  final UsersService _service = UsersService();

  Stream<QuerySnapshot> getUsers(String status) {
    return _service.fetchUsersByStatus(status);
  }
}