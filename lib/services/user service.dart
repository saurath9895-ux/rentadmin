import 'package:cloud_firestore/cloud_firestore.dart';

class UsersService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> fetchUsersByStatus(String status) {
    return _firestore
        .collection("users")
        .where("status", isEqualTo: status)
        .snapshots();
  }
}