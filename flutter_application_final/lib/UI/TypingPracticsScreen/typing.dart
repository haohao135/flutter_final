import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_final/model/topic.dart';

// ignore: must_be_immutable
class Typing extends StatefulWidget {
  Typing({super.key, required this.topic, required this.currentWord, required this.second});
  Topic topic;
  int currentWord;
  int second;
  @override
  State<Typing> createState() => _TypingState();
}

class _TypingState extends State<Typing> {
  var cl1 = TextEditingController();
  bool er = false;
  @override
  void initState() {
    startTimer();
    super.initState();
  }
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
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                content: const Text(
                  "Xác nhận thoát?",
                  style: TextStyle(fontSize: 20),
                ),
                contentPadding: const EdgeInsets.all(30),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Hủy")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text("Đồng ý")),
                ],
              ),
            );
          },
        ),
        actions: [
          Text(
            formatTime(widget.second),
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Nhập nghĩa tiếng Việt: ",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
                child: Text(
              widget.topic.listWords[widget.currentWord - 1].term,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: cl1,
              decoration: InputDecoration(
                  hintText: "Nhập đáp án của bạn",
                  errorText: er ? "Không được để trống" : null),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    backgroundColor: const Color.fromARGB(255, 163, 45, 206),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Xác nhận",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        widget.second++;
      });
    });
  }
  String formatTime(int seconds) {
    int minutes = (seconds / 60).floor();
    int remainingSeconds = seconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }
}
