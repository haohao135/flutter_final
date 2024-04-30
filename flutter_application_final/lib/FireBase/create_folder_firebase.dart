import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_final/model/folder.dart';
import 'package:uuid/uuid.dart';


class CreateFolderFireBase{
  static Future<void> createFolder(String userId, String name, String description) async{
      String id = const Uuid().v4();
      Folder folder = Folder(id: id, name: name, userId: userId, description: description);
      await FirebaseFirestore.instance.collection("folders").add(folder.toJson());
  }
}