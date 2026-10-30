import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'userdetail.dart';
import '../view_model/adminviewmodel.dart';

class AllUsers extends StatefulWidget {
  final String statusFilter;
  const AllUsers({super.key, this.statusFilter = "All"});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminViewModel>(
      builder: (context, adminVM, child) {
        return Scaffold(
          backgroundColor: Color(0xffF7F5FF),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Users",
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Manage registered users",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: adminVM.getUsersFilteredByStatusStream(widget.statusFilter),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(color: Colors.deepPurple));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          "No ${widget.statusFilter == "All" ? "" : widget.statusFilter} users found.",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      );
                    }

                    var docs = snapshot.data!.docs;

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        var doc = docs[index];
                        var snap = doc.data() as Map<String, dynamic>;

                        String name = snap["name"] ?? "Unknown User";
                        String email = snap["email"] ?? "No Email provided";
                        String phone = snap["phone"] ?? "No Phone";
                        String status = snap["status"] ?? "Active";

                        String? profileImage = snap["profileImage"] ?? snap["userImage"] ?? snap["image"];

                        Color statusColor = status == "Active"
                            ? Colors.green
                            : status == "Pending"
                            ? Colors.orange
                            : Colors.red;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserDetails(userId: doc.id, userData: snap),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 12),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.deepPurple.shade50,
                                  backgroundImage: profileImage != null && profileImage.isNotEmpty
                                      ? NetworkImage(profileImage)
                                      : null,
                                  child: profileImage == null || profileImage.isEmpty
                                      ? Icon(CupertinoIcons.person, color: Colors.deepPurple, size: 28)
                                      : null,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 4),
                                      Text(email, style: TextStyle(color: Colors.grey, fontSize: 12)),
                                      SizedBox(height: 3),
                                      Text(phone, style: TextStyle(color: Colors.grey, fontSize: 12)),
                                      SizedBox(height: 5),
                                      Text(
                                        status,
                                        style: TextStyle(
                                          color: statusColor,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}