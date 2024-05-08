class Archievement{
  String id;
  String nameTopic;
  int rank;
  String userId;
  Archievement(this.id, this.nameTopic, this.rank, this.userId);
  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "nameTopic": nameTopic,
      "rank": rank,
      "userId": userId
    };
  }
}