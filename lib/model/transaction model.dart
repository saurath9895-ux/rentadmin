class TransactionModel {
  final String transactionId;
  final String customerName;
  final String productName;
  final String startDate;
  final String endDate;
  final int rentAmount;
  final int securityDeposit;
  final String status;

  TransactionModel({
    required this.transactionId,
    required this.customerName,
    required this.productName,
    required this.startDate,
    required this.endDate,
    required this.rentAmount,
    required this.securityDeposit,
    required this.status,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map, String id) {
    return TransactionModel(
      transactionId: id,
      customerName: map["customerName"] ?? map["userName"] ?? "Rahul Sharma",
      productName: map["productName"] ?? "Sony Camera",
      startDate: map["startDate"] ?? "24 Sep 2026",
      endDate: map["endDate"] ?? "26 Sep 2026",
      rentAmount: int.tryParse(map["rent"]?.toString().replaceAll(RegExp(r'[^0-9]'), '') ?? "2500") ?? 2500,
      securityDeposit: int.tryParse(map["security"]?.toString().replaceAll(RegExp(r'[^0-9]'), '') ?? "1000") ?? 1000,
      status: map["status"] ?? "Payment Successful",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "customerName": customerName,
      "productName": productName,
      "startDate": startDate,
      "endDate": endDate,
      "rent": rentAmount,
      "security": securityDeposit,
      "status": status,
    };
  }
}