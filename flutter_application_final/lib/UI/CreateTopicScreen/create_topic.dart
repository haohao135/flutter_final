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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.white,),
        title: const Text("Tạo lớp mới", style: TextStyle(color: Colors.white),), backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        actions: const [
          Icon(Icons.check, color: Colors.white,),
          SizedBox(width: 10,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            MyTextField(controller: classNameController, labelText: "Tên lớp"),
            const SizedBox(height: 10),
            MyTextField(controller: classDescriptionController, labelText: "Mô tả"),
          ],
        ),
      ),
    );
  }
}