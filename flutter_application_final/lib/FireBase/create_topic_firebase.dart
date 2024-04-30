// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_application_final/model/topic.dart';
// import 'package:uuid/uuid.dart';

// class CreateTopicFireBase{
//   static Future<void> createTopic(String userId, String name, String description) async{
//       String id = const Uuid().v4();
//       Topic topic = Topic(id: id, name: name, listWords: listWords, mode: mode, author: author, userId: userId);
//       await FirebaseFirestore.instance.collection("folders").add();
//   }
// }