class UserDetailsModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String status;
  final String? profileImage;
  final String? idProofUrl;

  UserDetailsModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.status,
    this.profileImage,
    this.idProofUrl,
  });

  factory UserDetailsModel.fromMap(Map<String, dynamic> map, String id) {
    return UserDetailsModel(
      uid: id,
      name: map["name"] ?? "Unknown",
      email: map["email"] ?? "No Email",
      phone: map["phone"] ?? "No Phone",
      address: map["location"] ?? map["address"] ?? "No Address",
      status: map["status"] ?? "Active",
      profileImage: map["profileImage"] ?? map["image"] ?? map["profileImageUrl"],
      // 👈 Matches the key saved during verification submission
      idProofUrl: map["verificationDocumentUrl"] ?? map["govtIdImage"] ?? map["idProof"] ?? map["documentUrl"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "location": address,
      "status": status,
      "profileImage": profileImage,
      "verificationDocumentUrl": idProofUrl,
    };
  }
}