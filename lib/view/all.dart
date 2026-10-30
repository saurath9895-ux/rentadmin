import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../view_model/bookingviewmodal.dart';
import 'bookingdetail.dart';

class All extends StatefulWidget {
  final String statusFilter;
  const All({super.key, required this.statusFilter});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookingViewModel>(
      builder: (context, bookingVM, child) {
        return Scaffold(
          backgroundColor: const Color(0xffF7F5FF),
          body: StreamBuilder<List<Map<String, dynamic>>>(
            stream: bookingVM.fetchBookingsByStatusStream(widget.statusFilter),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Colors.deepPurple));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "No ${widget.statusFilter} bookings found.",
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                );
              }

              var bookings = snapshot.data!;

              return ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  var data = bookings[index];
                  String docId = data["id"] ?? "";

                  String productName = data["productName"] ?? data["title"] ?? data["name"] ?? "Booking #${docId.isNotEmpty ? docId.substring(0, min(6, docId.length)) : ''}";

                  String customerName = data["customerName"] ?? data["userName"] ?? data["name"] ?? (data["user"] is Map ? data["user"]["name"] : null) ?? "Unknown Customer";
                  String phone = data["customerPhone"] ?? data["phone"] ?? data["mobile"] ?? (data["user"] is Map ? data["user"]["phone"] : null) ?? "No Phone";

                  String startDate = data["startDate"] ?? data["date"] ?? "";
                  String endDate = data["endDate"] ?? "";

                  String? productImage = data["productImage"] ?? data["image"] ?? data["imageUrl"] ?? data["photo"] ?? data["productPhoto"];

                  return FutureBuilder<Map<String, dynamic>?>(
                    future: bookingVM.fetchUserDetails(data["userId"] ?? data["customerId"] ?? data["sellerId"] ?? ""),
                    builder: (context, userSnapshot) {
                      var fetchedUserData = userSnapshot.data;
                      String finalCustomerName = fetchedUserData?["name"] ?? customerName;
                      String finalPhone = fetchedUserData?["phone"] ?? phone;

                      var updatedBookingData = Map<String, dynamic>.from(data);
                      updatedBookingData["resolvedCustomerName"] = finalCustomerName;
                      updatedBookingData["resolvedPhone"] = finalPhone;
                      if (fetchedUserData != null) {
                        updatedBookingData["userDetails"] = fetchedUserData;
                      }

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingDetailsPage(
                                bookingId: docId,
                                bookingData: updatedBookingData,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.purple.shade50,
                                  image: productImage != null && productImage.isNotEmpty
                                      ? DecorationImage(
                                    image: NetworkImage(productImage),
                                    fit: BoxFit.cover,
                                  )
                                      : null,
                                ),
                                child: productImage == null || productImage.isEmpty
                                    ? const Icon(CupertinoIcons.cube_box, color: Colors.deepPurple, size: 28)
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productName,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text("Customer: $finalCustomerName", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                    const SizedBox(height: 3),
                                    Text(finalPhone, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                    if (startDate.isNotEmpty) ...[
                                      const SizedBox(height: 3),
                                      Text(
                                        endDate.isNotEmpty ? "$startDate to $endDate" : startDate,
                                        style: const TextStyle(color: Colors.deepPurple, fontSize: 11, fontWeight: FontWeight.bold),
                                      ),
                                    ],
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
              );
            },
          ),
        );
      },
    );
  }

  int min(int a, int b) => a < b ? a : b;
}