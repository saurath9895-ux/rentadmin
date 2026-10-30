import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentadmin/view_model/user%20view%20model.dart';
import '../model/user model.dart';

class AllUsersView extends StatelessWidget {
  final String status;

  const AllUsersView({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final usersVM = Provider.of<UsersViewModel>(context, listen: false);

    return StreamBuilder<QuerySnapshot>(
      stream: usersVM.fetchUsersStream(status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.deepPurple));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "No $status users found",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          );
        }

        var docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            var doc = docs[index];
            var data = doc.data() as Map<String, dynamic>? ?? {};
            UserModel user = UserModel.fromMap(data, doc.id);

            return Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple.shade50,
                  backgroundImage: user.profileImage != null && user.profileImage!.isNotEmpty
                      ? NetworkImage(user.profileImage!)
                      : null,
                  child: user.profileImage == null || user.profileImage!.isEmpty
                      ? Icon(Icons.person, color: Colors.deepPurple)
                      : null,
                ),
                title: Text(user.name, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(user.email, style: TextStyle(color: Colors.grey)),
                trailing: Text(user.phone, style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              ),
            );
          },
        );
      },
    );
  }
}