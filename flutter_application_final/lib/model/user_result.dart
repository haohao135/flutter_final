class UserResult {
  String id;
  String userId;
  int correctAnswers;
  DateTime date;
  int duration;
  String attempt;
  // ignore: non_constant_identifier_names
  UserResult(
      {required this.id,
      required this.userId,
      required this.correctAnswers,
      required this.date,
      required this.duration,
      required this.attempt});
}
