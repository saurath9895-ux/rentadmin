class WalletModel {
  final String sellerId;
  final double availableBalance;
  final double totalRevenue;
  final Map<String, dynamic>? bankDetails;

  WalletModel({
    required this.sellerId,
    required this.availableBalance,
    required this.totalRevenue,
    this.bankDetails,
  });

  factory WalletModel.fromMap(Map<String, dynamic> map, String sellerId) {
    return WalletModel(
      sellerId: sellerId,
      availableBalance: (map['availableBalance'] ?? 0.0).toDouble(),
      totalRevenue: (map['totalRevenue'] ?? 0.0).toDouble(),
      bankDetails: map['bankDetails'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'availableBalance': availableBalance,
      'totalRevenue': totalRevenue,
      'bankDetails': bankDetails,
    };
  }
}