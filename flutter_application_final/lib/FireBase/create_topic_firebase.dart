import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_final/FireBase/create_word_firebase.dart';
import 'package:flutter_application_final/model/topic.dart';
import 'package:flutter_application_final/model/user_result.dart';
import 'package:flutter_application_final/model/word.dart';

class CreateTopicFireBase {
  static Future<void> createTopic(Topic topic) async {
    await FirebaseFirestore.instance
        .collection("topics")
        .doc(topic.id)
        .set(topic.toJson());
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
            List<dynamic> list = data["listWords"] as List<dynamic>;
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

            List<dynamic> listResult1 =
                data["listUserResults"] as List<dynamic>;
            List<Map<String, dynamic>> convertedlistResul =
                listResult1.map((e) => e as Map<String, dynamic>).toList();
            List<UserResult> userResultList = convertedlistResul.map((e) {
              final Timestamp timestampValue = e["date"];
              final DateTime dateTimeValue = timestampValue.toDate();
              UserResult u = UserResult(
                  id: e["id"],
                  userId: e["userId"],
                  correctAnswers: e["correctAnswers"],
                  date: dateTimeValue,
                  duration: e["duration"],
                  attempt: e["attempt"],
                  mode: e["mode"]);
              return u;
            }).toList();
            Topic topic = Topic(
                id: i.id,
                name: data["name"],
                listWords: wordList,
                mode: i["mode"],
                author: i["author"],
                userId: i["userId"],
                listUserResults: userResultList);
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

  static Future<void> updateTopic(Topic topic) async {
    try {
      await FirebaseFirestore.instance
          .collection("topics")
          .doc(topic.id)
          .update(topic.toJson());
    } catch (e) {
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
            List<dynamic> list = data["listWords"] as List<dynamic>;
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
            List<dynamic> listResult1 =
                data["listUserResults"] as List<dynamic>;
            List<Map<String, dynamic>> convertedlistResul =
                listResult1.map((e) => e as Map<String, dynamic>).toList();
            List<UserResult> userResultList = convertedlistResul.map((e) {
              final Timestamp timestampValue = e["date"];
              final DateTime dateTimeValue = timestampValue.toDate();
              UserResult u = UserResult(
                  id: e["id"],
                  userId: e["userId"],
                  correctAnswers: e["correctAnswers"],
                  date: dateTimeValue,
                  duration: e["duration"],
                  attempt: e["attempt"],
                  mode: e["mode"]);
              return u;
            }).toList();
            Topic topic = Topic(
                id: i.id,
                name: data["name"],
                listWords: wordList,
                mode: i["mode"],
                author: i["author"],
                userId: i["userId"],
                listUserResults: userResultList);
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

  static Future<void> deleteTopic(Topic topic) async {
    try {
      for (var i in topic.listWords) {
        CreateWordFirebase.deleteWord(i);
      }
      await FirebaseFirestore.instance
          .collection("topics")
          .doc(topic.id)
          .delete();
    } catch (e) {
      // ignore: avoid_print
      print("khong xoa topic dc");
      // ignore: avoid_print
      print(e);
    }
  }

  static Future<Topic> getTopicByTopicId(String id) async {
    final rs =
        await FirebaseFirestore.instance.collection("topics").doc(id).get();
    final data = rs.data();
    Topic? topic;
    try {
      if (data != null) {
        List<dynamic> list = data["listWords"] as List<dynamic>;
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
        List<dynamic> listResult1 = data["listUserResults"] as List<dynamic>;
        List<Map<String, dynamic>> convertedlistResul =
            listResult1.map((e) => e as Map<String, dynamic>).toList();
        List<UserResult> userResultList = convertedlistResul.map((e) {
              final Timestamp timestampValue = e["date"];
              final DateTime dateTimeValue = timestampValue.toDate();
              UserResult u = UserResult(
                  id: e["id"],
                  userId: e["userId"],
                  correctAnswers: e["correctAnswers"],
                  date: dateTimeValue,
                  duration: e["duration"],
                  attempt: e["attempt"],
                  mode: e["mode"]);
              return u;
            }).toList();
        topic = Topic(
            id: data["id"],
            name: data["name"],
            listWords: wordList,
            mode: data["mode"],
            author: data["author"],
            userId: data["userId"],
            listUserResults: userResultList);
        return topic;
      }
      throw Exception("Không tìm thấy dữ liệu");
    } catch (e) {
      // ignore: avoid_print
      print("khong lay topic dc");
      // ignore: avoid_print
      print(e);
      return topic as Topic;
    }
  }
}
