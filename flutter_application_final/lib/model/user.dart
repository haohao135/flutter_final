import 'package:flutter_application_final/model/archievement.dart';
import 'package:flutter_application_final/model/word.dart';

class Users{
  late String id;
  late String email;
  late String name;
  String? favoriteId;
  late List<Archievement> listArchievement = [];
  late List<Word> listFavouriteWord = [];

  Users({required this.id, required this.email, required this.name});

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "email": email,
      "name": name,
      "favoriteId": favoriteId,
      "archievement": listArchievement,
      "listFavouriteWord": listFavouriteWord
    };
  }
}