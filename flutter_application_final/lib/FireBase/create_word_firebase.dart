import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_final/model/word.dart';

class CreateWordFirebase{
  static Future<void> createWord(Word word) async{
    await FirebaseFirestore.instance.collection("words").add(word.toJson());
  }
}