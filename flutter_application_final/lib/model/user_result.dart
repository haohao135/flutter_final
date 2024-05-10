class UserResult {
  String id;
  String userId;
  int correctAnswers;
  DateTime date;
  int duration;
  int attempt;
  // ignore: non_constant_identifier_names
  UserResult(
      {required this.id,
      required this.userId,
      required this.correctAnswers,
      required this.date,
      required this.duration,
      required this.attempt});
  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "userId": userId,
      "correctAnswers": correctAnswers,
      "date": date,
      "duration": duration,
      "attempt": attempt
    };
  }
}
