class SellerListModel {
  final String sellerId;
  final String name;
  final String email;
  final String phone;
  final String status;
  final String? profileImage;

  SellerListModel({
    required this.sellerId,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    this.profileImage,
  });

  factory SellerListModel.fromMap(Map<String, dynamic> map, String id) {
    return SellerListModel(
      sellerId: id,
      name: map["name"] ?? map["fullName"] ?? map["userName"] ?? "Unknown Seller",
      email: map["email"] ?? map["sellerEmail"] ?? "No Email provided",
      phone: map["phone"] ?? map["mobile"] ?? map["phoneNumber"] ?? "No Phone",
      status: map["status"] ?? map["kycStatus"] ?? map["approvalStatus"] ?? "Pending",
      profileImage: map["profileImage"] ?? map["userImage"] ?? map["image"] ?? map["photo"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "status": status,
      "profileImage": profileImage,
    };
  }
}