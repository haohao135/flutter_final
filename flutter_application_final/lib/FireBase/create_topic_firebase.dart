import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_final/FireBase/create_word_firebase.dart';
import 'package:flutter_application_final/model/topic.dart';
import 'package:flutter_application_final/model/word.dart';

class CreateTopicFireBase {
  static Future<void> createTopic(Topic topic) async {
    await FirebaseFirestore.instance.collection("topics").doc(topic.id).set(topic.toJson());
  }

  static Future<List<Topic>> getTopicData() async {
    List<Topic> topicList = [];
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("topics").get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var i in querySnapshot.docs) {
          String currentUserId = FirebaseAuth.instance.currentUser!.uid;
          Map<String, dynamic> data = i.data() as Map<String, dynamic>;
          if (currentUserId == i["userId"]) {
            List<dynamic> list =
                data["listWords"] as List<dynamic>;
            List<Map<String, dynamic>> convertedWordList =
                list.map((e) => e as Map<String, dynamic>).toList();
            List<Word> wordList = convertedWordList.map((e) {
              Word word = Word(
                  id: e["id"],
                  term: e["term"],
                  definition: e["definition"],
                  statusE: e["statusE"],
                  isStar: e["isStar"],
                  topicId: e["topicId"]);
              return word;
            }).toList();
            Topic topic = Topic(
                id: i.id,
                name: data["name"],
                listWords: wordList,
                mode: i["mode"],
                author: i["author"],
                userId: i["userId"]);
            topicList.add(topic);
          }
        }
      }
      return topicList;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      // ignore: avoid_print
      print("Khong lay duoc topic tu firebase");
      return [];
    }
  }
  static Future<void> updateTopic(Topic topic) async{
    try{
      await FirebaseFirestore.instance.collection("topics").doc(topic.id).update(topic.toJson());
    } catch(e){
      // ignore: avoid_print
      print("khong cap nhat topic dc");
      // ignore: avoid_print
      print(e);
    }
  }

  static Future<List<Topic>> getTopicDataPublic() async {
    List<Topic> topicList = [];
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("topics").get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var i in querySnapshot.docs) {
          Map<String, dynamic> data = i.data() as Map<String, dynamic>;
          if (i["mode"] == false) {
            List<dynamic> list =
                data["listWords"] as List<dynamic>;
            List<Map<String, dynamic>> convertedWordList =
                list.map((e) => e as Map<String, dynamic>).toList();
            List<Word> wordList = convertedWordList.map((e) {
              Word word = Word(
                  id: e["id"],
                  term: e["term"],
                  definition: e["definition"],
                  statusE: e["statusE"],
                  isStar: e["isStar"],
                  topicId: e["topicId"]);
              return word;
            }).toList();
            Topic topic = Topic(
                id: i.id,
                name: data["name"],
                listWords: wordList,
                mode: i["mode"],
                author: i["author"],
                userId: i["userId"]);
            topicList.add(topic);
          }
        }
      }
      return topicList;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      // ignore: avoid_print
      print("Khong lay duoc topic tu firebase");
      return [];
    }
  }
  static Future<void> deleteTopic(Topic topic)async{
    try{
      for(var i in topic.listWords){
        CreateWordFirebase.deleteWord(i);
      }
      await FirebaseFirestore.instance.collection("topics").doc(topic.id).delete();
    } catch(e){
      // ignore: avoid_print
      print("khong xoa topic dc");
      // ignore: avoid_print
      print(e);
    }
  }
}
