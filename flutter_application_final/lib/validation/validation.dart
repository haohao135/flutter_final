class Validation{
  static bool isValidUserName(String? username){
    return username != null && username.length >= 6;
  }

  static bool isValidPassword(String? password){
    return password != null && password.length >= 6;
  }

  static bool isValidEmail(String? email){
    return email != null && email.length >= 6 && email.contains('@gmail.com');
  }

  static bool isValidConfirmPassword(String password, String confirmPassword){
    return password == confirmPassword;
  }

  static bool isValidName(String name){
    return name.isNotEmpty;
  }

  static bool isValidDescription(String description){
    return description.isNotEmpty && description.length > 5;
  }
}