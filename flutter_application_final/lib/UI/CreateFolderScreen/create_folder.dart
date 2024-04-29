import 'package:flutter/material.dart';
import 'package:flutter_application_final/UI/Widget/my_textfield.dart';

class CreateFolder extends StatefulWidget {
  const CreateFolder({super.key});

  @override
  State<CreateFolder> createState() => _CreateFolderState();
}

class _CreateFolderState extends State<CreateFolder> {
  TextEditingController folderNameController = TextEditingController();
  TextEditingController folderDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
        ),
        title: const Text("Tạo folder mới", style: TextStyle(color: Colors.white),), backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        actions: const [
          Icon(Icons.check, color: Colors.white,),
          SizedBox(width: 10,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            MyTextField(controller: folderNameController, labelText: "Tên thư mục"),
            const SizedBox(height: 10),
            MyTextField(controller: folderDescriptionController, labelText: "Mô tả"),
          ],
        ),
      ),
    );
  }
}