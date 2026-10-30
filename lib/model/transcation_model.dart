class TransactionDetailsModel {
  final String txnId;
  final String customerName;
  final String productName;
  final String startDate;
  final String endDate;
  final int rentAmount;
  final int securityDeposit;
  final int totalPaid;
  final double commission;
  final double sellerReceives;
  final String status;

  TransactionDetailsModel({
    required this.txnId,
    required this.customerName,
    required this.productName,
    required this.startDate,
    required this.endDate,
    required this.rentAmount,
    required this.securityDeposit,
    required this.totalPaid,
    required this.commission,
    required this.sellerReceives,
    required this.status,
  });

  factory TransactionDetailsModel.fromMap(Map<String, dynamic>? data, String? id) {
    var safeData = data ?? {};
    String parsedTxnId = id ?? "TXN1001";
    String parsedCustomerName = safeData["customerName"] ?? safeData["userName"] ?? "Rahul Sharma";
    String parsedProductName = safeData["productName"] ?? "Sony Camera";
    String parsedStartDate = safeData["startDate"] ?? "24 Sep 2026";
    String parsedEndDate = safeData["endDate"] ?? "26 Sep 2026";

    int parsedRentAmount = int.tryParse(safeData["rent"]?.toString().replaceAll(RegExp(r'[^0-9]'), '') ?? "2500") ?? 2500;
    int parsedSecurityDeposit = int.tryParse(safeData["security"]?.toString().replaceAll(RegExp(r'[^0-9]'), '') ?? "1000") ?? 1000;
    int parsedTotalPaid = parsedRentAmount + parsedSecurityDeposit;
    double parsedCommission = parsedRentAmount * 0.10;
    double parsedSellerReceives = parsedRentAmount - parsedCommission;
    String parsedStatus = safeData["status"] ?? "Payment Successful";

    return TransactionDetailsModel(
      txnId: parsedTxnId,
      customerName: parsedCustomerName,
      productName: parsedProductName,
      startDate: parsedStartDate,
      endDate: parsedEndDate,
      rentAmount: parsedRentAmount,
      securityDeposit: parsedSecurityDeposit,
      totalPaid: parsedTotalPaid,
      commission: parsedCommission,
      sellerReceives: parsedSellerReceives,
      status: parsedStatus,
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