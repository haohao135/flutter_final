import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/FireBase/create_folder_firebase.dart';
import 'package:flutter_application_final/UI/Widget/my_textfield.dart';
import 'package:flutter_application_final/model/folder.dart';
import 'package:flutter_application_final/validation/validation.dart';

// ignore: must_be_immutable
class CreateFolder extends StatefulWidget {
  CreateFolder({super.key, required this.name, required this.des, this.folder});
  String? name;
  String? des;
  Folder? folder;
  @override
  State<CreateFolder> createState() => _CreateFolderState();
}

class _CreateFolderState extends State<CreateFolder> {
  TextEditingController folderNameController = TextEditingController();
  TextEditingController folderDescriptionController = TextEditingController();
  bool er1 = false, er2 = false;
  @override
  void initState() {
    if (widget.name != null) {
      folderNameController.text = widget.name ?? "";
      folderDescriptionController.text = widget.des ?? "";
    }
    super.initState();
  }

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
          ),
        ),
        title: Text(
          widget.name != null ? "Chỉnh sửa thư mục" : "Tạo thư mục mới",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        actions: [
          IconButton(
              onPressed: _createFolder,
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            MyTextField(
              controller: folderNameController,
              labelText: "Tên thư mục",
              error: er1,
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller: folderDescriptionController,
              labelText: "Mô tả",
              error: er2,
            ),
          ],
        ),
      ),
    );
  }

  void _createFolder() {
    if (Validation.isValidName(folderNameController.text) &&
        Validation.isValidDescription(folderDescriptionController.text)) {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      if(widget.name == null){
        CreateFolderFireBase.createFolder(
          userId, folderNameController.text, folderDescriptionController.text);
      }
      if(widget.name != null){
        Folder folder = Folder(id: widget.folder!.id, name: widget.folder!.name, userId: widget.folder!.userId, description: widget.folder!.description);
        folder.listTopicId.addAll(widget.folder!.listTopicId);
        updateFolder(folder);
      }
      Navigator.pop(context, "OK");
    }
    if (!Validation.isValidName(folderNameController.text)) {
      setState(() {
        er1 = true;
      });
    } else {
      setState(() {
        er1 = false;
      });
    }
    if (!Validation.isValidDescription(folderDescriptionController.text)) {
      setState(() {
        er2 = true;
      });
    } else {
      setState(() {
        er2 = false;
      });
    }
  }
  Future<void> updateFolder(Folder folder)async{
    await CreateFolderFireBase.updateFolder(folder);
  }
}
