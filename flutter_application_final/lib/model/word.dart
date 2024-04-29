class Word{
  String id;
  String term;
  String definition;
  String? pronunciation;
  String statusE;
  // ignore: non_constant_identifier_names
  String? favorite_id;
  Word({required this.id, required this.term, required this.definition, this.pronunciation, required this.statusE});
}