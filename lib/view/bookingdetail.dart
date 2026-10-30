import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/booking model.dart';
import '../view_model/bookingviewmodal.dart';

class BookingDetailsPage extends StatelessWidget {
  final String bookingId;
  final Map<String, dynamic> bookingData;

  const BookingDetailsPage({
    super.key,
    required this.bookingId,
    required this.bookingData,
  });

  @override
  Widget build(BuildContext context) {
    final BookingDetailsModel model = BookingDetailsModel.fromMap(bookingData, bookingId);

    return Consumer<BookingViewModel>(
      builder: (context, bookingVM, child) {
        return Scaffold(
          backgroundColor: Color(0xffF7F5FF),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(CupertinoIcons.back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              "Booking Details",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: model.status.toLowerCase() == "active" ? Colors.green.shade100
                        : model.status.toLowerCase() == "completed" ? Colors.purple.shade100
                        : model.status.toLowerCase() == "cancelled" ? Colors.red.shade100
                        : Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Current Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(
                        model.status.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: model.status.toLowerCase() == "active" ? Colors.green.shade800
                              : model.status.toLowerCase() == "completed" ? Colors.purple.shade800
                              : model.status.toLowerCase() == "cancelled" ? Colors.red.shade800
                              : Colors.orange.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Item Name", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      SizedBox(height: 3),
                      Text(model.productName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Divider(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Rental Start", style: TextStyle(color: Colors.grey, fontSize: 12)),
                              SizedBox(height: 3),
                              Text(model.startDate, style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Rental End", style: TextStyle(color: Colors.grey, fontSize: 12)),
                              SizedBox(height: 3),
                              Text(model.endDate, style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      Divider(height: 25),
                      Text("Booked On", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      SizedBox(height: 3),
                      Text(model.formattedDate, style: TextStyle(fontWeight: FontWeight.bold)),
                      Divider(height: 25),
                      Text("Razorpay Payment ID", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      SizedBox(height: 3),
                      Text(model.paymentId, style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', color: Colors.deepPurple)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                FutureBuilder<Map<String, dynamic>?>(
                  future: bookingVM.fetchUserDetails(model.sellerId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: Center(child: CircularProgressIndicator(color: Colors.deepPurple)),
                      );
                    }

                    var seller = snapshot.data;
                    String sellerName = seller?["shopName"] ?? seller?["name"] ?? "Unknown Seller";
                    String sellerPhone = seller?["phone"] ?? seller?["contactPhone"] ?? "No Phone";
                    String sellerEmail = seller?["email"] ?? seller?["supportEmail"] ?? "No Email";
                    String? sellerProfileImage = seller?["profileImage"] ?? seller?["profileImageUrl"];

                    return Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Seller Details", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.purple.shade100,
                                backgroundImage: (sellerProfileImage != null && sellerProfileImage.isNotEmpty)
                                    ? NetworkImage(sellerProfileImage) as ImageProvider
                                    : null,
                                child: (sellerProfileImage == null || sellerProfileImage.isEmpty)
                                    ? Icon(CupertinoIcons.person_fill, color: Colors.deepPurple)
                                    : null,
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(sellerName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  SizedBox(height: 2),
                                  Text(sellerPhone, style: TextStyle(color: Colors.grey, fontSize: 13)),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text("Email: $sellerEmail", style: TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Financial Breakdown", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Rent Amount", style: TextStyle(color: Colors.grey.shade700)),
                          Text("₹${model.rent}", style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Security Deposit (Refundable)", style: TextStyle(color: Colors.grey.shade700)),
                          Text("₹${model.securityDeposit}", style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Platform Commission (10%)", style: TextStyle(color: Colors.red.shade400)),
                          Text("- ₹${model.commission.toStringAsFixed(0)}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red.shade400)),
                        ],
                      ),
                      Divider(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Payout to Seller", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("₹${model.sellerEarnings.toStringAsFixed(0)}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                if (model.status.toLowerCase() == "active") ...[
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: bookingVM.isUpdating
                          ? null
                          : () => bookingVM.handleMarkAsReturned(
                        context: context,
                        bookingId: bookingId,
                        securityAmount: model.securityDeposit,
                        onSuccess: () => Navigator.pop(context),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: bookingVM.isUpdating
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                        "Mark Item as Returned",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}