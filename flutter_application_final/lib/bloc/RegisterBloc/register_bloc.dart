
import 'package:flutter_application_final/bloc/RegisterBloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit() : super(RegisterState(email: "", name: "", password: "", confirmPasword: ""));
  void emailChange(String emai){
    emit(state.copyWith(emai, null, null, null));
  }

  void nameChange(String name){
    emit(state.copyWith(null, name, null, null));
  }
  void passwordChange(String pass){
    emit(state.copyWith(null, null, null, pass));
  }
  void confirmPasswordChange(String cpass){
    emit(state.copyWith(null, null, null, cpass));
  }
}