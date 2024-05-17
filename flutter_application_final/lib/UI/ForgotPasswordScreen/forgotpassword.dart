import 'package:flutter/material.dart';
import 'package:flutter_application_final/FireBase/register_account.dart';
import 'package:flutter_application_final/validation/validation.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool isLoading = false, er = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 221, 239),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Quên mật khẩu",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nhập email của bạn",
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: er ? "email không đúng định dạng" : null
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 163, 45, 206),
                    shape: const RoundedRectangleBorder()),
                onPressed: () async {
                  if (Validation.isValidEmail(_emailController.text)) {
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
                    await Register.resetPassword(_emailController.text);
                    setState(() {
                      isLoading = false;
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context, "OK");
                  }
                  if (!Validation.isValidEmail(_emailController.text)) {
                    setState(() {
                      er = true;
                    });
                  } else {
                    setState(() {
                      er = false;
                    });
                  }
                },
                child: const Text(
                  'Xác nhận',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
