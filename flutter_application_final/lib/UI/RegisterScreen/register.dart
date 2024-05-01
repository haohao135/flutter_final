import 'package:flutter/material.dart';
import 'package:flutter_application_final/FireBase/register_account.dart';
import 'package:flutter_application_final/bloc/RegisterBloc/register_bloc.dart';
import 'package:flutter_application_final/validation/validation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Register1 extends StatefulWidget {
  const Register1({super.key});

  @override
  State<Register1> createState() => _Register1State();
}

class _Register1State extends State<Register1> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final cl1 = TextEditingController();
  final cl2 = TextEditingController();
  final cl3 = TextEditingController();
  final cl4 = TextEditingController();

  bool hidePassword = true,
      confirmHidePassword = true,
      er1 = false,
      er2 = false,
      er3 = false,
      er4 = false,
      isLoading = false;

  void signUpClick() async {
    if (Validation.isValidEmail(cl1.text) &&
        Validation.isValidUserName(cl2.text) &&
        Validation.isValidPassword(cl3.text) &&
        Validation.isValidConfirmPassword(cl3.text, cl4.text)) {
      setState(() {
        isLoading = true;
      });
      isLoading
          ? showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ))
          : null;
      // ignore: use_build_context_synchronously
      await Register.createAccount(cl1.text, cl2.text, cl3.text, context);
      setState(() {
        isLoading = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.pop(context, "OK");
    }
    if (!Validation.isValidEmail(cl1.text)) {
      setState(() {
        er1 = true;
      });
    } else{
      setState(() {
        er1 = false;
      });
    }
    if (!Validation.isValidUserName(cl2.text)) {
      setState(() {
        er2 = true;
      });
    } else{
      setState(() {
        er2 = false;
      });
    }
    if (!Validation.isValidPassword(cl3.text)) {
      setState(() {
        er3 = true;
      });
    } else{
      setState(() {
        er3 = false;
      });
    }
    if (!Validation.isValidConfirmPassword(cl3.text, cl4.text)) {
      setState(() {
        er4 = true;
      });
    } else{
      setState(() {
        er4 = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = Provider.of<RegisterCubit>(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 138, 45, 172),
          Color.fromARGB(255, 163, 45, 206),
          Color.fromARGB(255, 192, 81, 233),
        ])),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 28, bottom: 28),
                child: Center(
                  child: Text(
                    "Đăng ký tài khoản",
                    style: TextStyle(color: Colors.white, fontSize: 29),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        TextField(
                          onChanged: (value) {
                            cubit.emailChange(value);
                          },
                          controller: cl1,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              errorText:
                                  er1 ? "Email phải có dạng @gmail.com" : null,
                              border: const OutlineInputBorder(),
                              labelText: "Email"),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          onChanged: (value) => cubit.nameChange(value),
                          controller: cl2,
                          decoration: InputDecoration(
                              errorText: er2 ? "Tên ít nhất 6 kí tự" : null,
                              border: const OutlineInputBorder(),
                              labelText: "Tên tài khoản"),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          onChanged: (value) => cubit.passwordChange(value),
                          controller: cl3,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                              errorText:
                                  er3 ? "Mật khẩu phải trên 6 kí tự" : null,
                              border: const OutlineInputBorder(),
                              labelText: "Mật khẩu",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  icon: hidePassword
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off))),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          onChanged: (value) =>
                              cubit.confirmPasswordChange(value),
                          controller: cl4,
                          obscureText: confirmHidePassword,
                          decoration: InputDecoration(
                              errorText:
                                  er1 ? "Mật khẩu không trùng khớp" : null,
                              border: const OutlineInputBorder(),
                              labelText: "Xác nhận mật khẩu",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      confirmHidePassword =
                                          !confirmHidePassword;
                                    });
                                  },
                                  icon: confirmHidePassword
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                backgroundColor:
                                    const Color.fromARGB(255, 163, 45, 206),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                            onPressed: signUpClick,
                            child: const Text(
                              "Đăng ký",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Trở lại trang đăng nhập",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue),
                          ),
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
