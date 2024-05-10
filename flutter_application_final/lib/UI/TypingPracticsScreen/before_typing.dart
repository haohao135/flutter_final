import 'package:flutter/material.dart';
import 'package:flutter_application_final/UI/TypingPracticsScreen/typing.dart';
import 'package:flutter_application_final/model/topic.dart';

// ignore: must_be_immutable
class BeforeTyping extends StatelessWidget {
  BeforeTyping({super.key, required this.topic});
  Topic topic;
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            const Text("Chọn chế độ bạn muốn",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 163, 45, 206),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      content: const Text(
                        "Vào trang làm trắc nghiệm?",
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
                              Navigator.of(context).pop();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Typing(topic: topic, currentWord: 1, second: 0,),));
                            },
                            child: const Text("Đồng ý")),
                      ],
                    ),
                  );
                },
                child: const Text(
                  "Trả lời tiếng Việt",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 163, 45, 206),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      content: const Text(
                        "Vào trang làm trắc nghiệm?",
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
                              
                            },
                            child: const Text("Đồng ý")),
                      ],
                    ),
                  );
                },
                child: const Text(
                  "Trả lời tiếng Anh",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          ],
        ),
      ),
    );
  }
}