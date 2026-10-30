import 'package:cloud_firestore/cloud_firestore.dart';

class BookingDetailsModel {
  final String bookingId;
  final String productName;
  final String status;
  final String startDate;
  final String endDate;
  final String paymentId;
  final String sellerId;
  final int rent;
  final int securityDeposit;
  final double commission;
  final double sellerEarnings;
  final String formattedDate;

  BookingDetailsModel({
    required this.bookingId,
    required this.productName,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.paymentId,
    required this.sellerId,
    required this.rent,
    required this.securityDeposit,
    required this.commission,
    required this.sellerEarnings,
    required this.formattedDate,
  });

  factory BookingDetailsModel.fromMap(Map<String, dynamic> map, String id) {
    int parsedRent = int.tryParse(map["price"]?.toString().replaceAll(RegExp(r'[^0-9]'), '') ?? "500") ?? 500;
    int parsedSecurity = int.tryParse(map["securityDeposit"]?.toString().replaceAll(RegExp(r'[^0-9]'), '') ?? "2000") ?? 2000;
    int totalPaid = parsedRent + parsedSecurity;

    double calculatedCommission = parsedRent * 0.10;
    double calculatedEarnings = totalPaid - calculatedCommission;

    String dateStr = "Just now";
    if (map["timestamp"] != null && map["timestamp"] is Timestamp) {
      DateTime dt = (map["timestamp"] as Timestamp).toDate();
      dateStr = "${dt.day}/${dt.month}/${dt.year} at ${dt.hour}:${dt.minute.toString().padLeft(2, '0')} ${dt.hour >= 12 ? 'PM' : 'AM'}";
    }

    return BookingDetailsModel(
      bookingId: id,
      productName: map["productName"] ?? "Unknown Item",
      status: map["status"] ?? "Pending",
      startDate: map["startDate"] ?? "N/A",
      endDate: map["endDate"] ?? "N/A",
      paymentId: map["paymentId"] ?? "N/A",
      sellerId: map["sellerId"] ?? "",
      rent: parsedRent,
      securityDeposit: parsedSecurity,
      commission: calculatedCommission,
      sellerEarnings: calculatedEarnings,
      formattedDate: dateStr,
    );
  }
}