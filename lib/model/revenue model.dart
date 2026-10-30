class RevenueModel {
  final String bookingId;
  final String productName;
  final double rent;
  final double security;
  final String status;

  RevenueModel({
    required this.bookingId,
    required this.productName,
    required this.rent,
    required this.security,
    required this.status,
  });

  factory RevenueModel.fromMap(Map<String, dynamic> map, String id) {
    return RevenueModel(
      bookingId: id,
      productName: map["productName"] ?? "Unknown Item",
      rent: double.tryParse(map["rent"]?.toString().replaceAll(RegExp(r'[^0-9]'), '') ?? "0") ?? 0.0,
      security: double.tryParse(map["security"]?.toString().replaceAll(RegExp(r'[^0-9]'), '') ?? "0") ?? 0.0,
      status: map["status"] ?? "Pending",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "productName": productName,
      "rent": rent,
      "security": security,
      "status": status,
    };
  }
}