import 'package:flutter_application_final/model/archievement.dart';
import 'package:flutter_application_final/model/word.dart';

class Users{
  late String id;
  late String email;
  late String name;
  late List<Archievement> listArchievement = [];
  late List<Word> listFavouriteWord = [];

  Users({required this.id, required this.email, required this.name});

  Map<String, dynamic> toJson(){
    List<Map<String, dynamic>> arJson = listArchievement.map((ar) => ar.toJson()).toList();
    List<Map<String, dynamic>> wJson = listFavouriteWord.map((word) => word.toJson()).toList();
    return {
      "id": id,
      "email": email,
      "name": name,
      "archievement": arJson,
      "listFavouriteWord": wJson
    };
  }
}