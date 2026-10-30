class ChangePasswordModel {
  final String email;

  ChangePasswordModel({required this.email});

  factory ChangePasswordModel.initial() {
    return ChangePasswordModel(email: "");
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
    };
  }
}