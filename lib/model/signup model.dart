class SignupModel {
  final String email;
  final String name;
  final String phone;
  final String password;
  final String confirmPassword;

  SignupModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  bool get passwordsDoNotMatch => password != confirmPassword;

  Map<String, dynamic> toMap() {
    return {
      "email": email.trim(),
      "name": name.trim(),
      "phone": phone.trim(),
    };
  }
}