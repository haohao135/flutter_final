import 'dart:async';

import 'package:flutter_application_final/validation/validation.dart';

class LoginBloc{
  final _emailController = StreamController();
  final _passwordController = StreamController();

  Stream get userNameStrem => _emailController.stream;
  Stream get passwordStrem => _passwordController.stream;

  bool isValidUser(String email, String password){
    if(!Validation.isValidEmail(email)){
      _emailController.sink.addError("Tài khoản không hợp lệ");
      return false;
    }
    _emailController.sink.add("OK");
    if(!Validation.isValidPassword(password)){
      _passwordController.sink.addError("Mật khẩu không hợp lệ");
      return false;
    }
    _passwordController.sink.add("OK");
    return true;
  }

  void dispose(){
    _emailController.close();
    _passwordController.close();
  }
}