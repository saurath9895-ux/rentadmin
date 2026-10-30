class AdminProfileModel {
  final String adminId;
  final String name;
  final String email;
  final String role;
  final String status;
  final List<String> accountTitles;
  final List<String> accountIcons;

  AdminProfileModel({
    required this.adminId,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.accountTitles,
    required this.accountIcons,
  });

  factory AdminProfileModel.initial() {
    return AdminProfileModel(
      adminId: "ADM001",
      name: "Admin",
      email: "admin@rentme.com",
      role: "Super Admin",
      status: "Active",
      accountTitles: [
        "Change Password",
        "Privacy Policy",
      ],
      accountIcons: [
        "lock",
        "lock_shield",
      ],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "role": role,
      "status": status,
    };
  }
}