class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String status;
  final String? profileImage;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    this.profileImage,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      uid: id,
      name: map["name"] ?? "Unknown",
      email: map["email"] ?? "No Email",
      phone: map["phone"] ?? "No Phone",
      status: map["status"] ?? "Active",
      profileImage: map["profileImage"] ?? map["image"],
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