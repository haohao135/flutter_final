import 'package:flutter/material.dart';
import 'package:flutter_application_final/UI/Widget/my_textfield.dart';

class CreateTopic extends StatefulWidget {
  const CreateTopic({super.key});

  @override
  State<CreateTopic> createState() => _CreateTopicState();
}

class _CreateTopicState extends State<CreateTopic> {
  TextEditingController classNameController = TextEditingController();
  TextEditingController classDescriptionController = TextEditingController();
  bool er1 = false, er2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          "Tạo chủ đề mới",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        actions: const [
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            MyTextField(
              controller: classNameController,
              labelText: "Tên chủ đề",
              error: er1,
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(
                  Icons.document_scanner,
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Thêm tài liệu",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return addTerm();
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget addTerm() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      color: Colors.grey[300],
      child: const Column(
        children: [
          TextField(
            decoration: InputDecoration(
              label: Text("Từ vựng"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              label: Text("Định nghĩa"),
            ),
          ),
        ],
      ),
    );
  }
}
