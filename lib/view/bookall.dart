import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../view_model/bookingviewmodal.dart';
import 'bookingdetail.dart';

class Bookall extends StatelessWidget {
  final String statusFilter;
  const Bookall({super.key, this.statusFilter = "All"});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingViewModel>(
      builder: (context, bookingVM, child) {
        return Scaffold(
          backgroundColor: Color(0xffF7F5FF),
          body: StreamBuilder<List<Map<String, dynamic>>>(
            stream: bookingVM.getBookingsByStatusStream(statusFilter),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: Colors.deepPurple));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "No bookings found.",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              }

              var bookings = snapshot.data!;

              return ListView.builder(
                padding: EdgeInsets.all(15),
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  var data = bookings[index];
                  String docId = data["id"] ?? "";

                  String productName = data["productName"] ?? "Unknown Item";
                  String startDate = data["startDate"] ?? "";
                  String endDate = data["endDate"] ?? "";
                  String rent = data["rent"]?.toString() ?? "0";
                  String status = data["status"] ?? "Pending";

                  String? productImage = data["productImage"] ?? data["image"];

                  Color statusBg = status.toLowerCase() == "active"
                      ? Colors.greenAccent.shade100
                      : status.toLowerCase() == "completed"
                      ? Colors.purple.shade100
                      : status.toLowerCase() == "cancelled"
                      ? Colors.redAccent.shade100
                      : Colors.orangeAccent.shade100;

                  Color statusText = status.toLowerCase() == "active"
                      ? Colors.green.shade800
                      : status.toLowerCase() == "completed"
                      ? Colors.deepPurple
                      : status.toLowerCase() == "cancelled"
                      ? Colors.red.shade800
                      : Colors.deepOrange;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingDetailsPage(
                            bookingId: docId,
                            bookingData: data,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.purple.shade50,
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
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        productName,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: statusBg,
                                      ),
                                      child: Text(
                                        status,
                                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: statusText),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "$startDate to $endDate",
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "₹$rent / day",
                                  style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 15),
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