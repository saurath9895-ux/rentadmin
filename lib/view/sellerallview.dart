import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../model/sellerlist.dart';
import '../view_model/sellerlistviewmodel.dart';
import 'selleredit.dart';


class SellerAllView extends StatefulWidget {
  final String statusFilter;
  const SellerAllView({super.key, required this.statusFilter});

  @override
  State<SellerAllView> createState() => _SellerAllViewState();
}

class _SellerAllViewState extends State<SellerAllView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SellerListViewModel>(
      builder: (context, sellerListVM, child) {
        return Scaffold(
          backgroundColor: Color(0xffF7F5FF),
          body: StreamBuilder<List<SellerListModel>>(
            stream: sellerListVM.getSellersByStatusStream(widget.statusFilter),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: Colors.deepPurple));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "No ${widget.statusFilter} sellers found.",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                );
              }

              var sellers = snapshot.data!;

              return ListView.builder(
                padding: EdgeInsets.all(15),
                itemCount: sellers.length,
                itemBuilder: (context, index) {
                  var seller = sellers[index];

                  String name = seller.name;
                  String email = seller.email;
                  String phone = seller.phone;
                  String? profileImage = seller.profileImage;
                  String status = seller.status;

                  Color statusColor = Colors.orange;
                  if (status.toLowerCase() == "active" || status.toLowerCase() == "verified") {
                    statusColor = Colors.green;
                  } else if (status.toLowerCase() == "rejected") {
                    statusColor = Colors.red;
                  } else if (status.toLowerCase() == "pending") {
                    statusColor = Colors.amber.shade800;
                  }

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SellerDetails(sellerId: seller.sellerId),
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
        );
      },
    );
  }
}