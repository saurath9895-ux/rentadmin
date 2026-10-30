class BankDetailsModel {
  final String holderName;
  final String bankName;
  final String accountNumber;
  final String ifscCode;
  final String branchName;
  final String accountType;

  BankDetailsModel({
    required this.holderName,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    required this.branchName,
    required this.accountType,
  });

  factory BankDetailsModel.initial() {
    return BankDetailsModel(
      holderName: "",
      bankName: "",
      accountNumber: "",
      ifscCode: "",
      branchName: "",
      accountType: "Savings",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "holderName": holderName,
      "bankName": bankName,
      "accountNumber": accountNumber,
      "ifscCode": ifscCode,
      "branchName": branchName,
      "accountType": accountType,
    };
  }
}