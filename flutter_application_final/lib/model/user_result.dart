class UserResult {
  String id;
  String userId;
  int correctAnswers;
  DateTime date;
  bool mode;
  int duration;
  int attempt;
  UserResult(
      {required this.id,
      required this.userId,
      required this.correctAnswers,
      required this.date,
      required this.duration,
      required this.attempt, required this.mode});
  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "userId": userId,
      "correctAnswers": correctAnswers,
      "date": date,
      "duration": duration,
      "attempt": attempt,
      "mode": mode
    };
  }
}
