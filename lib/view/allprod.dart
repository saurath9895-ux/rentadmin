import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/product view model.dart';
import 'detail.dart';

class Allprod extends StatefulWidget {
  final String statusFilter;
  const Allprod({super.key, this.statusFilter = "All"});

  @override
  State<Allprod> createState() => _AllprodState();
}

class _AllprodState extends State<Allprod> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, productVM, child) {
        return Scaffold(
          backgroundColor: Color(0xffF7F5FF),
          body: StreamBuilder<QuerySnapshot>(
            stream: productVM.getSellerProductsStream(widget.statusFilter),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.deepPurple),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    "No ${widget.statusFilter == "All" ? "" : widget.statusFilter} products found.",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                );
              }

              var docs = snapshot.data!.docs;

              return ListView.builder(
                padding: EdgeInsets.all(15),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  var doc = docs[index];
                  var data = doc.data() as Map<String, dynamic>;

                  String name = data["product"] ?? data["name"] ?? "Unknown Product";
                  String price = data["rent"]?.toString() ?? data["price"]?.toString() ?? "0";
                  String deposit = data["security"] ?? "0";

                  String? productImage = data["image"] ?? data["productImage"];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Detail(
                            productData: data,
                            productId: doc.id,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade200,
                              image: productImage != null && productImage.isNotEmpty
                                  ? DecorationImage(
                                image: NetworkImage(productImage),
                                fit: BoxFit.cover,
                              )
                                  : null,
                            ),
                            child: productImage == null || productImage.isEmpty
                                ? Icon(CupertinoIcons.cube_box, color: Colors.deepPurple)
                                : null,
                          ),
                          SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "₹$price / day",
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Deposit: ₹$deposit",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
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