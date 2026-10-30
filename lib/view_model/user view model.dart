import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../repository/user repository.dart';

class UsersViewModel extends ChangeNotifier {
  final UsersRepository _repository = UsersRepository();

  Stream<QuerySnapshot> fetchUsersStream(String status) {
    return _repository.getUsers(status);
  }
}