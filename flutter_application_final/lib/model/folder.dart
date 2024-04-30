class Folder{
  String id;
  String name;
  String description;
  String userId;
  List<String> listTopicId = [];
  Folder({required this.id, required this.name, required this.userId, required this.description});

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "name": name,
      "description": description,
      "userId": userId,
      "listTopicId": listTopicId
    };
  }
}