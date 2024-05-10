import 'package:flutter_application_final/model/user_result.dart';
import 'package:flutter_application_final/model/word.dart';

class Topic{
  String id;
  String userId;
  String name;
  List<Word> listWords = [];
  bool mode;
  List<UserResult> listUserResults = [];
  String? author;
  List<String> listFoldersId = [];
  Topic({required this.id, required this.name, required this.listWords, required this.mode, required this.author, required this.userId});
  Map<String, dynamic> toJson(){
    List<Map<String, dynamic>> wordsJson = listWords.map((word) => word.toJson()).toList();
    List<Map<String, dynamic>> userResultJson = listUserResults.map((userReult) => userReult.toJson()).toList();
    return {
      "id": id,
      "userId": userId,
      "name": name,
      "listWords": wordsJson,
      "mode": mode,
      "listUserResults": userResultJson,
      "author": author,
      "listFoldersId": listFoldersId
    };
  }
}