class SellerDetailsModel {
  final String sellerId;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String? profileImage;
  final String? govIdUrl;
  final String? storeProofUrl;
  final String verificationType;
  final String status;

  SellerDetailsModel({
    required this.sellerId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.profileImage,
    this.govIdUrl,
    this.storeProofUrl,
    required this.verificationType,
    required this.status,
  });

  factory SellerDetailsModel.fromMap(Map<String, dynamic> map, String id) {
    return SellerDetailsModel(
      sellerId: id,
      name: map["name"] ?? "Unknown",
      email: map["email"] ?? "No Email",
      phone: map["phone"] ?? "No Phone",
      address: map["address"] ?? map["location"] ?? "No Address",
      profileImage: map["profileImage"] ?? map["image"],
      govIdUrl: map["govtIdImage"] ?? map["verificationDocumentUrl"] ?? map["documentUrl"],
      storeProofUrl: map["storeProofImage"] ?? map["storeProof"] ?? map["storeImage"],
      verificationType: map["verificationType"] ?? "Government ID",
      status: map["status"] ?? "Pending",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "profileImage": profileImage,
      "govtIdImage": govIdUrl,
      "storeProofImage": storeProofUrl,
      "verificationType": verificationType,
      "status": status,
    };
  }
}