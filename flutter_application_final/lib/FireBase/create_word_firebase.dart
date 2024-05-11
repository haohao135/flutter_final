import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_final/model/word.dart';

class CreateWordFirebase{
  static Future<void> createWord(Word word) async{
    await FirebaseFirestore.instance.collection("words").doc(word.id).set(word.toJson());
  }
  static Future<void> updateWord(Word word) async{
    try{
      await FirebaseFirestore.instance.collection("words").doc(word.id).update(word.toJson());
    } catch(e){
      // ignore: avoid_print
      print("khong cap nhat word dc");
      // ignore: avoid_print
      print(e);
    }
  }
  static Future<void> deleteWord(Word word)async{
    try{
      await FirebaseFirestore.instance.collection("words").doc(word.id).delete();
    } catch(e){
      // ignore: avoid_print
      print("khong xoa word dc");
      // ignore: avoid_print
      print(e);
    }
  }
}