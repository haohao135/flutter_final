import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_final/model/folder.dart';
import 'package:uuid/uuid.dart';

class CreateFolderFireBase {
  static Future<void> createFolder(
      String userId, String name, String description) async {
    String id = const Uuid().v4();
    Folder folder =
        Folder(id: id, name: name, userId: userId, description: description);
    await FirebaseFirestore.instance.collection("folders").add(folder.toJson());
  }

  static Future<List<Folder>> getFolderData() async {
    List<Folder> folders = [];
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("folders").get();  
      if (querySnapshot.docs.isNotEmpty) { 
        String userId = FirebaseAuth.instance.currentUser!.uid;
        for (var i in querySnapshot.docs) {
          Map<String, dynamic> data = i.data() as Map<String, dynamic>;
          
          Folder folder = Folder(id: i.id, name: data["name"] ?? "", userId: userId, description: data["description"] ?? "");
          List<dynamic> lists = data["listTopicId"] as List<dynamic>;
          List<String> stringList = lists.map((e) => e.toString()).toList();
          folder.listTopicId.addAll(stringList);
          folders.add(folder);
        }
      } else {
        // ignore: avoid_print
        print("Không có dữ liệu");
      }
      return folders;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return [];
    }
  }
}
