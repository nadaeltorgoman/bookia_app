bool isEmailValid(String email) {
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return emailRegex.hasMatch(email);
}

bool isPasswordValid(String password) {
  return password.length > 8;
}

bool isConfirmPasswordValid(String password, String confirmPassword) {
  return password == confirmPassword;
}

bool isNumeric(String value) {
  final numericRegex = RegExp(r'^\d+$');
  return numericRegex.hasMatch(value);
}
