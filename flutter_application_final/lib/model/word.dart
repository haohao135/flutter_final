class Word{
  String id;
  String term;
  String definition;
  String? pronunciation;
  String statusE;
  bool isStar;
  String topicId;
  // ignore: non_constant_identifier_names
  String? favorite_id;
  Word({required this.id, required this.term, required this.definition, this.pronunciation, required this.statusE, required this.isStar, required this.topicId});
  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "term": term,
      "definition": definition,
      "pronunciation": pronunciation,
      "statusE": statusE,
      "isStar": isStar,
      "topicId": topicId
    };
  }
}