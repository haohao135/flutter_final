import 'package:flutter_application_final/model/user_result.dart';
import 'package:flutter_application_final/model/word.dart';

class Topic{
  String id;
  String userId;
  String name;
  List<Word> listWords = [];
  bool mode;
  List<UserResult> listUserResults = [];
  String author;
  List<String> listFoldersId = [];
  Topic({required this.id, required this.name, required this.listWords, required this.mode, required this.author, required this.userId});
  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "userId": userId,
      "name": name,
      "listWords": listWords,
      "mode": mode,
      "listUserResults": listUserResults,
      "author": author,
      "listFoldersId": listFoldersId
    };
  }
}