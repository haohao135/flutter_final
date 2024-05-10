import 'package:flutter/material.dart';

class BeforeTyping extends StatelessWidget {
  const BeforeTyping({super.key});

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