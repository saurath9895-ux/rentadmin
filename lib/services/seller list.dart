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
      name: map["name"] ?? "Unknown Seller",
      email: map["email"] ?? "No Email provided",
      phone: map["phone"] ?? "No Phone",
      status: map["status"] ?? "Active",
      profileImage: map["profileImage"] ?? map["userImage"] ?? map["image"],
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