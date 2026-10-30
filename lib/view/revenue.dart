import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../view_model/revenue view model.dart';
import 'transaction.dart';

class Revenue extends StatefulWidget {
  const Revenue({super.key});

  @override
  State<Revenue> createState() => _RevenueState();
}

class _RevenueState extends State<Revenue> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RevenueViewModel>(
      builder: (context, revenueVM, child) {
        return Scaffold(
          backgroundColor: Color(0xffF7F5FF),
          body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Revenue",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Manage revenue and earnings",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: revenueVM.getRevenueBookingsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator(color: Colors.deepPurple));
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            "No booking or revenue records found.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }

                      var docs = snapshot.data!.docs;

                      double grossRevenue = 0;
                      double totalCommission = 0;
                      double sellerPayments = 0;
                      double securityDepositsTotal = 0;

                      for (var doc in docs) {
                        var data = doc.data() as Map<String, dynamic>;
                        String status = data["status"] ?? "";

                        if (status == "Completed" || status == "Active") {
                          int rent = int.tryParse(data["rent"]?.toString().replaceAll(RegExp(r'[^0-9]'), '') ?? "0") ?? 0;
                          int security = int.tryParse(data["security"]?.toString().replaceAll(RegExp(r'[^0-9]'), '') ?? "0") ?? 0;

                          double commission = rent * 0.10;
                          double sellerPayout = rent * 0.90;

                          grossRevenue += rent;
                          totalCommission += commission;
                          sellerPayments += sellerPayout;
                          securityDepositsTotal += security;
                        }
                      }

                      double netEarnings = totalCommission;

                      List titlesList = [
                        "Gross Revenue",
                        "Net Earnings",
                        "Total Volume",
                        "Commission",
                        "Seller Payouts",
                        "Security Deposits",
                      ];

                      List amountsList = [
                        "₹${grossRevenue.toStringAsFixed(0)}",
                        "₹${netEarnings.toStringAsFixed(0)}",
                        "₹${grossRevenue.toStringAsFixed(0)}",
                        "₹${totalCommission.toStringAsFixed(0)}",
                        "₹${sellerPayments.toStringAsFixed(0)}",
                        "₹${securityDepositsTotal.toStringAsFixed(0)}",
                      ];

                      List iconsList = [
                        CupertinoIcons.money_dollar_circle,
                        CupertinoIcons.graph_square,
                        CupertinoIcons.creditcard,
                        CupertinoIcons.percent,
                        CupertinoIcons.person_2,
                        CupertinoIcons.lock,
                      ];

                      List colorsList = [
                        Colors.deepPurple,
                        Colors.blue,
                        Colors.green,
                        Colors.orange,
                        Colors.teal,
                        Colors.red,
                      ];

                      return ListView(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.2,
                            ),
                            itemCount: titlesList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: colorsList[index].withOpacity(0.1),
                                      child: Icon(
                                        iconsList[index],
                                        color: colorsList[index],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      titlesList[index],
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      amountsList[index],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 25),
                          Text(
                            "Payment Summary",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                _buildSummaryRow("Gross Revenue", "₹${grossRevenue.toStringAsFixed(0)}", false),
                                SizedBox(height: 15),
                                _buildSummaryRow("Seller Payments", "₹${sellerPayments.toStringAsFixed(0)}", false),
                                SizedBox(height: 15),
                                _buildSummaryRow("RentMe Commission", "₹${totalCommission.toStringAsFixed(0)}", true, color: Colors.green),
                                SizedBox(height: 15),
                                _buildSummaryRow("Security Deposits", "₹${securityDepositsTotal.toStringAsFixed(0)}", false),
                                SizedBox(height: 15),
                                Divider(),
                                SizedBox(height: 10),
                                _buildSummaryRow("Net Earnings", "₹${netEarnings.toStringAsFixed(0)}", true, color: Colors.green, fontSize: 17),
                              ],
                            ),
                          ),
                          SizedBox(height: 25),
                          Text(
                            "Recent Transactions",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: docs.length,
                            itemBuilder: (context, index) {
                              var doc = docs[index];
                              var data = doc.data() as Map<String, dynamic>;
                              String productName = data["productName"] ?? "Unknown Item";
                              String rentPrice = data["rent"]?.toString() ?? "0";
                              String status = data["status"] ?? "Pending";

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TransactionDetails(
                                        transactionId: doc.id,
                                        transactionData: data,
                                      ),
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
                                        backgroundColor: Colors.deepPurple.shade50,
                                        child: Icon(
                                          CupertinoIcons.creditcard,
                                          color: Colors.deepPurple,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              productName,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              "Status: $status",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "₹$rentPrice",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isBold, {Color? color, double fontSize = 15}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            color: color ?? Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}