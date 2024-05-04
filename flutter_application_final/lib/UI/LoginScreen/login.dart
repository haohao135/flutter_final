
import 'package:flutter/material.dart';
import 'package:flutter_application_final/FireBase/register_account.dart';
import 'package:flutter_application_final/UI/RegisterScreen/register.dart';
import 'package:flutter_application_final/validation/validation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true, remember = false, er1 = false, er2 = false, isLoading = false;
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  void sigIn() async{
     if(Validation.isValidEmail(_userNameController.text) && Validation.isValidPassword(_passwordController.text)){
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
      await Register.loginAccount(_userNameController.text, _passwordController.text, context);
      setState(() {
        isLoading = false;
      });
     }
     if(!Validation.isValidEmail(_userNameController.text)){
      setState(() {
        er1 = true;
      });
     } else{
      setState(() {
        er1 = false;
      });
     }
     if(!Validation.isValidPassword(_passwordController.text)){
      setState(() {
        er2 = true;
      });
     } else{
      setState(() {
        er2 = false;
      });
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            height: 140,
            width: 140,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.amber),
            child: Image.asset(
              "assets/images/logo_englishword.png",
              width: 120,
              height: 120,
            ),
          ),
          const Text(
            "Xin chào",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _userNameController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: "Tên email",
              errorText: er1 ? "Email không đúng định dạng" : null,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: _passwordController,
            obscureText: hidePassword,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Mật khẩu",
                errorText: er2 ? "Mật khẩu phải trên 6 kí tự" : null,                   
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
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                      value: remember,
                      onChanged: (newValue) {
                        setState(() {
                          remember = newValue ?? false;
                        });
                      }),
                  const Text(
                    "Nhớ mật khẩu",
                    style: TextStyle(color: Color.fromARGB(255, 136, 132, 132)),
                  )
                ],
              ),
              const Text(
                "Quên mật khẩu?",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color.fromARGB(255, 163, 45, 206),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              onPressed: sigIn,
              child: const Text(
                "Đăng nhập",
                style: TextStyle(color: Colors.white, fontSize: 17),
              )),
          const SizedBox(
            height: 40,
          ),
          const Row(
            children: [
              Expanded(
                child: Divider(
                  color: Colors.black45,
                  thickness: 0.7,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Text(
                  "Đăng nhập với",
                  style: TextStyle(color: Color.fromARGB(255, 136, 132, 132)),
                ),
              ),
              Expanded(
                child: Divider(
                  color: Colors.black45,
                  thickness: 0.7,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: 70,
                  height: 70,
                  child: Image.asset(
                      "assets/images/Facebook-Logo.png")),
              SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset(
                      "assets/images/Twitter-Logo.png")),
              SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset(
                      "assets/images/Google-Logo.png")),
              SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset(
                      "assets/images/Apple-logo.png")),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Chưa có tài khoản?"),
              GestureDetector(
                onTap: () async{
                  var rs = await Navigator.push(context, MaterialPageRoute(builder: (context)=> const Register1()));
                  if(rs!=null){
                Fluttertoast.showToast(
                  backgroundColor: Colors.teal,
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  msg: "Đăng ký tài khoản thành công");
              }
                },
                child: const Text(
                  " Đăng ký ",
                  style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
