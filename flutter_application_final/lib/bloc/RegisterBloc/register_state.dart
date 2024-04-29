class RegisterState {
  final String email;
  final String name;
  final String password;
  final String confirmPasword;

  RegisterState(
      {required this.email,
      required this.name,
      required this.password,
      required this.confirmPasword});
  RegisterState copyWith(
      String? email, String? name, String? password, String? confirmPasword) {
    return RegisterState(
        email: email ?? this.email,
        name: name ?? this.name,
        password: password ?? this.password,
        confirmPasword: confirmPasword ?? this.confirmPasword);
  }
}
