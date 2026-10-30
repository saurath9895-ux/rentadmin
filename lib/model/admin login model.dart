class AdminLoginModel {
  final String email;
  final String password;
  final String adminMail;

  AdminLoginModel({
    required this.email,
    required this.password,
    this.adminMail = "sarath@gmail.com",
  });

  bool get isUnauthorizedAdmin => email.trim() != adminMail;

  Map<String, dynamic> toMap() {
    return {
      "email": email.trim(),
      "password": password.trim(),
    };
  }
}