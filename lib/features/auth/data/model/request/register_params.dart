class RegisterParams {
  String? name;
  String? email;
  String? password;
  String? passwordConfirmation;
  int? verifyCode;
  String? newPassword;
  String? confirmNewPassword;

  RegisterParams({
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.verifyCode,
    this.newPassword,
    this.confirmNewPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'verify_code': verifyCode,
      'new_password': newPassword,
      'new_password_confirmation': confirmNewPassword,
    };
  }
}
