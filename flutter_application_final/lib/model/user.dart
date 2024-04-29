import 'package:flutter_application_final/model/archievement.dart';

class Users{
  late String id;
  late String email;
  late String name;
  String? favoriteId;
  late List<Archievement> listArchievement = [];

  Users({required this.id, required this.email, required this.name});

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "email": email,
      "name": name,
      "favoriteId": favoriteId,
      "archievement": listArchievement
    };
  }
}