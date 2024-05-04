import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/FireBase/create_folder_firebase.dart';
import 'package:flutter_application_final/UI/Widget/my_textfield.dart';
import 'package:flutter_application_final/validation/validation.dart';

class CreateFolder extends StatefulWidget {
  const CreateFolder({super.key});

  @override
  State<CreateFolder> createState() => _CreateFolderState();
}

class _CreateFolderState extends State<CreateFolder> {
  TextEditingController folderNameController = TextEditingController();
  TextEditingController folderDescriptionController = TextEditingController();
  bool er1 = false, er2 = false;
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
        title: const Text("Tạo thư mục mới", style: TextStyle(color: Colors.white),), backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        actions:[
          IconButton(onPressed: _createFolder, icon: const Icon(Icons.check, color: Colors.white,)),
          const SizedBox(width: 10,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            MyTextField(controller: folderNameController, labelText: "Tên thư mục", error: er1,),
            const SizedBox(height: 10),
            MyTextField(controller: folderDescriptionController, labelText: "Mô tả", error: er2,),
          ],
        ),
      ),
    );
  }
  void _createFolder(){
    if(Validation.isValidName(folderNameController.text) && Validation.isValidDescription(folderDescriptionController.text)){
      String userId = FirebaseAuth.instance.currentUser!.uid;
      CreateFolderFireBase.createFolder(userId, folderNameController.text, folderDescriptionController.text);
      Navigator.pop(context, "OK");
    }
    if(!Validation.isValidName(folderNameController.text)){
      setState(() {
        er1 = true;
      });
     } else{
      setState(() {
        er1 = false;
      });
     }
     if(!Validation.isValidDescription(folderDescriptionController.text)){
      setState(() {
        er2 = true;
      });
     } else{
      setState(() {
        er2 = false;
      });
     }
  }
}